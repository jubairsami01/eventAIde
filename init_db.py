import MySQLdb

def create_tables():
    connection = MySQLdb.connect(
        host="localhost",
        user="root",
        password=""
    )
    cursor = connection.cursor()

    # Create database
    cursor.execute("CREATE DATABASE IF NOT EXISTS eventaide")
    cursor.execute("USE eventaide")

    # Create tables
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS events (
            id INT AUTO_INCREMENT PRIMARY KEY,
            name VARCHAR(255) NOT NULL,
            venue VARCHAR(255) NOT NULL,
            date DATETIME NOT NULL
        )
    """)
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS attendees (
            id INT AUTO_INCREMENT PRIMARY KEY,
            name VARCHAR(255) NOT NULL,
            email VARCHAR(255) NOT NULL,
            event_id INT,
            FOREIGN KEY (event_id) REFERENCES events (id)
        )
    """)

    connection.commit()
    cursor.close()
    connection.close()
    print("Database and tables initialized successfully.")

if __name__ == "__main__":
    create_tables()
