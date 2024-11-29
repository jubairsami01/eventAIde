from app.db import mysql

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
