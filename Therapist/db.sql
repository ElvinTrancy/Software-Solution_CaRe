SET @@AUTOCOMMIT = 1;

-- Drop and recreate the database
DROP DATABASE IF EXISTS care;
CREATE DATABASE care;

USE care;

-- Drop the Therapists table if it exists
DROP TABLE IF EXISTS Therapists;

-- Create the Therapists table with photo field
CREATE TABLE Therapists (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone_number VARCHAR(20),
    specialty VARCHAR(255), -- Therapist's specialization
    password VARCHAR(255) NOT NULL, -- Therapist password for authentication
    appointment_color VARCHAR(7) NOT NULL, -- Hex code for appointment color
    photo VARCHAR(255), -- Path to therapist's photo
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

-- Create the Patients table with photo field
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
    photo VARCHAR(255), -- Path to patient's photo
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

CREATE TABLE PatientDailyRecords (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL, -- Foreign key to the patient
    record_date DATE NOT NULL, -- Date of the record
    mood VARCHAR(255), -- Mood description
    fitness_level VARCHAR(50), -- Fitness level
    sleep_hours INT, -- Sleep hours
    diet VARCHAR(255), -- Diet level description
    notes TEXT, -- Notes or messages from the patient
    FOREIGN KEY (patient_id) REFERENCES Patients(id) ON DELETE CASCADE
);

-- Insert mock data for Therapists
INSERT INTO Therapists (name, email, phone_number, specialty, password, appointment_color, photo)
VALUES
('Dr. John Smith', 'johnsmith@care.com', '1111111111', 'Psychiatry', 'password1', '#ff5733', 'assets/therapist1.jpg'),
('Dr. Alice Johnson', 'alicejohnson@care.com', '2222222222', 'Pediatrics', 'password2', '#33ff57', 'assets/therapist2.jpg'),
('Dr. Robert Brown', 'robertbrown@care.com', '3333333333', 'Neurology', 'password3', '#3357ff', 'assets/therapist3.jpg'),
('Dr. Maria Lee', 'marialee@care.com', '4444444444', 'Dermatology', 'password4', '#ff33a1', 'assets/therapist4.jpg'),
('Dr. David Garcia', 'davidgarcia@care.com', '5555555555', 'General Medicine', 'password5', '#a133ff', 'assets/therapist5.jpg'),
('Dr. Emily Wilson', 'emilywilson@care.com', '6666666666', 'Psychiatry', 'password6', '#33ffaa', 'assets/therapist6.jpg'),
('Dr. Michael Martinez', 'michaelmartinez@care.com', '7777777777', 'Cardiology', 'password7', '#ffaa33', 'assets/therapist7.jpg'),
('Dr. Sarah Davis', 'sarahdavis@care.com', '8888888888', 'Oncology', 'password8', '#ff3333', 'assets/therapist8.jpg'),
('Dr. Anthony Lopez', 'anthonylopez@care.com', '9999999999', 'Orthopedics', 'password9', '#33ff33', 'assets/therapist9.jpg'),
('Dr. Jessica White', 'jessicawhite@care.com', '1010101010', 'Pediatrics', 'password10', '#3333ff', 'assets/therapist10.jpg');

-- Insert mock data for Patients
INSERT INTO Patients (name, email, phone_number, group_name, field, status, date_of_birth, password, emergency_contact_name, emergency_contact_phone, insurance_policy_number, address, photo, notes)
VALUES
('John Doe', 'johndoe@care.com', '1112223333', 'Group 1', 'Pediatrics', 'Online', '1990-01-01', 'patientpass1', 'Jane Doe', '5554443333', 'POL12345', '123 Elm St', 'assets/patient1.jpg', 'No known allergies'),
('Jane Smith', 'janesmith@care.com', '2223334444', 'Group 2', 'Oncology', 'Online', '1985-05-05', 'patientpass2', 'John Smith', '6665554444', 'POL54321', '456 Maple Ave', 'assets/patient2.jpg', 'Asthma patient'),
('Alice Brown', 'alicebrown@care.com', '3334445555', 'Group 3', 'Neurology', 'Rest', '1992-03-03', 'patientpass3', 'Bob Brown', '7776665555', 'POL99999', '789 Oak Dr', 'assets/patient3.jpg', 'Diabetic'),
('Robert White', 'robertwhite@care.com', '4445556666', 'Group 1', 'General Medicine', 'Online', '1987-09-12', 'patientpass4', 'Sally White', '8887776666', 'POL88888', '101 Pine Ave', 'assets/patient4.jpg', 'High blood pressure'),
('Chris Black', 'chrisblack@care.com', '5556667777', 'Group 2', 'Dermatology', 'Quit', '1995-07-07', 'patientpass5', 'Anna Black', '9998887777', 'POL77777', '202 Birch St', 'assets/patient5.jpg', 'No notes'),
('Sophia Green', 'sophiagreen@care.com', '6667778888', 'Group 4', 'Cardiology', 'Online', '1989-12-12', 'patientpass6', 'Tom Green', '1112224444', 'POL66666', '303 Cedar St', 'assets/patient6.jpg', 'Heart condition'),
('David Lee', 'davidlee@care.com', '7778889999', 'Group 5', 'Orthopedics', 'Rest', '1982-04-04', 'patientpass7', 'Nancy Lee', '2223335555', 'POL55555', '404 Elm St', 'assets/patient7.jpg', 'Broken leg'),
('Emma Harris', 'emmaharris@care.com', '8889990000', 'Group 3', 'Psychiatry', 'Online', '1994-08-08', 'patientpass8', 'Tom Harris', '3334446666', 'POL44444', '505 Spruce St', 'assets/patient8.jpg', 'Depression'),
('Liam Turner', 'liamturner@care.com', '9990001111', 'Group 4', 'Pediatrics', 'Rest', '1993-11-11', 'patientpass9', 'Kate Turner', '4445557777', 'POL33333', '606 Fir St', 'assets/patient9.jpg', 'No allergies'),
('Mia Scott', 'miascott@care.com', '0001112222', 'Group 5', 'Neurology', 'Online', '1997-06-06', 'patientpass10', 'Dan Scott', '5556668888', 'POL22222', '707 Redwood St', 'assets/patient10.jpg', 'Epilepsy');


-- Insert mock data for Patient Daily Records
INSERT INTO PatientDailyRecords (patient_id, record_date, mood, fitness_level, sleep_hours, diet, notes)
VALUES
(1, CURDATE(), 'happy', 'Level 3', 7, 'Balanced diet', 'Feeling good overall today.'),
(1, DATE_SUB(CURDATE(), INTERVAL 1 DAY), 'neutral', 'Level 2', 6, 'Skipped lunch', 'I haven’t been eating well lately, please help me.'),
(2, CURDATE(), 'sad', 'Level 1', 4, 'Unhealthy snacks', 'I feel really low today. Struggled with energy.'),
(2, DATE_SUB(CURDATE(), INTERVAL 1 DAY), 'neutral', 'Level 3', 8, 'Balanced meals', 'I had a decent day but felt tired.'),
(3, CURDATE(), 'tired', 'Level 2', 5, 'Light meals', 'I’ve been feeling dizzy recently.'),
(3, DATE_SUB(CURDATE(), INTERVAL 1 DAY), 'neutral', 'Level 4', 6, 'Healthy diet', 'Felt slightly better today.'),
(4, CURDATE(), 'anxious', 'Level 1', 3, 'Skipped meals', 'I have trouble sleeping. Please advise.'),
(4, DATE_SUB(CURDATE(), INTERVAL 1 DAY), 'stressed', 'Level 2', 4, 'Minimal food intake', 'Very restless.'),
(5, CURDATE(), 'neutral', 'Level 3', 7, 'Normal diet', 'Just a regular day, no major issues.'),
(5, DATE_SUB(CURDATE(), INTERVAL 1 DAY), 'happy', 'Level 4', 8, 'Healthy meals', 'Feeling positive and productive.');



-- Insert mock data into Auditors table
INSERT INTO Auditors (name, email, phone_number, password, audit_privileges)
VALUES 
('Auditor 1', 'auditor1@care.com', '1112223333', 'auditpass1', JSON_OBJECT('case_types', 'All', 'consultation_lengths', 'View Only')),
('Auditor 2', 'auditor2@care.com', '4445556666', 'auditpass2', JSON_OBJECT('case_types', 'Pediatrics', 'consultation_lengths', 'View and Edit')),
('Auditor 3', 'auditor3@care.com', '7778889999', 'auditpass3', JSON_OBJECT('case_types', 'Neurology', 'consultation_lengths', 'View Only')),
('Auditor 4', 'auditor4@care.com', '1231231234', 'auditpass4', JSON_OBJECT('case_types', 'General Medicine', 'consultation_lengths', 'View and Edit')),
('Auditor 5', 'auditor5@care.com', '3213214321', 'auditpass5', JSON_OBJECT('case_types', 'Dermatology', 'consultation_lengths', 'View Only'));

-- Insert mock data into Groups table
INSERT INTO Groups (name, leader, number_of_members, assigned_patients, creation_date, status, head_img)
VALUES
('Group 1', 'Dr. Smith', 15, 50, '2023-01-15', 'Active', '/assets/group01.jpg'),
('Group 2', 'Dr. Johnson', 10, 30, '2023-02-20', 'Recruiting', '/assets/group02.jpg'),
('Group 3', 'Dr. Lee', 20, 40, '2023-03-10', 'Active', '/assets/group03.jpg'),
('Group 4', 'Dr. Martinez', 8, 25, '2023-04-05', 'Disbanded', '/assets/group04.jpg'),
('Group 5', 'Dr. Adams', 12, 35, '2023-05-01', 'Inactive', '/assets/group05.jpg');

-- Insert mock data into Therapist_Assigned_Patients table
INSERT INTO Therapist_Assigned_Patients (therapist_id, patient_id, assignment_type, assigned_date, status)
VALUES
(1, 1, 'Primary', '2023-01-10', 'Active'),
(1, 4, 'Consultant', '2023-01-20', 'Completed'),
(2, 2, 'Primary', '2023-02-05', 'Active'),
(3, 3, 'Consultant', '2023-03-15', 'Active'),
(4, 5, 'Primary', '2023-04-10', 'On hold'),
(5, 1, 'Consultant', '2023-05-12', 'Completed');

-- Insert mock data into Appointments table
INSERT INTO Appointments (therapist_id, patient_id, appointment_date, duration_minutes, appointment_type, location, status, notes)
VALUES
(1, 1, '2023-07-15 10:00:00', 60, 'Consultation', 'Room 101', 'Scheduled', 'Initial consultation.'),
(2, 2, '2023-08-20 14:00:00', 45, 'Therapy Session', 'Room 202', 'Completed', 'Follow-up therapy session.'),
(3, 3, '2023-09-25 09:30:00', 30, 'Consultation', 'Room 303', 'Scheduled', 'Neurological assessment.'),
(4, 4, '2023-10-01 11:00:00', 60, 'Follow-up', 'Room 404', 'Cancelled', 'Appointment cancelled by patient.'),
(5, 5, '2023-11-05 15:00:00', 90, 'Therapy Session', 'Room 505', 'Scheduled', 'Extended therapy session.');

-- Grant permissions to dbadmin
CREATE USER IF NOT EXISTS dbadmin@localhost IDENTIFIED BY 'adminpassword';
GRANT ALL PRIVILEGES ON care.* TO dbadmin@localhost;
