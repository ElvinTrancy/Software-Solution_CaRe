SET @@AUTOCOMMIT = 1;

-- Drop and recreate the database
DROP DATABASE IF EXISTS care;
CREATE DATABASE care;

USE care;

-- Create the Therapists table
CREATE TABLE Therapists (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone_number VARCHAR(20),
    specialty VARCHAR(255), -- Therapist's specialization
    password VARCHAR(255) NOT NULL, -- Therapist password for authentication
    appointment_color VARCHAR(7) NOT NULL, -- Hex code for appointment color
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) AUTO_INCREMENT = 1;

-- Create the Patients table
CREATE TABLE Patients (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone_number VARCHAR(20),
    group_name VARCHAR(50), -- Group the patient is associated with (if applicable)
    field VARCHAR(50), -- Field or category for the patient (e.g., Pediatrics)
    status ENUM('Online', 'Rest', 'Quit') DEFAULT 'Online', -- Current status of the patient
    date_of_birth DATE,
    password VARCHAR(255) NOT NULL, -- Patient password for authentication
    emergency_contact_name VARCHAR(255),
    emergency_contact_phone VARCHAR(20),
    insurance_policy_number VARCHAR(50),
    address VARCHAR(255),
    notes TEXT, -- General notes about the patient
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) AUTO_INCREMENT = 1;

-- Create the Auditors table
CREATE TABLE Auditors (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone_number VARCHAR(20),
    password VARCHAR(255) NOT NULL, -- Auditor password for authentication
    audit_privileges JSON, -- List of privileges (case types, consultation lengths, etc.) in JSON format
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) AUTO_INCREMENT = 1;

-- Create the Groups table
CREATE TABLE Groups (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    leader VARCHAR(255) NOT NULL, -- Name of the group's leader (therapist)
    number_of_members INT NOT NULL,
    assigned_patients INT, -- Number of patients assigned to this group
    creation_date DATE NOT NULL, -- When the group was created
    status ENUM('Active', 'Inactive', 'Disbanded', 'Recruiting') DEFAULT 'Active',
    head_img VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) AUTO_INCREMENT = 1;

-- Create the Therapist Assigned Patients table
CREATE TABLE Therapist_Assigned_Patients (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    therapist_id INT NOT NULL,
    patient_id INT NOT NULL,
    assignment_type ENUM('Primary', 'Consultant') DEFAULT 'Primary',
    assigned_date DATE NOT NULL DEFAULT CURRENT_DATE,
    status ENUM('Active', 'Completed', 'On hold') DEFAULT 'Active',
    FOREIGN KEY (therapist_id) REFERENCES Therapists(id) ON DELETE CASCADE,
    FOREIGN KEY (patient_id) REFERENCES Patients(id) ON DELETE CASCADE
) AUTO_INCREMENT = 1;

-- Create the Appointments table
CREATE TABLE Appointments (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    therapist_id INT NOT NULL,
    patient_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    duration_minutes INT DEFAULT 60, -- Duration of the appointment in minutes
    appointment_type ENUM('Consultation', 'Follow-up', 'Therapy Session') DEFAULT 'Consultation',
    location VARCHAR(255),
    status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    notes TEXT,
    FOREIGN KEY (therapist_id) REFERENCES Therapists(id) ON DELETE CASCADE,
    FOREIGN KEY (patient_id) REFERENCES Patients(id) ON DELETE CASCADE
) AUTO_INCREMENT = 1;

-- Insert mock data into Therapists table
INSERT INTO Therapists (name, email, phone_number, specialty, password, appointment_color)
VALUES 
('Dr. Smith', 'smith@care.com', '123456789', 'Psychiatry', 'password1', '#1abc9c'),
('Dr. Johnson', 'johnson@care.com', '987654321', 'Pediatrics', 'password2', '#3498db'),
('Dr. Lee', 'lee@care.com', '123123123', 'Neurology', 'password3', '#9b59b6'),
('Dr. Martinez', 'martinez@care.com', '456456456', 'General Medicine', 'password4', '#e74c3c');

-- Insert mock data into Patients table
INSERT INTO Patients (name, email, phone_number, group_name, field, status, date_of_birth, password, emergency_contact_name, emergency_contact_phone, insurance_policy_number, address, notes)
VALUES 
('John Doe', 'johndoe@care.com', '1122334455', 'Group 1', 'Pediatrics', 'Online', '1990-01-01', 'patientpass1', 'Jane Doe', '123456789', 'POL12345', '123 Elm St', 'No known allergies'),
('Jane Smith', 'janesmith@care.com', '9988776655', 'Group 2', 'Psychiatry', 'Online', '1985-05-05', 'patientpass2', 'John Smith', '987654321', 'POL54321', '456 Maple Ave', 'Asthma patient');

-- Insert mock data into Auditors table
INSERT INTO Auditors (name, email, phone_number, password, audit_privileges)
VALUES 
('Auditor 1', 'auditor1@care.com', '1112223333', 'auditpass1', JSON_OBJECT('case_types', 'All', 'consultation_lengths', 'View Only')),
('Auditor 2', 'auditor2@care.com', '4445556666', 'auditpass2', JSON_OBJECT('case_types', 'Pediatrics', 'consultation_lengths', 'View and Edit'));

-- Insert mock data into Groups table
INSERT INTO Groups (name, leader, number_of_members, assigned_patients, creation_date, status, head_img)
VALUES
('Group 1', 'Dr. Smith', 15, 50, '2023-01-15', 'Active', '/assets/group01.jpg'),
('Group 2', 'Dr. Johnson', 10, 30, '2023-02-20', 'Recruiting', '/assets/group02.jpg');

-- Grant permissions to dbadmin
CREATE USER IF NOT EXISTS dbadmin@localhost IDENTIFIED BY 'adminpassword';
GRANT ALL PRIVILEGES ON care.* TO dbadmin@localhost;
