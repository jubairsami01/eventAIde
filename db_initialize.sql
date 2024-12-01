-- Create database
-- CREATE DATABASE EventAIde;
-- USE EventAIde;

-- 2. Users Table
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('host', 'customer', 'both') NOT NULL DEFAULT 'customer',
    is_verified BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 1. Events Table
CREATE TABLE Events (
    event_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    venue VARCHAR(255),
    start_date DATETIME NOT NULL,
    end_date DATETIME NOT NULL,
    created_by INT NOT NULL,
    status ENUM('draft', 'ongoing', 'completed') NOT NULL DEFAULT 'draft',
    visibility ENUM('public', 'private') NOT NULL DEFAULT 'public',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (created_by) REFERENCES Users(user_id)
);



-- 3. Co-Hosts Table
CREATE TABLE CoHosts (
    cohost_id INT AUTO_INCREMENT PRIMARY KEY,
    event_id INT NOT NULL,
    user_id INT NOT NULL,
    assigned_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (event_id) REFERENCES Events(event_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- 9. Venues Table
CREATE TABLE Venues (
    venue_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    address TEXT NOT NULL,
    details_json JSON,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Event-Venue Table
CREATE TABLE Event_Venue (
    event_venue_id INT AUTO_INCREMENT PRIMARY KEY,
    event_id INT NOT NULL,
    venue_id INT NOT NULL,
    customized_details JSON,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (event_id) REFERENCES Events(event_id),
    FOREIGN KEY (venue_id) REFERENCES Venues(venue_id)
);


-- Sessions Table
CREATE TABLE Sessions (
    session_id INT AUTO_INCREMENT PRIMARY KEY,
    event_id INT NOT NULL,
    event_venue_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    start_time DATETIME NOT NULL,
    end_time DATETIME NOT NULL,
    capacity INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (event_id) REFERENCES Events(event_id),
    FOREIGN KEY (event_venue_id) REFERENCES Event_Venue(event_venue_id)
);

-- 5. Registrations Table
CREATE TABLE Registrations (
    registration_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    event_id INT NOT NULL,
    session_id INT,
    status ENUM('pending', 'confirmed', 'cancelled') NOT NULL DEFAULT 'pending',
    registered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (event_id) REFERENCES Events(event_id),
    FOREIGN KEY (session_id) REFERENCES Sessions(session_id)
);

-- Social Media Shares Table
CREATE TABLE Social_Media_Shares (
    share_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    event_id INT NOT NULL,
    platform VARCHAR(50),
    action ENUM('shared', 'copied') NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (event_id) REFERENCES Events(event_id)
);

-- 7. Notifications Table
CREATE TABLE Notifications (
    notification_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    event_id INT,
    message TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (event_id) REFERENCES Events(event_id)
);

-- 8. Analytics Table
CREATE TABLE Analytics (
    analytics_id INT AUTO_INCREMENT PRIMARY KEY,
    event_id INT NOT NULL,
    metric VARCHAR(255) NOT NULL,
    value FLOAT,
    recorded_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (event_id) REFERENCES Events(event_id)
);