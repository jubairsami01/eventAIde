from flask import Blueprint, render_template, request, redirect, url_for, flash, session
from app.models import update_user, view_registration_info, get_registered_events, isregistered_event_session, register_user, test, login_user, get_users_events, show_all_venues, get_event_details_for_customer_db, get_event_sessions_db, register_for_event_db, unregister_for_event_db
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

@bp.route('/my_profile', methods=['GET', 'POST'])
def my_profile():
    if 'user' not in session:
        flash('Please log in to view your profile.')
        return redirect(url_for('customer.login'))
    if request.method == 'POST':
        name = request.form['name']
        email = request.form['email']
        password = request.form['password']
        user_id = session['user_id']
        result = update_user(user_id, name, email, password)
        flash(result)
        return redirect(url_for('customer.my_profile'))
        
    return render_template('customer/my_profile.html')

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
    event = get_event_details_for_customer_db(event_id)
    sessions = get_event_sessions_db(event_id)
    if 'user_id' in session:
        for s in sessions:
            s['is_registered'] = isregistered_event_session(event_id, session['user_id'], s['session_id'])
    return render_template('customer/view_event_details.html', event=event, sessions=sessions)

@bp.route('/register_for_event/<event_id>/<session_id>', methods=['GET', 'POST'])
def register_for_event(event_id, session_id):
    if 'user_id' not in session:
        flash('Please log in to register for an event.')
        return redirect(url_for('customer.login'))
    sessions = get_event_sessions_db(event_id)
    if request.method == 'POST':
        #session_id = request.form['session_id']
        flashed = register_for_event_db(event_id, session['user_id'], session_id)
        flash(flashed)
        return redirect(url_for('customer.view_event_details', event_id=event_id))
    return redirect(url_for('customer.view_event_details', event_id=event_id))

@bp.route('/unregister_for_event/<event_id>/<session_id>', methods=['GET', 'POST'])
def unregister_for_event(event_id, session_id):
    if 'user_id' not in session:
        flash('Please log in to unregister for an event.')
        return redirect(url_for('customer.login'))
    
    if request.method == 'POST':
        #session_id = request.form['session_id']
        flashed = unregister_for_event_db(event_id, session['user_id'], session_id)
        flash(flashed)
    return redirect(url_for('customer.view_event_details', event_id=event_id))

@bp.route('/registered_events')
def registered_events():
    if 'user_id' not in session:
        flash('Please log in to view your events.')
        return redirect(url_for('customer.login'))
    events = get_registered_events(session['user_id'])
    return render_template('customer/registered_events.html', events=events)

@bp.route('/view_ticket/<event_id>/<session_id>')
def view_ticket(event_id, session_id):
    if 'user_id' not in session:
        flash('Please log in to view your ticket.')
        return redirect(url_for('customer.login'))
    event = get_event_details_for_customer_db(event_id)
    registration_info_detailed = view_registration_info(event_id, session['user_id'], session_id)
    registration_info = registration_info_detailed[0]
    session_info = registration_info_detailed[1]
    
    return render_template('customer/view_ticket.html', event=event, registration_info=registration_info, session_info=session_info)




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
"""
@bp.route('/api/my_events', methods=['GET'])
def api_my_events():
    
    events = get_users_events(3)
    return {'events': events}, 200




@bp.route('/api/view_event_details/<event_id>', methods=['GET'])
def api_view_event_details(event_id):
    event = get_event_details_for_customer_db(event_id)
    sessions = get_event_sessions_db(event_id)
    
    for s in sessions:
        s['is_registered'] = isregistered_event_session(event_id, 3, s['session_id'])
    return {'event': event, 'sessions': sessions}, 200





@bp.route('/api/registered_events', methods=['GET'])
def api_registered_events():
    
    events = get_registered_events(3)
    return {'events': events}, 200



@bp.route('/api/view_ticket/<event_id>/<session_id>', methods=['GET'])
def api_view_ticket(event_id, session_id):
    
    event = get_event_details_for_customer_db(event_id)
    registration_info_detailed = view_registration_info(event_id, 3, session_id)
    registration_info = registration_info_detailed[0]
    session_info = registration_info_detailed[1]
    return {'event': event, 'registration_info': registration_info, 'session_info': session_info}, 200

"""