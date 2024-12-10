from flask import Blueprint, render_template, request, redirect, url_for, flash
from app.models import get_all_published_events
bp = Blueprint('home', __name__, url_prefix='')

@bp.route('/')
def home():
    published_events = get_all_published_events()
    return render_template('home.html', published_events=published_events)


