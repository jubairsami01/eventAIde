from app import mysql
from werkzeug.security import generate_password_hash, check_password_hash
from flask_login import UserMixin

# Example database interaction

def register_user(name, email, password):
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT * FROM Users WHERE email = %s", (email,))
    existing_user = cursor.fetchone()
    if existing_user:
        cursor.close()
        return "False"
    hashed_password = generate_password_hash(password)
    cursor.execute(
        "INSERT INTO Users (name, email, password, role) VALUES (%s, %s, %s, %s)",
        (name, email, hashed_password, "customer"),
    )
    mysql.connection.commit()
    cursor.close()
    return "True"

def login_user(email, password):
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT * FROM Users WHERE email = %s", (email,))
    user = cursor.fetchone()
    cursor.close()
    if user and check_password_hash(user['password'], password):
        return user
    return None


def get_all_events():
    """Retrieve all events from the database."""
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT * FROM events")
    events = cursor.fetchall()
    cursor.close()
    return events

def create_event(name, venue, date):
    """Insert a new event into the database."""
    cursor = mysql.connection.cursor()
    cursor.execute(
        "INSERT INTO events (name, venue, date) VALUES (%s, %s, %s)",
        (name, venue, date),
    )
    mysql.connection.commit()
    cursor.close()

def get_event_details(event_id):
    """Retrieve details for a specific event."""
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT * FROM events WHERE id = %s", (event_id,))
    event = cursor.fetchone()
    cursor.close()
    return event


def test():
    cursor = mysql.connection.cursor()
    cursor.execute("select * from testsample")
    testt = cursor.fetchall()
    cursor.close()
    return testt