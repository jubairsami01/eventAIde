from flask import Blueprint, render_template, request, redirect, url_for, flash

bp = Blueprint('home', __name__, url_prefix='')

@bp.route('/')
def home():
    return render_template('base.html')