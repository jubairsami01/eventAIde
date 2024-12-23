from flask import Blueprint, render_template, request, redirect, url_for, flash, session
from app.models import get_event_venue, get_venue_details, save_chat_message, get_chat_history, get_session_details, get_last_registration_id, save_transaction_details, update_user, view_registration_info, get_registered_events, isregistered_event_session, register_user, test, login_user, get_users_events, show_all_venues, get_event_details_for_customer_db, get_event_sessions_db, register_for_event_db, unregister_for_event_db, add_feedback_db, delete_feedback_db, update_feedback_db, show_all_feedbacks, load_existing_feedback
from app.services.ai_services import generate_directions
from app.tools import llm_response

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
        feedback = load_existing_feedback(session['user_id'], event_id)
        for s in sessions:
            s['is_registered'] = isregistered_event_session(event_id, session['user_id'], s['session_id'])
        return render_template('customer/view_event_details.html', event=event, sessions=sessions, feedback=feedback)
    return render_template('customer/view_event_details.html', event=event, sessions=sessions)
@bp.route('/register_for_event/<event_id>/<session_id>', methods=['GET', 'POST'])
def register_for_event(event_id, session_id):
    if 'user_id' not in session:
        flash('Please log in to register for an event.')
        return redirect(url_for('customer.login'))
    #sessions = get_event_sessions_db(event_id)
    session_details = get_session_details(session_id)
    if request.method == 'POST':
        payment_method = request.form['payment_method']
        transaction_id = request.form['transaction_id']
        registration_fee = session_details['registration_fee']

        flashed = register_for_event_db(event_id, session['user_id'], session_id)
        registration_id = get_last_registration_id()
        transaction = save_transaction_details(event_id, registration_id, session_id, payment_method, transaction_id, registration_fee)
        flash(transaction)
        flash(flashed)
        return redirect(url_for('customer.view_event_details', event_id=event_id))
    return render_template('customer/register_for_event.html', session_details=session_details)

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


# Chatbot

from functools import wraps
from typing import Dict, Any
import logging
from datetime import datetime
from flask import jsonify, session, request
from werkzeug.exceptions import HTTPException
from cachetools import TTLCache
from flask_limiter import Limiter
from flask_limiter.util import get_remote_address

# Custom exceptions
class ChatException(Exception):
    def __init__(self, message: str, status_code: int = 500):
        self.message = message
        self.status_code = status_code
        super().__init__(message)

# Cache setup
event_details_cache = TTLCache(maxsize=100, ttl=300)  # 5 min cache = 300 seconds

# Rate limiter
limiter = Limiter(
    key_func=get_remote_address,
    default_limits=["100 per minute"]
)

# Error handler decorator
def handle_errors(f):
    @wraps(f)
    def wrapped(*args, **kwargs):
        try:
            return f(*args, **kwargs)
        except ChatException as e:
            logging.error(f"Chat error: {str(e)}")
            return jsonify({'error': e.message}), e.status_code
        except HTTPException as e:
            logging.error(f"HTTP error: {str(e)}")
            return jsonify({'error': str(e)}), e.code
        except Exception as e:
            logging.error(f"Unexpected error: {str(e)}")
            return jsonify({'error': 'Internal server error'}), 500
    return wrapped

def get_cached_event_details(event_id: str) -> Dict[str, Any]:
    """Get event details with caching"""
    cache_key = f"event_{event_id}"
    if cache_key in event_details_cache:
        return event_details_cache[cache_key]
    
    event_details = get_event_details_for_customer_db(event_id)
    sessions = get_event_sessions_db(event_id)
    event_venue = get_event_venue(event_id)
    venue_details = get_venue_details(event_venue['venue_id'])
    
    
    details = {
        'event_details': event_details,
        'sessions': sessions,
        'venue_details': venue_details,
        'event_venue': event_venue,
        'customized_details': event_venue.get('customized_details', {})
    }
    event_details_cache[cache_key] = details
    return details

@bp.route('/chat/<event_id>', methods=['GET', 'POST'])
@limiter.limit("30 per minute")  # Rate limit per user
@handle_errors
def chat(event_id: str):
    # Validate user session
    if 'user_id' not in session:
        raise ChatException('User not logged in', 401)
    
    if not event_id:
        raise ChatException('Invalid event ID', 400)

    user_id = session['user_id']

    # Handle GET request
    if request.method == 'GET':
        previous_messages = get_chat_history(user_id, event_id)
        return jsonify(previous_messages), 200

    # Handle POST request
    data = request.get_json()
    if not data or not data.get('message'):
        raise ChatException('Missing message', 400)

    user_message = data['message'].strip()
    if not user_message:
        raise ChatException('Empty message', 400)

    # Save user message
    save_chat_message(user_id, event_id, user_message, 'user')

    # Get cached event details
    event_info = get_cached_event_details(event_id)

    # Prepare LLM input
    llm_input = {
        **event_info,
        'chat_history': get_chat_history(user_id, event_id),
        'new_message_to_response': user_message
    }
    #print(llm_input)
    # Generate and save LLM response
    llm_reply = llm_response(llm_input)
    save_chat_message(user_id, event_id, llm_reply, 'llm')

    return jsonify({
        'response': llm_reply,
        'timestamp': datetime.now().isoformat()
    }), 200


@bp.route('/add_feedback/<event_id>', methods=['GET', 'POST'])
def add_feedback(event_id):
    if 'user_id' not in session:
        flash('Please log in to register for an event.')
        return redirect(url_for('customer.login'))
    if request.method == 'POST':
        rating = request.form['rating']
        comment = request.form.get('comment', None)
        user_id = session['user_id']
        
        existing_feedback = load_existing_feedback(user_id, event_id)
        if existing_feedback:
            feedback_message = update_feedback_db(user_id, event_id, rating, comment)
        else:
            feedback_message = add_feedback_db(user_id, event_id, rating, comment)
        
        flash(feedback_message)
    return redirect(url_for('customer.view_event_details', event_id=event_id))








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