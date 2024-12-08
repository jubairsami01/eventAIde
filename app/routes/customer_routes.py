from flask import Blueprint, render_template, request, redirect, url_for, flash, session
from app.models import register_user, test, login_user, get_users_events, show_all_venues
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
        return redirect(url_for('home.home'))
    return render_template('customer/login.html')

@bp.route('/my_events', methods=['GET', 'POST'])
def my_events():
    if 'user' not in session:
        flash('Please log in to view your events.')
        return redirect(url_for('customer.login'))
    events = get_users_events(session['user_id'])
    return render_template('customer/my_events.html', events=events)

@bp.route('/update_existing_venues/', methods=['GET', 'POST'])
def update_existing_venues():
    if 'user' not in session:
        flash('Please log in to view your events.')
        return redirect(url_for('customer.login'))
    venues = show_all_venues()
    return render_template('customer/update_existing_venues.html', venues=venues)

# User Logout
@bp.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('customer.login'))

@bp.route('/view_event_details/<event_id>')
def view_event_details(event_id):
    event = get_event(event_id)
    return render_template('customer/view_event_details.html', event=event)







# Customer Dashboard
@bp.route('/')
def dashboard():
    #events = get_all_events()
    testt = test()
    print(testt)
    return render_template('customer/dashboard.html', testt = testt) #, events=events




# Live Chat with LLM Assistance
@bp.route('/chat', methods=['POST'])
def live_chat():
    current_location = request.form['current_location']
    destination = request.form['destination']
    venue_data = {}  # Replace with actual venue data fetched from the database
    directions = generate_directions(current_location, destination, venue_data)
    return {'directions': directions}


#lab assignment:
#make json api