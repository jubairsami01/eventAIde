from flask import Blueprint, render_template, request, redirect, url_for, flash, session
from app.models import get_all_events, create_event_draft, get_users_events, get_event_draft, update_event_draft, add_cohost_db, get_cohosts, remove_cohost_db, get_user_by_id, delete_event_db, add_venue_db, update_venue_db, get_event_venue, get_venue_details, show_all_venues, add_event_venue_db, update_event_venue_db, delete_event_venue_db
#from app.models import get_event_by_id, update_event
from app.tools import string_to_json, json_to_string

bp = Blueprint('management', __name__, url_prefix='/management')

@bp.route('/')
def dashboard():
    events = get_users_events(session['user_id'])
    return render_template('management/dashboard.html', events=events)

@bp.route('/draft_event', methods=['GET', 'POST'])
def draft_event():
    if 'user_id' not in session:
        flash('Please log in to draft an event.')
        return redirect(url_for('customer.login'))
    if request.method == 'POST':
        name = request.form['name']
        description = request.form['description']
        start_time = request.form['start_time']
        end_time = request.form['end_time']
        create_event_draft(name, description, start_time, end_time, session['user_id'], session['user_id'])
        flash('Event drafted successfully! Now add more information to publish it from the management dashboard.')
        return redirect(url_for('management.dashboard'))
    return render_template('management/draft_event.html')

@bp.route('/edit_event/<event_id>', methods=['GET', 'POST'])
def edit_event(event_id): 
    if 'user_id' not in session:
        flash('Please log in to edit an event.')
        return redirect(url_for('customer.login'))
    drafted_event = get_event_draft(event_id)
    #print(drafted_event)
    cohosts = get_cohosts(event_id)
    last_updated_by = get_user_by_id(drafted_event['last_updated_by'])
    event_venue = get_event_venue(event_id)
    if event_venue:
        event_venue['customized_details'] = json_to_string(event_venue['customized_details'])
        event_venue['details_json'] = json_to_string(event_venue['details_json'])
    all_venues = show_all_venues()
    #print("evnent_venue", event_venue)
    
    if request.method == 'POST':
        name = request.form['name']
        description = request.form['description']
        start_time = request.form['start_time']
        end_time = request.form['end_time']
        update_event_draft(event_id, name, description, start_time, end_time, session['user_id'])
        flash('Event updated successfully!')
        return redirect(url_for('management.edit_event', event_id=event_id))
    return render_template('management/edit_event.html', drafted_event=drafted_event, cohosts=cohosts, last_updated_by=last_updated_by, event_venue=event_venue, all_venues=all_venues)

@bp.route('/delete_event/<event_id>')
def delete_event(event_id):
    delete_event_db(event_id)
    flash('Event deleted successfully!')

@bp.route('/add_cohost/<event_id>', methods=['GET', 'POST'])
def add_cohost(event_id):
    if 'user_id' not in session:
        flash('Please log in to add a cohost.')
        return redirect(url_for('customer.login'))
    if request.method == 'POST':
        email = request.form['cohost_email']
        temp = add_cohost_db(event_id, email, session['user_id'])
        flash(temp)
    return redirect(url_for('management.edit_event', event_id=event_id))

@bp.route('/remove_cohost/<event_id>/<email>')
def remove_cohost(event_id, email):
    temp = remove_cohost_db(event_id, email)
    flash(temp)
    return redirect(url_for('management.edit_event', event_id=event_id))

@bp.route('/add_venue', methods=['GET', 'POST'])
def add_venue():
    if 'user_id' not in session:
        flash('Please log in to add a venue.')
        return redirect(url_for('customer.login'))

    if request.method == 'POST':
        name = request.form['name']
        location_data = request.form['location_data']
        address = request.form['address']
        details_json = request.form['details_json']
        details_json = string_to_json(details_json)
        flashed = add_venue_db(name, location_data, address, details_json)
        flash(flashed)
    return render_template('management/add_venue.html')

@bp.route('/edit_venue/<venue_id>', methods=['GET', 'POST'])
def edit_venue(venue_id):
    if 'user_id' not in session:
        flash('Please log in to edit a venue.')
        return redirect(url_for('customer.login'))
    venue = get_venue_details(venue_id)
    venue['details_json'] = json_to_string(venue['details_json'])
    if request.method == 'POST':
        name = request.form['name']
        location_data = request.form['location_data']
        address = request.form['address']
        details_json = request.form['details_json']
        details_json = string_to_json(details_json)
        flashed = update_venue_db(venue_id, name, location_data, address, details_json)
        flash(flashed)
        return redirect(url_for('management.edit_venue', venue_id=venue_id))
    return render_template('management/edit_venue.html', venue=venue) 

@bp.route('/add_event_venue/<event_id>/<venue_id>', methods=['GET', 'POST'])
@bp.route('/add_event_venue/<event_id>/', methods=['GET', 'POST'])
def add_event_venue(event_id, venue_id=None):
    if request.method == 'POST':
        # If venue_id is None, try to get it from form data
        if venue_id is None:
            venue_id = request.form.get('venue_id')
            
        flashed = add_event_venue_db(event_id, venue_id)
        flash(flashed)
        return redirect(url_for('management.edit_event', event_id=event_id))
    
    # Handle GET request if needed
    return redirect(url_for('management.edit_event', event_id=event_id))

@bp.route('/update_event_venue/<event_id>', methods=['GET', 'POST'])
def update_event_venue(event_id):
    if request.method == 'POST':
        customized_details = request.form['customized_details']
        customized_details = string_to_json(customized_details)
        flashed = update_event_venue_db(event_id, customized_details)
        flash(flashed)
        return redirect(url_for('management.edit_event', event_id=event_id))
    return redirect(url_for('management.edit_event', event_id=event_id))

@bp.route('/delete_event_venue/<event_id>', methods=['GET', 'POST'])
def delete_event_venue(event_id):
    flashed = delete_event_venue_db(event_id)
    flash(flashed)
    return redirect(url_for('management.edit_event', event_id=event_id))

#analyze from the follwoing
"""
    event = get_event_by_id(event_id)
    if event is None:
        flash('Event not found.')
        return redirect(url_for('management.dashboard'))

    if request.method == 'POST':
        name = request.form['name']
        description = request.form['description']
        start_time = request.form['start_time']
        end_time = request.form['end_time']
        venue = request.form['venue']
        update_event(event_id, name, description, start_time, end_time, venue)
        flash('Event updated successfully!')
        return redirect(url_for('management.dashboard'))

    return render_template('management/edit_event.html', event=event)
    return render_template('management/edit_event.html')
"""