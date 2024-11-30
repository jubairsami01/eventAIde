from app import mysql

# Example database interaction
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

def register_user(name, email, password):
    """Register a new user."""
    cursor = mysql.connection.cursor()
    cursor.execute(
        "INSERT INTO attendees (name, email) VALUES (%s, %s)",
        (name, email),
    )
    mysql.connection.commit()
    cursor.close()

def test():
    cursor = mysql.connection.cursor()
    cursor.execute("select * from testsample")
    testt = cursor.fetchall()
    cursor.close()
    return testt