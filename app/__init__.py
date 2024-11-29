from flask import Flask
from flask_mysqldb import MySQL
from config import Config

mysql = MySQL()

def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)

    # Initialize MySQL
    mysql.init_app(app)

    # Register Blueprints
    from app.routes import management_routes, customer_routes, ease_routes
    app.register_blueprint(management_routes.bp)
    app.register_blueprint(customer_routes.bp)
    app.register_blueprint(ease_routes.bp)

    return app
