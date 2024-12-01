from flask import Blueprint, render_template, request, redirect, url_for, flash, session
from app.models import get_all_events, register_user, get_event_details, test, login_user
from app.services.ai_services import generate_directions

bp = Blueprint('customer', __name__, url_prefix='/customer')

# User Registration
@bp.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        name = request.form['name']
        email = request.form['email']
        password = request.form['password']
        print(name, email, password)
        done = register_user(name, email, password)
        if done == "False":
            flash('User already registered. Please try with a different email/login.')
            return redirect(url_for('customer.register'))
        flash('Registration successful! Please log in.')
        return redirect(url_for('customer.login'))
    return render_template('customer/register.html')

# User Login
@bp.route('/login', methods=['GET', 'POST'])
def login():
    if 'user' in session:
        return redirect(url_for('customer.dashboard'))
    if request.method == 'POST':
        email = request.form['email']
        password = request.form['password']
        user = login_user(email, password)
        if user == "User not found":
            flash('User not found. Please register.')
            return redirect(url_for('customer.register'))
        if user == "Wrong Password":
            flash('Wrong Password. Please try again.')
            return redirect(url_for('customer.login'))
        session['user'] = user
        session['role'] = user['role']
        session['name'] = user['name']
        session['email'] = user['email']
        session['user_id'] = user['user_id']
        flash('Login successful!')
        return redirect(url_for('customer.dashboard'))
    return render_template('customer/login.html')

# User Logout
@bp.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('customer.login'))


# Customer Dashboard
@bp.route('/')
def dashboard():
    #events = get_all_events()
    testt = test()
    print(testt)
    return render_template('customer/dashboard.html', testt = testt) #, events=events


# Event Details
@bp.route('/event/<int:event_id>')
def event_details(event_id):
    event = get_event_details(event_id)
    return render_template('customer/event_details.html', event=event)

# Live Chat with LLM Assistance
@bp.route('/chat', methods=['POST'])
def live_chat():
    current_location = request.form['current_location']
    destination = request.form['destination']
    venue_data = {}  # Replace with actual venue data fetched from the database
    directions = generate_directions(current_location, destination, venue_data)
    return {'directions': directions}
