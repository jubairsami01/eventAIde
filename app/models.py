from app import mysql
from werkzeug.security import generate_password_hash, check_password_hash
from flask_login import UserMixin
from flask import session

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
    
def update_user(user_id, name, email, password):
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT * FROM Users WHERE user_id = %s", (user_id,))
    user = cursor.fetchone()  ###
    if not check_password_hash(user['password'], password):
        return "Wrong Password, Please try again!"

    cursor.execute("SELECT * FROM Users WHERE email = %s", (email,))
    existing_user = cursor.fetchone()
    if existing_user and existing_user['user_id'] != user['user_id']:
        cursor.close()
        return "Another account with this Email already exists!"

    cursor.execute(
        "UPDATE Users SET name = %s, email = %s WHERE user_id = %s",
        (name, email, user_id),
    )
    mysql.connection.commit()
    cursor.close()
    session['name'] = name
    session['email'] = email
    return "Info updated successfully!"

def create_event_draft(name, description, start_date, end_date, created_by, last_updated_by):
    cursor = mysql.connection.cursor()
    cursor.execute(
        "INSERT INTO Events (name, description, start_date, end_date, created_by, last_updated_by) VALUES (%s, %s, %s, %s, %s, %s)",
        (name, description, start_date, end_date, created_by, last_updated_by),
    )
    mysql.connection.commit()
    cursor.execute("UPDATE Users SET role = 'both' WHERE user_id = %s", (created_by,))
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

def delete_event_db(event_id):
    cursor = mysql.connection.cursor()
    cursor.execute("DELETE FROM Events WHERE event_id = %s", (event_id,))
    mysql.connection.commit()
    cursor.close()

def get_event_draft(event_id):
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT * FROM Events WHERE event_id = %s", (event_id,))
    event = cursor.fetchone()
    cursor.close()
    return event

