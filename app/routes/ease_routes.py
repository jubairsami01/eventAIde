from flask import Blueprint, render_template, request
from app.services.ai_services import generate_directions
from app.services.analytics_services import get_user_activity_data

bp = Blueprint('ease', __name__, url_prefix='/ease')

# AI Navigation Assistance
@bp.route('/navigate', methods=['POST'])
def navigate():
    current_location = request.form['current_location']
    destination = request.form['destination']
    venue_data = {}  # Replace with actual venue data fetched from the database
    directions = generate_directions(current_location, destination, venue_data)
    return {'directions': directions}

# Virtual Event Preview
@bp.route('/virtual_preview')
def virtual_preview():
    # Replace with logic to fetch and render virtual venue data
    venue_data = {}  # Placeholder for venue details
    return render_template('ease/virtual_preview.html', venue_data=venue_data)

# User Activity Analytics
@bp.route('/activity_analytics')
def activity_analytics():
    user_activity_data = get_user_activity_data()
    return render_template('ease/activity_analytics.html', analytics=user_activity_data)

# Accessibility Features
@bp.route('/accessibility')
def accessibility():
    return render_template('ease/accessibility.html')
