from flask import Blueprint, render_template, request, redirect, url_for, flash
from app.models import get_all_events, create_event

bp = Blueprint('management', __name__, url_prefix='/management')

@bp.route('/')
def dashboard():
    events = get_all_events()
    return render_template('management/dashboard.html', events=events)

@bp.route('/create_event', methods=['POST'])
def create_event_route():
    name = request.form['name']
    venue = request.form['venue']
    date = request.form['date']
    create_event(name, venue, date)
    flash('Event created successfully!')
    return redirect(url_for('management.dashboard'))
