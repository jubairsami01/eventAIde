import os

#class Config:
#    SECRET_KEY = os.getenv("SECRET_KEY", "your_secret_key")
#    MYSQL_HOST = "localhost"
#    MYSQL_USER = "your_mysql_user"
#    MYSQL_PASSWORD = "your_mysql_password"
#    MYSQL_DB = "eventaide"
#    MYSQL_CURSORCLASS = "DictCursor"

#class Config:
#    SECRET_KEY = os.environ.get('SECRET_KEY') or 'a_secret_key'
#    MYSQL_HOST = os.environ.get('MYSQL_HOST') or '127.0.0.1'
#    MYSQL_USER = os.environ.get('MYSQL_USER') or 'root'
#    MYSQL_PASSWORD = os.environ.get('MYSQL_PASSWORD') or ''
#    MYSQL_DB = 'eventaide_db'
#    SESSION_TYPE = 'filesystem'
#    MYSQL_CURSORCLASS = "DictCursor"
#    #MYSQL_UNIX_SOCKET = '/var/run/mysqld/mysqld.sock'
#    MYSQL_PORT = int(os.environ.get('MYSQL_PORT', 3306))
"""CREATE USER 'root2'@'localhost' IDENTIFIED BY '1234abC$';
GRANT ALL PRIVILEGES ON eventaide_db.* TO 'root2'@'localhost';
FLUSH PRIVILEGES;
EXIT;"""
#to connect the local machine server on my laptop:
"""
class Config:
    SECRET_KEY = os.environ.get('SECRET_KEY') or 'a_secret_key'
    MYSQL_HOST = '127.0.0.1'
    MYSQL_USER = 'root2'
    MYSQL_PASSWORD = '1234abC$'
    MYSQL_DB = 'eventaide_db'
    SESSION_TYPE = 'filesystem'
    MYSQL_CURSORCLASS = "DictCursor"
    MYSQL_PORT = 3306
"""

#to connect the remote server:
class Config:
    SECRET_KEY = os.environ.get('SECRET_KEY') or 'a_secret_key'
    MYSQL_HOST = 'eventaidedb-eventaidedb.h.aivencloud.com'
    MYSQL_USER = 'avnadmin'
    MYSQL_PASSWORD = 'AVNS_7LCskFyOhLpyOVZmH88'
    MYSQL_DB = 'eventaide_db'
    MYSQL_PORT = 18570
    SESSION_TYPE = 'filesystem'
    MYSQL_CURSORCLASS = "DictCursor"
    MYSQL_CONNECT_TIMEOUT = 10
    MYSQL_READ_TIMEOUT = 10
    MYSQL_WRITE_TIMEOUT = 10
    MYSQL_CHARSET = "utf8mb4"