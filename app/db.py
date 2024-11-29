from flask import current_app

def query_db(query, args=(), fetchone=False):
    """Execute a query and return the results."""
    cursor = current_app.mysql.connection.cursor()
    cursor.execute(query, args)
    rv = cursor.fetchone() if fetchone else cursor.fetchall()
    cursor.close()
    return rv

def modify_db(query, args=()):
    """Execute an insert, update, or delete query."""
    cursor = current_app.mysql.connection.cursor()
    cursor.execute(query, args)
    current_app.mysql.connection.commit()
    cursor.close()
