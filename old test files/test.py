for i in range(10):
    print(i)

EventAIde/
│
├── app/                          # Core application folder
│   ├── __init__.py               # Initializes the Flask app and extensions
│   ├── models.py                 # Database models for the project
│   ├── routes/                   # Blueprint routes folder
│   │   ├── __init__.py           # Initializes blueprints
│   │   ├── management_routes.py  # Management panel-specific routes
│   │   ├── customer_routes.py    # Customer panel-specific routes
│   │   ├── ease_routes.py        # Ease of Access & Special Features routes
│   ├── services/                 # Service logic folder
│   │   ├── __init__.py           # Initializes services
│   │   ├── ai_services.py        # AI-related service functions
│   │   ├── analytics_services.py # Analytics and reporting services
│   │   ├── user_services.py      # User-related helper functions
│   ├── templates/                # HTML templates folder
│   │   ├── base.html             # Base template for consistent layouts
│   │   ├── management/           # Templates for management panel
│   │   ├── customer/             # Templates for customer panel
│   │   ├── ease/                 # Templates for ease of access features
│   ├── static/                   # Static files (CSS, JS, images)
│       ├── css/
│       │   ├── styles.css        # Custom styles
│       ├── js/
│       │   ├── main.js           # Custom JavaScript
│       ├── images/               # Image assets
│
├── migrations/                   # Database migrations folder (Flask-Migrate)
│
├── tests/                        # Testing folder
│   ├── test_management.py        # Tests for the management panel
│   ├── test_customer.py          # Tests for the customer panel
│   ├── test_ease.py              # Tests for ease of access features
│
├── requirements.txt              # Project dependencies
├── config.py                     # Configuration for Flask and MySQL
├── init_db.py                    # Script for initializing the database schema
├── run.py                        # Entry point for the application
├── README.md                     # Project documentation
├── .env                          # Environment variables (e.g., API keys)
├── .gitignore                    # Git ignore file
