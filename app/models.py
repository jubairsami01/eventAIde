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



#def add ticket

def get_all_events():
    """Retrieve all events from the database."""
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT * FROM events")
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