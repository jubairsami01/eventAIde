import os

#class Config:
#    SECRET_KEY = os.getenv("SECRET_KEY", "your_secret_key")
#    MYSQL_HOST = "localhost"
#    MYSQL_USER = "your_mysql_user"
#    MYSQL_PASSWORD = "your_mysql_password"
#    MYSQL_DB = "eventaide"
#    MYSQL_CURSORCLASS = "DictCursor"

class Config:
    SECRET_KEY = os.environ.get('SECRET_KEY') or 'a_secret_key'
    MYSQL_HOST = os.environ.get('MYSQL_HOST') or 'localhost'
    MYSQL_USER = os.environ.get('MYSQL_USER') or 'root'
    MYSQL_PASSWORD = os.environ.get('MYSQL_PASSWORD') or ''
    MYSQL_DB = os.environ.get('MYSQL_DB') or 'eventaide_db'
    SESSION_TYPE = 'filesystem'
    MYSQL_CURSORCLASS = "DictCursor"