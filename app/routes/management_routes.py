from flask import Blueprint, render_template, request, redirect, url_for, flash, session
from app.models import get_all_events, create_event_draft, get_users_events
from app.models import get_event_by_id, update_event

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
        create_event_draft(name, description, start_time, end_time, session['user_id'])
        flash('Event drafted successfully! Now add more information to publish it from the management dashboard.')
        return redirect(url_for('management.dashboard'))
    return render_template('management/draft_event.html')

@bp.route('/edit_event/<event_id>', methods=['GET', 'POST'])
def edit_event(event_id): 
    if 'user_id' not in session:
        flash('Please log in to edit an event.')
        return redirect(url_for('customer.login'))
#analyze from the follwoing
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
