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
    if not user:
        return "User not found"
    if not check_password_hash(user['password'], password):
        return "Wrong Password"
    if user and check_password_hash(user['password'], password):
        return user
    

def create_event_draft(name, description, start_date, end_date, created_by, last_updated_by):
    cursor = mysql.connection.cursor()
    cursor.execute(
        "INSERT INTO Events (name, description, start_date, end_date, created_by) VALUES (%s, %s, %s, %s, %s, %s)",
        (name, description, start_date, end_date, created_by, last_updated_by),
    )
    mysql.connection.commit()
    cursor.close()

def update_event_draft(event_id, name, description, start_date, end_date, last_updated_by):
    cursor = mysql.connection.cursor()
    cursor.execute(
        "UPDATE Events SET name = %s, description = %s, start_date = %s, end_date = %s, last_updated_by = %s WHERE event_id = %s",
        (name, description, start_date, end_date, last_updated_by, event_id),
    )
    mysql.connection.commit()
    cursor.close()
    return "Event updated successfully!"

def get_event_draft(event_id):
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT * FROM Events WHERE event_id = %s", (event_id,))
    event = cursor.fetchone()
    cursor.close()
    return event

def add_cohost(event_id, email, added_by):
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT user_id FROM Users WHERE email = %s", (email,))
    cohost = cursor.fetchone()
    if not cohost:
        cursor.close()
        return "User not found!"
    cursor.execute(
        "INSERT INTO CoHosts (event_id, user_id, added_by) VALUES (%s, %s, %s)",
        (event_id, cohost['user_id'], added_by), #might be error here
    )
    mysql.connection.commit()
    cursor.close()
    return "Cohost added successfully!"

def get_cohosts(event_id):
    cursor = mysql.connection.cursor()
    cursor.execute(
        "SELECT Users.name, Users.email FROM CoHosts JOIN Users ON CoHosts.user_id = Users.user_id WHERE CoHosts.event_id = %s",
        (event_id,),
    )
    cohosts = cursor.fetchall()
    cursor.close()
    return cohosts

def remove_cohost(event_id, email):
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT user_id FROM Users WHERE email = %s", (email,))
    cohost = cursor.fetchone()
    if not cohost:
        cursor.close()
        return "User not found!"
    cursor.execute(
        "DELETE FROM CoHosts WHERE event_id = %s AND user_id = %s",
        (event_id, cohost['user_id']), #might be error here
    )
    mysql.connection.commit()
    cursor.close()
    return "Cohost removed successfully!"


def get_users_events(user_id):
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT * FROM Events WHERE created_by = %s", (user_id,))
    events = cursor.fetchall()
    cursor.close()
    return events

def add_venue(name, location_data, address, details_json):
    cursor = mysql.connection.cursor()
    cursor.execute(
        "INSERT INTO Venues (name, location_data, address, details_json) VALUES (%s, %s, %s, %s)",
        (name, location_data, address, details_json),
    )
    mysql.connection.commit()
    cursor.close()

def get_venue_details(venue_id):
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT * FROM Venues WHERE venue_id = %s", (venue_id,))
    venue = cursor.fetchone()
    cursor.close()
    return venue

def modify_venue(venue_id, name, location_data, address, details_json):
    cursor = mysql.connection.cursor()
    cursor.execute(
        "UPDATE Venues SET name = %s, location_data = %s, address = %s, details_json = %s WHERE venue_id = %s",
        (name, location_data, address, details_json, venue_id),
    )
    mysql.connection.commit()
    cursor.close()

def show_all_venues():
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT name, venue_id FROM Venues")
    venues = cursor.fetchall()
    cursor.close()
    return venues


#def add ticket

def get_all_events():
    """Retrieve all events from the database."""
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT * FROM events")
    events = cursor.fetchall()
    cursor.close()
    return events




def test():
    cursor = mysql.connection.cursor()
    cursor.execute("select * from testsample")
    testt = cursor.fetchall()
    cursor.close()
    return testt