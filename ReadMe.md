


# Application Setup Guide

This guide provides instructions for setting up and running the Care application.

## Prerequisites

Before running the PHP application, make sure your environment meets the following requirements:

1. **PHP**: Version 7.4 or higher.
2. **Web Server**: Apache.
3. **Database**: MySQL.
4. **Composer**: Dependency manager for PHP.

## Account & Password

| Role          | Email                    | Password       |
|---------------|--------------------------|----------------|
| **Patient**   | patient1@care.com        | YourPassword1  |
|               | patient2@care.com        | YourPassword1  |
| **Auditor**   | auditor1@care.com        | YourPassword1  |
|               | auditor2@care.com        | YourPassword1  |
| **Therapist** | johnsmith@care.com       | YourPassword1  |
|               | alicejohnson@care.com    | YourPassword1  |
|---------------|--------------------------|----------------|

## Setup Instructions

# Step 1: Clone and move Files to XAMPP

Once the files are downloaded, move the entire project folder to XAMPP htdocs directory. This folder is located in the installation directory of XAMPP, usually found here:
```bash
C:/xampp/htdocs
```

# Step 2: Import the Database
Open phpMyAdmin by visiting http://localhost/phpmyadmin in the browser.
Create a new database named care.
Import the provided db.sql file:
In phpMyAdmin, select newly created database.
Go to the Import tab.
Click Choose File, select the db.sql file from the project folder, and click Go.

# Step 3: Configure Database Connection
Open the inc/dbconn.inc.php file.
Update the database credentials with the following values:
```php
define("DB_HOST", "localhost");
define("DB_NAME", "care");
define("DB_USER", "dbadmin");
define("DB_PASS", "");
```
Save the changes.
Please note that, in Administrator, Patient and Therapist folder, there is an dbconn.inc.php in each of their sub-folder named inc.

# Step 4: Start Apache and MySQL in XAMPP
Open XAMPP Control Panel.
Start both Apache and MySQL by clicking the Start buttons next to them.

# Step 5: Access the Application
Now we can access the application through web browser by navigating to the following URLs, depending on the role we want to log in as:

Patient: http://localhost/folder-name/Patient/login.php
Administrator: http://localhost/folder-name/Administrator/login.php
Therapist: http://localhost/folder-name/Therapist/login.php

Make sure to replace folder-name with the name of the project folder you placed in the htdocs directory.


## Project Structure

The project structure is as follows:

1. Project Structure Overview

├── Administrator/      # Contains files related to the administrator panel
├── Patient/            # Contains files related to the patient-facing part of the application
├── Therapist/          # Contains files related to the therapist-facing part of the application
├── .github/            # GitHub configuration files (optional)
├── .vscode/            # VS Code workspace settings
└── favicon.ico         # Icon file for the website (shared)

2. Administrator Directory

├── assets/               # Static resources (images, icons, etc.)
├── components/           # Reusable UI components for the admin panel
├── css/                  # CSS styles for the administrator interface
├── inc/                  # PHP include files (e.g., database connection, session management)
├── js/                   # JavaScript files related to the admin panel
├── pages/                # Sub-pages for the administrator panel
├── requests/             # PHP files handling AJAX or form requests
├── appointment.php       # Admin page for managing appointments
├── groups.php            # Admin page for managing groups
├── index.php             # Admin dashboard
├── login.php             # Admin login page
├── patients.php          # Admin page for managing patients
├── therapist.php         # Admin page for managing therapists

3. Patient Directory

├── css/                  # CSS styles specific to the patient interface
├── images/               # Static images used in the patient section
├── inc/                  # PHP include files specific to patient features
├── js/                   # JavaScript files for patient interactions
├── requests/             # AJAX request handlers and API calls for patients
├── Styles/               # Additional styles for the patient interface
├── uploads/              # Directory for storing patient-uploaded files
├── add.php               # Page for adding patient details
├── analytics.php         # Patient analytics and data tracking
├── diet-level.php        # Page for managing diet-related data
├── fitness-level.php     # Page for managing fitness levels
├── home.php              # Patient homepage or dashboard
├── login.php             # Patient login page
├── noteNote.php          # Page for taking notes
├── profile.php           # Patient profile management
├── services.php          # Available services for the patient
├── sign-up.php           # Patient signup page
├── sleep-level.php       # Page for managing sleep data

4. Therapist Directory

├── assets/               # Static resources for therapists (icons, etc.)
├── components/           # Reusable components for therapist pages
├── css/                  # CSS styles for therapist pages
├── inc/                  # Include files for database connections or shared resources
├── js/                   # JavaScript files related to the therapist's view
├── requests/             # Requests specific to the therapist module
├── add-calendar.php      # Page for adding calendar entries
├── add-group.php         # Page for adding a group
├── calendar.php          # Therapist calendar management
├── detailed-group.php    # Detailed view of a group
├── group.php             # Page for managing therapist groups
├── index.php             # Therapist dashboard
├── patients-data.php     # Therapist view of patient data
├── patients-record.php   # View of patient records for therapists