def add_cohost_db(event_id, email, added_by):
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT user_id FROM Users WHERE email = %s", (email,))
    cohost = cursor.fetchone()
    if not cohost:
        cursor.close()
        return "User not found! Please input a registered user's email."

    cursor.execute("SELECT * FROM CoHosts WHERE event_id = %s and user_id = %s", (event_id, cohost['user_id']))
    temp = cursor.fetchone()
    if temp:
        cursor.close()
        return "Cohost already added!"    
    #print(cohost)
    
    cursor.execute(
        "INSERT INTO CoHosts (event_id, user_id, added_by) VALUES (%s, %s, %s)",
        (event_id, cohost['user_id'], added_by), #might be error here, no error found
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

def remove_cohost_db(event_id, email):
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
    cursor.execute("SELECT DISTINCT Events.* FROM Events LEFT JOIN CoHosts ON Events.event_id = CoHosts.event_id WHERE Events.created_by = %s OR CoHosts.user_id = %s", (user_id, user_id))
    events = cursor.fetchall()
    cursor.close()
    return events

def add_venue_db(name, location_data, address, details_json):
    cursor = mysql.connection.cursor()
    cursor.execute(
        "INSERT INTO Venues (name, location_data, address, details_json) VALUES (%s, %s, %s, %s)",
        (name, location_data, address, details_json),
    )
    mysql.connection.commit()
    cursor.close()
    return "Venue added successfully!"

def get_venue_details(venue_id):
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT * FROM Venues WHERE venue_id = %s", (venue_id,))
    venue = cursor.fetchone()
    cursor.close()
    return venue

def show_all_venues():
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT name, venue_id, address FROM Venues")
    venues = cursor.fetchall()
    cursor.close()
    return venues

def update_venue_db(venue_id, name, location_data, address, details_json):
    cursor = mysql.connection.cursor()
    cursor.execute(
        "UPDATE Venues SET name = %s, location_data = %s, address = %s, details_json = %s WHERE venue_id = %s",
        (name, location_data, address, details_json, venue_id),
    )
    mysql.connection.commit()
    cursor.close()
    return "Venue updated successfully!"

def get_event_venue(event_id):
    cursor = mysql.connection.cursor()
    cursor.execute(
    "SELECT ev.event_id, ev.venue_id, v.name, v.address, v.location_data, v.details_json, ev.customized_details "
    "FROM Event_Venue ev "
    "JOIN Venues v ON ev.venue_id = v.venue_id "
    "WHERE ev.event_id = %s",
    (event_id,)
    )
    event_venue = cursor.fetchone()
    cursor.close()
    return event_venue

def add_event_venue_db(event_id, venue_id):
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT details_json FROM Venues WHERE venue_id = %s", (venue_id,))
    customized_details = cursor.fetchone()

    cursor.execute(
        "INSERT INTO Event_Venue (event_id, venue_id, customized_details) VALUES (%s, %s, %s)",
        (event_id, venue_id, customized_details['details_json']),
    )
    mysql.connection.commit()
    cursor.close()
    return "Venue added successfully!"

def update_event_venue_db(event_id, customized_details):
    cursor = mysql.connection.cursor()
    cursor.execute(
        "UPDATE Event_Venue SET customized_details = %s WHERE event_id = %s",
        (customized_details, event_id),
    )
    mysql.connection.commit()
    cursor.close()
    return "Venue details updated successfully!"

def delete_event_venue_db(event_id):
    cursor = mysql.connection.cursor()
    cursor.execute("DELETE FROM Event_Venue WHERE event_id = %s", (event_id,))
    mysql.connection.commit()
    cursor.close()
    return "Venue removed successfully!"

def add_session_db(event_id, name, description, start_time, end_time, capacity):
    cursor = mysql.connection.cursor()
    cursor.execute(
        "INSERT INTO Sessions (event_id, name, description, start_time, end_time, capacity) VALUES (%s, %s, %s, %s, %s, %s)",
        (event_id, name, description, start_time, end_time, capacity),
    )
    mysql.connection.commit()
    cursor.close()
    return "Session added successfully!"

def update_session_db(session_id, name, description, start_time, end_time, capacity):
    cursor = mysql.connection.cursor()
    cursor.execute(
        "UPDATE Sessions SET name = %s, description = %s, start_time = %s, end_time = %s, capacity = %s WHERE session_id = %s",
        (name, description, start_time, end_time, capacity, session_id),
    )
    mysql.connection.commit()
    cursor.close()
    return "Session updated successfully!"

def delete_session_db(session_id):
    cursor = mysql.connection.cursor()
    cursor.execute("DELETE FROM Sessions WHERE session_id = %s", (session_id,))
    mysql.connection.commit()
    cursor.close()
    return "Session deleted successfully!"

def get_event_sessions_db(event_id):
    cursor = mysql.connection.cursor()
    query = """
    SELECT 
        s.*,
        (SELECT COUNT(*) FROM Registrations r WHERE r.session_id = s.session_id) AS number_of_registrations
    FROM Sessions s
    WHERE s.event_id = %s
    ORDER BY s.start_time ASC, s.end_time ASC
    """
    cursor.execute(query, (event_id,))
    sessions = cursor.fetchall()
    cursor.close()
    return sessions

def publish_event_db(event_id): #used in homepage
    cursor = mysql.connection.cursor()
    cursor.execute("UPDATE Events SET visibility = 'public' WHERE event_id = %s", (event_id,))
    mysql.connection.commit()
    cursor.close()
    return "Event published successfully!"

def unpublish_event_db(event_id):
    cursor = mysql.connection.cursor()
    cursor.execute("UPDATE Events SET visibility = 'private' WHERE event_id = %s", (event_id,))
    mysql.connection.commit()
    cursor.close()
    return "Event unpublished successfully!"

def set_event_status_db(event_id, status):
    cursor = mysql.connection.cursor()
    cursor.execute("UPDATE Events SET status = %s WHERE event_id = %s", (status, event_id))
    mysql.connection.commit()
    cursor.close()
    return "Event status updated successfully!"

def get_all_published_events():
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT * FROM events where visibility = 'public'")
    events = cursor.fetchall()
    cursor.close()
    return events

def get_user_by_id(user_id):
    """Retrieve a user by their unique ID."""
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT user_id, name, email, role FROM Users WHERE user_id = %s", (user_id,))
    user = cursor.fetchone()
    cursor.close()
    return user

def get_event_details_for_customer_db(event_id):
    """Retrieve detailed event information including venue and counts."""
    cursor = mysql.connection.cursor()
    query = """
    SELECT 
        e.event_id,
        e.name AS event_name,
        e.description,
        e.start_date,
        e.end_date,
        e.created_by,
        e.status,
        e.created_at,
        e.updated_at,
        e.last_updated_by,
        v.name AS venue_name,
        v.address AS venue_address,
        v.location_data AS venue_location_data,
        (SELECT COUNT(*) FROM Registrations r WHERE r.event_id = e.event_id) AS number_of_registrations,
        (SELECT COUNT(*) FROM Sessions s WHERE s.event_id = e.event_id) AS number_of_sessions
    FROM Events e
    LEFT JOIN Event_Venue ev ON e.event_id = ev.event_id
    LEFT JOIN Venues v ON ev.venue_id = v.venue_id
    WHERE e.event_id = %s
    """
    cursor.execute(query, (event_id,))
    event = cursor.fetchone()
    created_by = get_user_by_id(event['created_by'])
    last_updated_by = get_user_by_id(event['last_updated_by'])
    event['created_by'] = created_by['name']
    event['last_updated_by'] = last_updated_by['name']
    cursor.close()
    return event

def register_for_event_db(event_id, user_id, session_id):
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT * FROM Registrations WHERE user_id = %s AND event_id = %s AND session_id = %s", (user_id, event_id, session_id))
    existing_registration = cursor.fetchone()
    if existing_registration:
        cursor.close()
        return "You are already registered for the selected session of this event!"
    cursor.execute("SELECT capacity FROM Sessions WHERE session_id = %s", (session_id,))
    session = cursor.fetchone()
    cursor.execute("SELECT COUNT(*) AS count FROM Registrations WHERE session_id = %s", (session_id,))
    registrations = cursor.fetchone()
    if registrations['count'] >= session['capacity']:
        cursor.close()
        return "Session is full! Please select another session."
    cursor.execute(
        "INSERT INTO Registrations (event_id, user_id, session_id) VALUES (%s, %s, %s)",
        (event_id, user_id, session_id),
    )
    mysql.connection.commit()
    cursor.close()
    return "Registration successful!"

def unregister_for_event_db(event_id, user_id, session_id):
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT * FROM Registrations WHERE user_id = %s AND event_id = %s AND session_id = %s", (user_id, event_id, session_id))
    existing_registration = cursor.fetchone()
    if not existing_registration:
        cursor.close()
        return "You are not registered for the selected session of this event!"
    cursor.execute(
        "DELETE FROM Registrations WHERE user_id = %s AND event_id = %s AND session_id = %s",
        (user_id, event_id, session_id),
    )
    mysql.connection.commit()
    cursor.close()
    return "Unregistration successful!"

def isregistered_event_session(event_id, user_id, session_id):
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT * FROM Registrations WHERE user_id = %s AND event_id = %s AND session_id = %s", (user_id, event_id, session_id))
    existing_registration = cursor.fetchone()
    if existing_registration:
        cursor.close()
        return True
    else:
        cursor.close()
        return False

def get_registered_events(user_id):
    cursor = mysql.connection.cursor()
    query = """
    SELECT 
        e.event_id,
        e.name AS event_name,
        e.description,
        e.start_date,
        e.end_date,
        e.created_by,
        e.status,
        e.created_at,
        e.updated_at,
        e.last_updated_by,
        v.name AS venue_name,
        v.address AS venue_address,
        v.location_data AS venue_location_data,
        (SELECT COUNT(*) FROM Registrations r WHERE r.event_id = e.event_id) AS number_of_registrations,
        (SELECT COUNT(*) FROM Sessions s WHERE s.event_id = e.event_id) AS number_of_sessions
    FROM Events e
    LEFT JOIN Event_Venue ev ON e.event_id = ev.event_id
    LEFT JOIN Venues v ON ev.venue_id = v.venue_id
    WHERE e.event_id IN (SELECT DISTINCT event_id FROM Registrations WHERE user_id = %s)
    """
    cursor.execute(query, (user_id,))
    events = cursor.fetchall()
    cursor.close()
    return events

def view_registration_info(event_id, user_id, session_id):
    cursor = mysql.connection.cursor()
    cursor.execute(
        "SELECT * FROM Registrations WHERE event_id = %s AND user_id = %s AND session_id = %s",
        (event_id, user_id, session_id)
    )
    registration_info = cursor.fetchone()
    cursor.execute(
        "SELECT * FROM Sessions WHERE session_id = %s",
        (session_id,)
    )
    session_info = cursor.fetchone()
    cursor.close()
    return registration_info, session_info
    

#def add ticket

def update_user_role(user_id, role):
    cursor = mysql.connection.cursor()
    cursor.execute("UPDATE Users SET role = %s WHERE user_id = %s", (role, user_id))
    mysql.connection.commit()
    cursor.close()

def test():
    cursor = mysql.connection.cursor()
    cursor.execute("select * from testsample")
    testt = cursor.fetchall()
    cursor.close()
    return testt


#lab assignment:
