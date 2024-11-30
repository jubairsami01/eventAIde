from flask import Blueprint, render_template, request, redirect, url_for, flash
from app.models import get_all_events, register_user, get_event_details, test
from app.services.ai_services import generate_directions


bp = Blueprint('customer', __name__, url_prefix='/customer')

# Customer Dashboard
@bp.route('/')
def dashboard():
    #events = get_all_events()
    testt = test()
    print(testt)
    return render_template('customer/dashboard.html', testt = testt) #, events=events

# User Registration
@bp.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        name = request.form['name']
        email = request.form['email']
        password = request.form['password']
        register_user(name, email, password)
        flash('Registration successful! Please log in.')
        return redirect(url_for('customer.dashboard'))
    return render_template('customer/register.html')

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
