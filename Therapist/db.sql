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
INSERT INTO Patients (name, email, phone_number, group_name, field, status, date_of_birth, password, emergency_contact_name, emergency_contact_phone, insurance_policy_number, address, photo, notes, register_at)
VALUES
('Laura Lewis', 'patient1@care.com', '1119096577', 'Group 2', 'Orthopedics', 'Online', '1983-11-07 00:00:00', 'patientpass1', 'Emergency Contact 1', '1103862043', 'POL86577', '560 Elm St', 'assets/patient1.jpg', 'Asthma patient', '2024-09-07 21:31:23'),
('Sarah Moore', 'patient2@care.com', '1316780152', 'Group 4', 'Orthopedics', 'Quit', '1995-10-15 00:00:00', 'patientpass2', 'Emergency Contact 2', '1550945404', 'POL52622', '767 Elm St', 'assets/patient2.jpg', 'Diabetic', '2024-09-20 21:31:23'),
('Laura Davis', 'patient3@care.com', '1511101871', 'Group 3', 'Dermatology', 'Rest', '2009-01-04 00:00:00', 'patientpass3', 'Emergency Contact 3', '1955603860', 'POL25367', '683 Elm St', 'assets/patient3.jpg', 'Asthma patient', '2024-09-12 21:31:23'),
('Mia White', 'patient4@care.com', '1709807803', 'Group 5', 'Orthopedics', 'Online', '1986-05-13 00:00:00', 'patientpass4', 'Emergency Contact 4', '1657723691', 'POL48382', '486 Elm St', 'assets/patient4.jpg', 'Asthma patient', '2024-09-15 21:31:23'),
('David Taylor', 'patient5@care.com', '1685921426', 'Group 4', 'Orthopedics', 'Online', '2011-02-06 00:00:00', 'patientpass5', 'Emergency Contact 5', '1883571918', 'POL52306', '459 Elm St', 'assets/patient5.jpg', 'No known allergies', '2024-09-28 21:31:23'),
('Robert Taylor', 'patient6@care.com', '1561351916', 'Group 3', 'Neurology', 'Rest', '1980-01-02 00:00:00', 'patientpass6', 'Emergency Contact 6', '1693496325', 'POL76710', '887 Elm St', 'assets/patient6.jpg', 'Diabetic', '2024-09-19 21:31:23'),
('Daniel Jackson', 'patient7@care.com', '1602097562', 'Group 1', 'Orthopedics', 'Rest', '1982-02-24 00:00:00', 'patientpass7', 'Emergency Contact 7', '1993054152', 'POL42532', '347 Elm St', 'assets/patient7.jpg', 'Asthma patient', '2024-09-20 21:31:23'),
('Lucas Davis', 'patient8@care.com', '1596760495', 'Group 5', 'Pediatrics', 'Online', '2014-03-06 00:00:00', 'patientpass8', 'Emergency Contact 8', '1979711661', 'POL19001', '735 Elm St', 'assets/patient8.jpg', 'High blood pressure', '2024-10-01 21:31:23'),
('Daniel Moore', 'patient9@care.com', '1620667579', 'Group 3', 'Neurology', 'Quit', '2015-05-15 00:00:00', 'patientpass9', 'Emergency Contact 9', '1284396174', 'POL35503', '157 Elm St', 'assets/patient9.jpg', 'No notes', '2024-09-08 21:31:23'),
('Sarah Rodriguez', 'patient10@care.com', '1850765020', 'Group 5', 'Oncology', 'Rest', '1986-12-13 00:00:00', 'patientpass10', 'Emergency Contact 10', '1978312236', 'POL46796', '827 Elm St', 'assets/patient10.jpg', 'Asthma patient', '2024-09-20 21:31:23'),
('Michael Thompson', 'patient11@care.com', '1571314144', 'Group 1', 'Pediatrics', 'Rest', '1983-10-28 00:00:00', 'patientpass11', 'Emergency Contact 11', '1168402362', 'POL60198', '231 Elm St', 'assets/patient11.jpg', 'Asthma patient', '2024-09-14 21:31:23'),
('Emma White', 'patient12@care.com', '1554760899', 'Group 1', 'Neurology', 'Quit', '2007-09-22 00:00:00', 'patientpass12', 'Emergency Contact 12', '1507251179', 'POL55304', '733 Elm St', 'assets/patient12.jpg', 'No known allergies', '2024-09-24 21:31:23'),
('Sophia Jackson', 'patient13@care.com', '1106878258', 'Group 4', 'Neurology', 'Online', '2003-08-28 00:00:00', 'patientpass13', 'Emergency Contact 13', '1265973192', 'POL24265', '325 Elm St', 'assets/patient13.jpg', 'Diabetic', '2024-09-21 21:31:23'),
('Jane Garcia', 'patient14@care.com', '1591052191', 'Group 2', 'Dermatology', 'Quit', '1981-06-23 00:00:00', 'patientpass14', 'Emergency Contact 14', '1665308381', 'POL89407', '878 Elm St', 'assets/patient14.jpg', 'High blood pressure', '2024-09-11 21:31:23'),
('Mia Taylor', 'patient15@care.com', '1985289706', 'Group 5', 'Orthopedics', 'Online', '2010-01-12 00:00:00', 'patientpass15', 'Emergency Contact 15', '1131581338', 'POL27797', '264 Elm St', 'assets/patient15.jpg', 'Diabetic', '2024-10-02 21:31:23'),
('Sophia Martinez', 'patient16@care.com', '1761125723', 'Group 1', 'Neurology', 'Rest', '1987-05-03 00:00:00', 'patientpass16', 'Emergency Contact 16', '1857405035', 'POL33091', '602 Elm St', 'assets/patient16.jpg', 'High blood pressure', '2024-09-27 21:31:23'),
('James Brown', 'patient17@care.com', '1989611422', 'Group 5', 'Pediatrics', 'Online', '1995-08-03 00:00:00', 'patientpass17', 'Emergency Contact 17', '1460214537', 'POL73644', '405 Elm St', 'assets/patient17.jpg', 'High blood pressure', '2024-10-05 21:31:23'),
('Laura Brown', 'patient18@care.com', '1593757854', 'Group 2', 'Oncology', 'Quit', '2002-10-03 00:00:00', 'patientpass18', 'Emergency Contact 18', '1246721227', 'POL81426', '541 Elm St', 'assets/patient18.jpg', 'High blood pressure', '2024-10-05 21:31:23'),
('Lucas Lewis', 'patient19@care.com', '1803233334', 'Group 4', 'Dermatology', 'Quit', '2016-05-22 00:00:00', 'patientpass19', 'Emergency Contact 19', '1978175865', 'POL91319', '554 Elm St', 'assets/patient19.jpg', 'Diabetic', '2024-09-15 21:31:23'),
('Mia Miller', 'patient20@care.com', '1501358198', 'Group 3', 'Orthopedics', 'Quit', '1996-07-26 00:00:00', 'patientpass20', 'Emergency Contact 20', '1592058852', 'POL14322', '335 Elm St', 'assets/patient20.jpg', 'No known allergies', '2024-09-17 21:31:23'),
('Sarah Clark', 'patient21@care.com', '1462127711', 'Group 3', 'Orthopedics', 'Quit', '2019-01-13 00:00:00', 'patientpass21', 'Emergency Contact 21', '1651700773', 'POL18504', '656 Elm St', 'assets/patient21.jpg', 'Asthma patient', '2024-09-16 21:31:23'),
('Daniel Miller', 'patient22@care.com', '1175643354', 'Group 5', 'Oncology', 'Quit', '1997-08-20 00:00:00', 'patientpass22', 'Emergency Contact 22', '1917957435', 'POL22468', '212 Elm St', 'assets/patient22.jpg', 'High blood pressure', '2024-09-12 21:31:23'),
('Michael Johnson', 'patient23@care.com', '1423289163', 'Group 3', 'Orthopedics', 'Online', '2009-02-23 00:00:00', 'patientpass23', 'Emergency Contact 23', '1656666781', 'POL25255', '964 Elm St', 'assets/patient23.jpg', 'No notes', '2024-09-23 21:31:23'),
('Ethan Martinez', 'patient24@care.com', '1844451134', 'Group 1', 'Oncology', 'Online', '1981-01-05 00:00:00', 'patientpass24', 'Emergency Contact 24', '1444561001', 'POL74409', '978 Elm St', 'assets/patient24.jpg', 'Asthma patient', '2024-09-08 21:31:23'),
('John Davis', 'patient25@care.com', '1888265592', 'Group 2', 'Pediatrics', 'Online', '1998-06-27 00:00:00', 'patientpass25', 'Emergency Contact 25', '1697292775', 'POL69671', '581 Elm St', 'assets/patient25.jpg', 'Asthma patient', '2024-09-16 21:31:23'),
('Mia Wilson', 'patient26@care.com', '1952495663', 'Group 2', 'Pediatrics', 'Quit', '2000-10-25 00:00:00', 'patientpass26', 'Emergency Contact 26', '1235231086', 'POL46676', '297 Elm St', 'assets/patient26.jpg', 'Diabetic', '2024-09-26 21:31:23'),
('Ethan White', 'patient27@care.com', '1555331250', 'Group 4', 'Dermatology', 'Online', '2005-03-20 00:00:00', 'patientpass27', 'Emergency Contact 27', '1386340922', 'POL50081', '765 Elm St', 'assets/patient27.jpg', 'High blood pressure', '2024-09-10 21:31:23'),
('Jane Walker', 'patient28@care.com', '1568773690', 'Group 3', 'Dermatology', 'Online', '1989-03-15 00:00:00', 'patientpass28', 'Emergency Contact 28', '1375480888', 'POL31396', '720 Elm St', 'assets/patient28.jpg', 'No known allergies', '2024-10-01 21:31:23'),
('Ethan Miller', 'patient29@care.com', '1677166656', 'Group 1', 'Orthopedics', 'Quit', '2006-04-01 00:00:00', 'patientpass29', 'Emergency Contact 29', '1400942576', 'POL23432', '285 Elm St', 'assets/patient29.jpg', 'High blood pressure', '2024-09-07 21:31:23'),
('Olivia Moore', 'patient30@care.com', '1942158950', 'Group 1', 'Neurology', 'Quit', '2011-07-03 00:00:00', 'patientpass30', 'Emergency Contact 30', '1556393106', 'POL76469', '673 Elm St', 'assets/patient30.jpg', 'Diabetic', '2024-10-03 21:31:23'),
('Ethan Lewis', 'patient31@care.com', '1373256518', 'Group 2', 'Neurology', 'Quit', '1981-12-02 00:00:00', 'patientpass31', 'Emergency Contact 31', '1562057536', 'POL57703', '809 Elm St', 'assets/patient31.jpg', 'Diabetic', '2024-09-07 21:31:23'),
('David Martinez', 'patient32@care.com', '1584973606', 'Group 2', 'Oncology', 'Online', '2008-07-10 00:00:00', 'patientpass32', 'Emergency Contact 32', '1167901709', 'POL88908', '117 Elm St', 'assets/patient32.jpg', 'Asthma patient', '2024-09-06 21:31:23'),
('Daniel Harris', 'patient33@care.com', '1991185694', 'Group 4', 'Oncology', 'Online', '2018-08-10 00:00:00', 'patientpass33', 'Emergency Contact 33', '1159383123', 'POL53550', '779 Elm St', 'assets/patient33.jpg', 'No notes', '2024-09-28 21:31:23'),
('Ethan Johnson', 'patient34@care.com', '1473582006', 'Group 5', 'Pediatrics', 'Quit', '1981-05-04 00:00:00', 'patientpass34', 'Emergency Contact 34', '1411419823', 'POL34559', '803 Elm St', 'assets/patient34.jpg', 'High blood pressure', '2024-10-03 21:31:23'),
('James Brown', 'patient35@care.com', '1238524048', 'Group 1', 'Pediatrics', 'Online', '1998-03-05 00:00:00', 'patientpass35', 'Emergency Contact 35', '1241924705', 'POL72224', '330 Elm St', 'assets/patient35.jpg', 'No known allergies', '2024-09-09 21:31:23'),
('Olivia White', 'patient36@care.com', '1665888264', 'Group 2', 'Oncology', 'Online', '2008-01-04 00:00:00', 'patientpass36', 'Emergency Contact 36', '1787616349', 'POL34370', '989 Elm St', 'assets/patient36.jpg', 'No known allergies', '2024-09-20 21:31:23'),
('Emily Taylor', 'patient37@care.com', '1345940351', 'Group 5', 'Dermatology', 'Rest', '1993-10-07 00:00:00', 'patientpass37', 'Emergency Contact 37', '1962541271', 'POL72165', '798 Elm St', 'assets/patient37.jpg', 'Asthma patient', '2024-09-27 21:31:23'),
('Mia Jackson', 'patient38@care.com', '1943753626', 'Group 5', 'Oncology', 'Rest', '2004-11-01 00:00:00', 'patientpass38', 'Emergency Contact 38', '1486833622', 'POL69245', '128 Elm St', 'assets/patient38.jpg', 'Diabetic', '2024-09-18 21:31:23'),
('Sophia Jackson', 'patient39@care.com', '1412700653', 'Group 1', 'Pediatrics', 'Rest', '1987-08-13 00:00:00', 'patientpass39', 'Emergency Contact 39', '1605364591', 'POL90598', '147 Elm St', 'assets/patient39.jpg', 'Diabetic', '2024-09-14 21:31:23'),
('David Garcia', 'patient40@care.com', '1527005596', 'Group 2', 'Neurology', 'Online', '1994-10-19 00:00:00', 'patientpass40', 'Emergency Contact 40', '1718067838', 'POL42398', '270 Elm St', 'assets/patient40.jpg', 'Diabetic', '2024-09-21 21:31:23'),
('Benjamin Moore', 'patient41@care.com', '1936881118', 'Group 2', 'Orthopedics', 'Quit', '2009-06-12 00:00:00', 'patientpass41', 'Emergency Contact 41', '1369184711', 'POL38094', '774 Elm St', 'assets/patient41.jpg', 'No notes', '2024-09-30 21:31:23'),
('Laura White', 'patient42@care.com', '1772558257', 'Group 5', 'Dermatology', 'Quit', '1981-08-18 00:00:00', 'patientpass42', 'Emergency Contact 42', '1286094151', 'POL63163', '567 Elm St', 'assets/patient42.jpg', 'No notes', '2024-09-16 21:31:23'),
('Michael Lee', 'patient43@care.com', '1330680991', 'Group 5', 'Neurology', 'Rest', '1999-09-05 00:00:00', 'patientpass43', 'Emergency Contact 43', '1188285394', 'POL86871', '154 Elm St', 'assets/patient43.jpg', 'No known allergies', '2024-09-22 21:31:23'),
('Ethan Davis', 'patient44@care.com', '1498463772', 'Group 5', 'Orthopedics', 'Quit', '2003-04-23 00:00:00', 'patientpass44', 'Emergency Contact 44', '1175922987', 'POL59937', '499 Elm St', 'assets/patient44.jpg', 'No known allergies', '2024-10-04 21:31:23'),
('Mia Lewis', 'patient45@care.com', '1101350804', 'Group 2', 'Dermatology', 'Online', '2007-03-24 00:00:00', 'patientpass45', 'Emergency Contact 45', '1581381887', 'POL29860', '438 Elm St', 'assets/patient45.jpg', 'No notes', '2024-09-22 21:31:23'),
('Grace Garcia', 'patient46@care.com', '1105764092', 'Group 5', 'Pediatrics', 'Online', '1987-08-06 00:00:00', 'patientpass46', 'Emergency Contact 46', '1427513041', 'POL94545', '264 Elm St', 'assets/patient46.jpg', 'Asthma patient', '2024-09-17 21:31:23'),
('Daniel Martinez', 'patient47@care.com', '1279013974', 'Group 4', 'Neurology', 'Quit', '2008-09-26 00:00:00', 'patientpass47', 'Emergency Contact 47', '1998175102', 'POL90008', '681 Elm St', 'assets/patient47.jpg', 'High blood pressure', '2024-09-18 21:31:23'),
('Lucas Jackson', 'patient48@care.com', '1124698251', 'Group 5', 'Oncology', 'Quit', '2005-02-11 00:00:00', 'patientpass48', 'Emergency Contact 48', '1582502574', 'POL44921', '633 Elm St', 'assets/patient48.jpg', 'Asthma patient', '2024-09-21 21:31:23'),
('Olivia White', 'patient49@care.com', '1458768647', 'Group 1', 'Dermatology', 'Quit', '2007-12-18 00:00:00', 'patientpass49', 'Emergency Contact 49', '1816972335', 'POL46571', '137 Elm St', 'assets/patient49.jpg', 'No known allergies', '2024-09-11 21:31:23'),
('Sophia Rodriguez', 'patient50@care.com', '1789717767', 'Group 1', 'Oncology', 'Rest', '1984-02-21 00:00:00', 'patientpass50', 'Emergency Contact 50', '1170950512', 'POL50412', '726 Elm St', 'assets/patient50.jpg', 'Diabetic', '2024-09-23 21:31:23'),
('David Rodriguez', 'patient51@care.com', '1651632879', 'Group 5', 'Orthopedics', 'Quit', '2017-06-11 00:00:00', 'patientpass51', 'Emergency Contact 51', '1329072267', 'POL36894', '846 Elm St', 'assets/patient51.jpg', 'Diabetic', '2024-09-23 21:31:23'),
('James Davis', 'patient52@care.com', '1180795938', 'Group 3', 'Dermatology', 'Online', '1987-01-19 00:00:00', 'patientpass52', 'Emergency Contact 52', '1403487765', 'POL64778', '255 Elm St', 'assets/patient52.jpg', 'High blood pressure', '2024-09-10 21:31:23'),
('Emma Lee', 'patient53@care.com', '1468261770', 'Group 4', 'Dermatology', 'Rest', '2019-03-11 00:00:00', 'patientpass53', 'Emergency Contact 53', '1674917857', 'POL99073', '584 Elm St', 'assets/patient53.jpg', 'Asthma patient', '2024-09-10 21:31:23'),
('Emily Brown', 'patient54@care.com', '1216748204', 'Group 3', 'Oncology', 'Quit', '2012-02-07 00:00:00', 'patientpass54', 'Emergency Contact 54', '1421025711', 'POL73096', '782 Elm St', 'assets/patient54.jpg', 'Asthma patient', '2024-09-23 21:31:23'),
('Sarah Rodriguez', 'patient55@care.com', '1431702419', 'Group 4', 'Pediatrics', 'Online', '1995-01-10 00:00:00', 'patientpass55', 'Emergency Contact 55', '1942492763', 'POL12472', '502 Elm St', 'assets/patient55.jpg', 'Asthma patient', '2024-09-15 21:31:23'),
('Ethan Taylor', 'patient56@care.com', '1549098330', 'Group 1', 'Orthopedics', 'Quit', '1995-05-02 00:00:00', 'patientpass56', 'Emergency Contact 56', '1113270547', 'POL63239', '304 Elm St', 'assets/patient56.jpg', 'Diabetic', '2024-09-21 21:31:23'),
('Michael Miller', 'patient57@care.com', '1439743618', 'Group 1', 'Orthopedics', 'Online', '2000-11-18 00:00:00', 'patientpass57', 'Emergency Contact 57', '1992259116', 'POL15409', '848 Elm St', 'assets/patient57.jpg', 'No known allergies', '2024-09-28 21:31:23'),
('Olivia Miller', 'patient58@care.com', '1295805092', 'Group 2', 'Orthopedics', 'Online', '1987-07-04 00:00:00', 'patientpass58', 'Emergency Contact 58', '1410934319', 'POL56603', '884 Elm St', 'assets/patient58.jpg', 'No notes', '2024-09-26 21:31:23'),
('James Brown', 'patient59@care.com', '1694138919', 'Group 4', 'Orthopedics', 'Online', '1988-02-07 00:00:00', 'patientpass59', 'Emergency Contact 59', '1908792209', 'POL54119', '424 Elm St', 'assets/patient59.jpg', 'Asthma patient', '2024-09-23 21:31:23'),
('Michael Anderson', 'patient60@care.com', '1807769485', 'Group 1', 'Neurology', 'Quit', '1999-02-07 00:00:00', 'patientpass60', 'Emergency Contact 60', '1416956882', 'POL61371', '739 Elm St', 'assets/patient60.jpg', 'High blood pressure', '2024-09-30 21:31:23'),
('Emily Harris', 'patient61@care.com', '1763198967', 'Group 3', 'Dermatology', 'Quit', '1993-09-12 00:00:00', 'patientpass61', 'Emergency Contact 61', '1140071324', 'POL52335', '707 Elm St', 'assets/patient61.jpg', 'High blood pressure', '2024-09-09 21:31:23'),
('Jane Jackson', 'patient62@care.com', '1335476582', 'Group 5', 'Pediatrics', 'Rest', '2012-10-13 00:00:00', 'patientpass62', 'Emergency Contact 62', '1487506548', 'POL26163', '245 Elm St', 'assets/patient62.jpg', 'High blood pressure', '2024-10-02 21:31:23'),
('Emma Clark', 'patient63@care.com', '1944784326', 'Group 5', 'Neurology', 'Quit', '2000-09-21 00:00:00', 'patientpass63', 'Emergency Contact 63', '1493209742', 'POL64715', '324 Elm St', 'assets/patient63.jpg', 'No known allergies', '2024-09-14 21:31:23'),
('Grace Clark', 'patient64@care.com', '1118754343', 'Group 5', 'Oncology', 'Quit', '1994-04-07 00:00:00', 'patientpass64', 'Emergency Contact 64', '1693387015', 'POL17156', '205 Elm St', 'assets/patient64.jpg', 'Asthma patient', '2024-09-30 21:31:23'),
('Jane Thompson', 'patient65@care.com', '1584105446', 'Group 3', 'Dermatology', 'Rest', '2004-07-27 00:00:00', 'patientpass65', 'Emergency Contact 65', '1697628766', 'POL50537', '645 Elm St', 'assets/patient65.jpg', 'Asthma patient', '2024-09-27 21:31:23'),
('John Clark', 'patient66@care.com', '1509535099', 'Group 4', 'Orthopedics', 'Rest', '2010-06-24 00:00:00', 'patientpass66', 'Emergency Contact 66', '1433784280', 'POL24429', '976 Elm St', 'assets/patient66.jpg', 'High blood pressure', '2024-09-28 21:31:23'),
('John Anderson', 'patient67@care.com', '1422839588', 'Group 3', 'Oncology', 'Quit', '2008-08-21 00:00:00', 'patientpass67', 'Emergency Contact 67', '1774971953', 'POL33184', '435 Elm St', 'assets/patient67.jpg', 'No notes', '2024-09-10 21:31:23'),
('Emily Clark', 'patient68@care.com', '1244185315', 'Group 2', 'Pediatrics', 'Quit', '2013-12-19 00:00:00', 'patientpass68', 'Emergency Contact 68', '1762368616', 'POL15573', '132 Elm St', 'assets/patient68.jpg', 'Diabetic', '2024-09-08 21:31:23'),
('Emily Martinez', 'patient69@care.com', '1996952655', 'Group 5', 'Oncology', 'Quit', '2019-08-23 00:00:00', 'patientpass69', 'Emergency Contact 69', '1687648076', 'POL28248', '427 Elm St', 'assets/patient69.jpg', 'Diabetic', '2024-09-14 21:31:23'),
('Olivia Thompson', 'patient70@care.com', '1155569068', 'Group 1', 'Neurology', 'Online', '2015-08-12 00:00:00', 'patientpass70', 'Emergency Contact 70', '1135417792', 'POL27618', '361 Elm St', 'assets/patient70.jpg', 'No known allergies', '2024-09-29 21:31:23'),
('Olivia Martinez', 'patient71@care.com', '1541695108', 'Group 3', 'Orthopedics', 'Online', '1986-07-13 00:00:00', 'patientpass71', 'Emergency Contact 71', '1347650154', 'POL65490', '573 Elm St', 'assets/patient71.jpg', 'Asthma patient', '2024-10-02 21:31:23'),
('Benjamin Lewis', 'patient72@care.com', '1593804941', 'Group 1', 'Dermatology', 'Online', '1988-07-12 00:00:00', 'patientpass72', 'Emergency Contact 72', '1476187273', 'POL88978', '226 Elm St', 'assets/patient72.jpg', 'No known allergies', '2024-09-15 21:31:23'),
('James Johnson', 'patient73@care.com', '1573211411', 'Group 3', 'Dermatology', 'Rest', '2019-01-18 00:00:00', 'patientpass73', 'Emergency Contact 73', '1653156381', 'POL45308', '721 Elm St', 'assets/patient73.jpg', 'Diabetic', '2024-09-23 21:31:23'),
('Benjamin Martinez', 'patient74@care.com', '1856304651', 'Group 5', 'Neurology', 'Online', '1986-12-02 00:00:00', 'patientpass74', 'Emergency Contact 74', '1336700078', 'POL50894', '458 Elm St', 'assets/patient74.jpg', 'Asthma patient', '2024-09-26 21:31:23'),
('Liam Davis', 'patient75@care.com', '1122874261', 'Group 4', 'Dermatology', 'Quit', '1987-01-19 00:00:00', 'patientpass75', 'Emergency Contact 75', '1193014898', 'POL53998', '485 Elm St', 'assets/patient75.jpg', 'No notes', '2024-09-20 21:31:23'),
('James Johnson', 'patient76@care.com', '1509153276', 'Group 3', 'Dermatology', 'Rest', '1991-06-13 00:00:00', 'patientpass76', 'Emergency Contact 76', '1720836730', 'POL63610', '638 Elm St', 'assets/patient76.jpg', 'Asthma patient', '2024-09-15 21:31:23'),
('John Taylor', 'patient77@care.com', '1590634276', 'Group 2', 'Pediatrics', 'Quit', '2017-08-03 00:00:00', 'patientpass77', 'Emergency Contact 77', '1701934920', 'POL91771', '398 Elm St', 'assets/patient77.jpg', 'No known allergies', '2024-09-28 21:31:23'),
('Anna Lewis', 'patient78@care.com', '1123257814', 'Group 3', 'Oncology', 'Rest', '1989-11-11 00:00:00', 'patientpass78', 'Emergency Contact 78', '1222429815', 'POL62727', '654 Elm St', 'assets/patient78.jpg', 'No known allergies', '2024-10-04 21:31:23'),
('Emily Jackson', 'patient79@care.com', '1348217075', 'Group 1', 'Dermatology', 'Online', '1994-10-03 00:00:00', 'patientpass79', 'Emergency Contact 79', '1119836207', 'POL30511', '386 Elm St', 'assets/patient79.jpg', 'Asthma patient', '2024-09-17 21:31:23'),
('Benjamin Lewis', 'patient80@care.com', '1418721693', 'Group 1', 'Orthopedics', 'Online', '1998-06-19 00:00:00', 'patientpass80', 'Emergency Contact 80', '1403359612', 'POL30715', '206 Elm St', 'assets/patient80.jpg', 'No notes', '2024-09-27 21:31:23'),
('Jane Anderson', 'patient81@care.com', '1160089236', 'Group 4', 'Orthopedics', 'Online', '2003-11-02 00:00:00', 'patientpass81', 'Emergency Contact 81', '1592164260', 'POL61709', '635 Elm St', 'assets/patient81.jpg', 'Diabetic', '2024-09-23 21:31:23'),
('Mia Jackson', 'patient82@care.com', '1184978514', 'Group 2', 'Oncology', 'Quit', '1980-03-28 00:00:00', 'patientpass82', 'Emergency Contact 82', '1176671034', 'POL39416', '624 Elm St', 'assets/patient82.jpg', 'High blood pressure', '2024-09-28 21:31:23'),
('Liam Lewis', 'patient83@care.com', '1749552465', 'Group 5', 'Orthopedics', 'Online', '2000-12-04 00:00:00', 'patientpass83', 'Emergency Contact 83', '1874461247', 'POL92397', '615 Elm St', 'assets/patient83.jpg', 'No known allergies', '2024-09-13 21:31:23'),
('Mia Brown', 'patient84@care.com', '1594637125', 'Group 2', 'Pediatrics', 'Rest', '1982-06-07 00:00:00', 'patientpass84', 'Emergency Contact 84', '1629856105', 'POL22894', '626 Elm St', 'assets/patient84.jpg', 'High blood pressure', '2024-09-14 21:31:23'),
('Jane Lewis', 'patient85@care.com', '1253531138', 'Group 3', 'Neurology', 'Quit', '2011-09-02 00:00:00', 'patientpass85', 'Emergency Contact 85', '1293259547', 'POL89674', '362 Elm St', 'assets/patient85.jpg', 'No known allergies', '2024-09-16 21:31:23'),
('Olivia Rodriguez', 'patient86@care.com', '1409655591', 'Group 4', 'Oncology', 'Quit', '2000-05-17 00:00:00', 'patientpass86', 'Emergency Contact 86', '1978040349', 'POL60961', '940 Elm St', 'assets/patient86.jpg', 'Diabetic', '2024-09-23 21:31:23'),
('Mia Harris', 'patient87@care.com', '1158711446', 'Group 4', 'Dermatology', 'Rest', '1980-04-04 00:00:00', 'patientpass87', 'Emergency Contact 87', '1837876291', 'POL95256', '484 Elm St', 'assets/patient87.jpg', 'Diabetic', '2024-10-03 21:31:23'),
('Benjamin Smith', 'patient88@care.com', '1222096822', 'Group 2', 'Oncology', 'Quit', '1987-12-27 00:00:00', 'patientpass88', 'Emergency Contact 88', '1672963472', 'POL92832', '609 Elm St', 'assets/patient88.jpg', 'Asthma patient', '2024-09-30 21:31:23'),
('Michael Miller', 'patient89@care.com', '1996461696', 'Group 3', 'Pediatrics', 'Online', '1991-04-10 00:00:00', 'patientpass89', 'Emergency Contact 89', '1404015769', 'POL61138', '814 Elm St', 'assets/patient89.jpg', 'No notes', '2024-09-09 21:31:23'),
('Laura Miller', 'patient90@care.com', '1775000855', 'Group 1', 'Dermatology', 'Quit', '2007-09-03 00:00:00', 'patientpass90', 'Emergency Contact 90', '1252676112', 'POL68147', '362 Elm St', 'assets/patient90.jpg', 'High blood pressure', '2024-09-20 21:31:23'),
('Daniel Garcia', 'patient91@care.com', '1592235920', 'Group 2', 'Dermatology', 'Online', '1986-01-17 00:00:00', 'patientpass91', 'Emergency Contact 91', '1445147931', 'POL12702', '827 Elm St', 'assets/patient91.jpg', 'No notes', '2024-09-24 21:31:23'),
('John Harris', 'patient92@care.com', '1767386096', 'Group 4', 'Orthopedics', 'Rest', '1986-10-13 00:00:00', 'patientpass92', 'Emergency Contact 92', '1921892609', 'POL62606', '959 Elm St', 'assets/patient92.jpg', 'Asthma patient', '2024-09-27 21:31:23'),
('Benjamin Smith', 'patient93@care.com', '1354163732', 'Group 3', 'Neurology', 'Rest', '2005-09-20 00:00:00', 'patientpass93', 'Emergency Contact 93', '1893586569', 'POL76221', '135 Elm St', 'assets/patient93.jpg', 'High blood pressure', '2024-09-15 21:31:23'),
('Liam Johnson', 'patient94@care.com', '1207004329', 'Group 5', 'Neurology', 'Rest', '1991-04-01 00:00:00', 'patientpass94', 'Emergency Contact 94', '1146219972', 'POL96506', '710 Elm St', 'assets/patient94.jpg', 'Diabetic', '2024-09-27 21:31:23'),
('James Jackson', 'patient95@care.com', '1510349915', 'Group 3', 'Oncology', 'Quit', '1999-10-07 00:00:00', 'patientpass95', 'Emergency Contact 95', '1772544096', 'POL39039', '889 Elm St', 'assets/patient95.jpg', 'Diabetic', '2024-10-01 21:31:23'),
('Grace Johnson', 'patient96@care.com', '1293843421', 'Group 1', 'Neurology', 'Quit', '2014-12-18 00:00:00', 'patientpass96', 'Emergency Contact 96', '1852247571', 'POL60519', '434 Elm St', 'assets/patient96.jpg', 'High blood pressure', '2024-09-26 21:31:23'),
('Ethan Moore', 'patient97@care.com', '1554144491', 'Group 2', 'Dermatology', 'Quit', '2009-04-01 00:00:00', 'patientpass97', 'Emergency Contact 97', '1168648492', 'POL50218', '567 Elm St', 'assets/patient97.jpg', 'Diabetic', '2024-09-26 21:31:23'),
('Jane Lewis', 'patient98@care.com', '1548062338', 'Group 2', 'Pediatrics', 'Online', '2006-04-12 00:00:00', 'patientpass98', 'Emergency Contact 98', '1196640445', 'POL96035', '552 Elm St', 'assets/patient98.jpg', 'No known allergies', '2024-09-12 21:31:23'),
('Liam Martinez', 'patient99@care.com', '1181948114', 'Group 2', 'Orthopedics', 'Quit', '1991-07-25 00:00:00', 'patientpass99', 'Emergency Contact 99', '1236880237', 'POL18150', '529 Elm St', 'assets/patient99.jpg', 'No known allergies', '2024-09-12 21:31:23'),
('Liam Miller', 'patient100@care.com', '1275975426', 'Group 3', 'Pediatrics', 'Online', '2007-02-19 00:00:00', 'patientpass100', 'Emergency Contact 100', '1202573643', 'POL26926', '671 Elm St', 'assets/patient100.jpg', 'High blood pressure', '2024-09-26 21:31:23'),
('Robert Rodriguez', 'patient101@care.com', '1567120018', 'Group 1', 'Pediatrics', 'Quit', '1996-01-13 00:00:00', 'patientpass101', 'Emergency Contact 101', '1105147477', 'POL33943', '572 Elm St', 'assets/patient101.jpg', 'High blood pressure', '2024-09-12 21:31:23'),
('David Taylor', 'patient102@care.com', '1573120822', 'Group 3', 'Dermatology', 'Quit', '1999-12-09 00:00:00', 'patientpass102', 'Emergency Contact 102', '1610688754', 'POL91714', '618 Elm St', 'assets/patient102.jpg', 'Asthma patient', '2024-09-10 21:31:23'),
('Lucas Rodriguez', 'patient103@care.com', '1684557687', 'Group 4', 'Neurology', 'Quit', '2002-01-24 00:00:00', 'patientpass103', 'Emergency Contact 103', '1440433340', 'POL18004', '887 Elm St', 'assets/patient103.jpg', 'No notes', '2024-09-12 21:31:23'),
('Benjamin Lewis', 'patient104@care.com', '1536844445', 'Group 1', 'Pediatrics', 'Online', '1998-06-15 00:00:00', 'patientpass104', 'Emergency Contact 104', '1397678389', 'POL79707', '653 Elm St', 'assets/patient104.jpg', 'No known allergies', '2024-10-04 21:31:23'),
('Benjamin Clark', 'patient105@care.com', '1206585769', 'Group 1', 'Dermatology', 'Rest', '2000-04-25 00:00:00', 'patientpass105', 'Emergency Contact 105', '1984337542', 'POL72585', '116 Elm St', 'assets/patient105.jpg', 'No known allergies', '2024-09-24 21:31:23'),
('Grace Davis', 'patient106@care.com', '1581390662', 'Group 3', 'Dermatology', 'Rest', '2006-02-22 00:00:00', 'patientpass106', 'Emergency Contact 106', '1299606227', 'POL19419', '445 Elm St', 'assets/patient106.jpg', 'No notes', '2024-09-16 21:31:23'),
('David Brown', 'patient107@care.com', '1832995853', 'Group 3', 'Dermatology', 'Online', '2008-05-25 00:00:00', 'patientpass107', 'Emergency Contact 107', '1487524682', 'POL75339', '166 Elm St', 'assets/patient107.jpg', 'No notes', '2024-09-11 21:31:23'),
('Liam Jackson', 'patient108@care.com', '1393558812', 'Group 3', 'Dermatology', 'Rest', '1995-09-28 00:00:00', 'patientpass108', 'Emergency Contact 108', '1961378518', 'POL56317', '311 Elm St', 'assets/patient108.jpg', 'No known allergies', '2024-10-05 21:31:23'),
('Olivia Garcia', 'patient109@care.com', '1398668390', 'Group 3', 'Oncology', 'Quit', '1989-05-26 00:00:00', 'patientpass109', 'Emergency Contact 109', '1297431670', 'POL96423', '680 Elm St', 'assets/patient109.jpg', 'Asthma patient', '2024-09-14 21:31:23'),
('Liam Martinez', 'patient110@care.com', '1715317354', 'Group 1', 'Neurology', 'Rest', '2000-03-04 00:00:00', 'patientpass110', 'Emergency Contact 110', '1190506746', 'POL88917', '666 Elm St', 'assets/patient110.jpg', 'Asthma patient', '2024-10-05 21:31:23'),
('David Moore', 'patient111@care.com', '1803485056', 'Group 3', 'Oncology', 'Online', '2006-06-01 00:00:00', 'patientpass111', 'Emergency Contact 111', '1770093142', 'POL31623', '761 Elm St', 'assets/patient111.jpg', 'No known allergies', '2024-09-19 21:31:23'),
('Mia Moore', 'patient112@care.com', '1626270261', 'Group 3', 'Dermatology', 'Quit', '2010-12-22 00:00:00', 'patientpass112', 'Emergency Contact 112', '1479279302', 'POL39626', '366 Elm St', 'assets/patient112.jpg', 'High blood pressure', '2024-10-03 21:31:23'),
('Ethan Lewis', 'patient113@care.com', '1266686011', 'Group 5', 'Neurology', 'Rest', '1986-02-10 00:00:00', 'patientpass113', 'Emergency Contact 113', '1699722724', 'POL17114', '890 Elm St', 'assets/patient113.jpg', 'No known allergies', '2024-09-24 21:31:23'),
('Michael White', 'patient114@care.com', '1820115963', 'Group 5', 'Dermatology', 'Online', '1990-08-27 00:00:00', 'patientpass114', 'Emergency Contact 114', '1965914130', 'POL89712', '490 Elm St', 'assets/patient114.jpg', 'Asthma patient', '2024-09-06 21:31:23'),
('Benjamin Martinez', 'patient115@care.com', '1219286388', 'Group 4', 'Neurology', 'Online', '2000-09-16 00:00:00', 'patientpass115', 'Emergency Contact 115', '1358483671', 'POL38847', '910 Elm St', 'assets/patient115.jpg', 'No notes', '2024-09-25 21:31:23'),
('David Wilson', 'patient116@care.com', '1639166065', 'Group 3', 'Pediatrics', 'Rest', '1986-04-05 00:00:00', 'patientpass116', 'Emergency Contact 116', '1238768620', 'POL44010', '840 Elm St', 'assets/patient116.jpg', 'Diabetic', '2024-09-14 21:31:23'),
('Mia Garcia', 'patient117@care.com', '1310290676', 'Group 2', 'Orthopedics', 'Online', '2018-03-17 00:00:00', 'patientpass117', 'Emergency Contact 117', '1907948120', 'POL40020', '850 Elm St', 'assets/patient117.jpg', 'No known allergies', '2024-10-05 21:31:23'),
('Mia Walker', 'patient118@care.com', '1980998015', 'Group 3', 'Oncology', 'Quit', '2002-03-04 00:00:00', 'patientpass118', 'Emergency Contact 118', '1548934775', 'POL87050', '108 Elm St', 'assets/patient118.jpg', 'High blood pressure', '2024-09-09 21:31:23'),
('Sarah Brown', 'patient119@care.com', '1920121754', 'Group 2', 'Pediatrics', 'Quit', '1986-03-20 00:00:00', 'patientpass119', 'Emergency Contact 119', '1238689907', 'POL95776', '474 Elm St', 'assets/patient119.jpg', 'No notes', '2024-09-21 21:31:23'),
('Olivia Clark', 'patient120@care.com', '1424950185', 'Group 2', 'Pediatrics', 'Rest', '2002-06-21 00:00:00', 'patientpass120', 'Emergency Contact 120', '1669916354', 'POL46768', '867 Elm St', 'assets/patient120.jpg', 'High blood pressure', '2024-10-04 21:31:23'),
('James Harris', 'patient121@care.com', '1988120666', 'Group 5', 'Dermatology', 'Rest', '1995-04-24 00:00:00', 'patientpass121', 'Emergency Contact 121', '1143824673', 'POL52338', '911 Elm St', 'assets/patient121.jpg', 'Diabetic', '2024-09-25 21:31:23'),
('Sarah Wilson', 'patient122@care.com', '1812079590', 'Group 4', 'Orthopedics', 'Quit', '2013-12-07 00:00:00', 'patientpass122', 'Emergency Contact 122', '1854273557', 'POL72770', '427 Elm St', 'assets/patient122.jpg', 'Diabetic', '2024-09-18 21:31:23'),
('Olivia Brown', 'patient123@care.com', '1371571906', 'Group 1', 'Pediatrics', 'Rest', '2004-09-06 00:00:00', 'patientpass123', 'Emergency Contact 123', '1637726270', 'POL99386', '164 Elm St', 'assets/patient123.jpg', 'High blood pressure', '2024-09-15 21:31:23'),
('Laura Martinez', 'patient124@care.com', '1612901078', 'Group 1', 'Pediatrics', 'Online', '2007-05-02 00:00:00', 'patientpass124', 'Emergency Contact 124', '1994152321', 'POL15317', '413 Elm St', 'assets/patient124.jpg', 'No known allergies', '2024-09-12 21:31:23'),
('Benjamin Harris', 'patient125@care.com', '1933527771', 'Group 1', 'Dermatology', 'Rest', '2014-01-09 00:00:00', 'patientpass125', 'Emergency Contact 125', '1326725102', 'POL48380', '448 Elm St', 'assets/patient125.jpg', 'Diabetic', '2024-09-21 21:31:23'),
('Mia Martinez', 'patient126@care.com', '1874763268', 'Group 1', 'Neurology', 'Quit', '1999-07-24 00:00:00', 'patientpass126', 'Emergency Contact 126', '1930501888', 'POL71561', '715 Elm St', 'assets/patient126.jpg', 'Asthma patient', '2024-09-28 21:31:23'),
('John Wilson', 'patient127@care.com', '1759458162', 'Group 5', 'Oncology', 'Online', '1983-06-21 00:00:00', 'patientpass127', 'Emergency Contact 127', '1100486428', 'POL62223', '527 Elm St', 'assets/patient127.jpg', 'No notes', '2024-10-01 21:31:23'),
('David Harris', 'patient128@care.com', '1970600979', 'Group 5', 'Neurology', 'Rest', '2013-10-24 00:00:00', 'patientpass128', 'Emergency Contact 128', '1352678177', 'POL98867', '238 Elm St', 'assets/patient128.jpg', 'No known allergies', '2024-09-20 21:31:23'),
('Daniel Brown', 'patient129@care.com', '1100532112', 'Group 1', 'Neurology', 'Quit', '1995-05-20 00:00:00', 'patientpass129', 'Emergency Contact 129', '1271842249', 'POL97659', '702 Elm St', 'assets/patient129.jpg', 'Asthma patient', '2024-09-15 21:31:23'),
('Benjamin Davis', 'patient130@care.com', '1205488794', 'Group 2', 'Orthopedics', 'Online', '2008-06-26 00:00:00', 'patientpass130', 'Emergency Contact 130', '1455056554', 'POL93926', '341 Elm St', 'assets/patient130.jpg', 'Diabetic', '2024-09-18 21:31:23'),
('Liam Harris', 'patient131@care.com', '1387835691', 'Group 5', 'Oncology', 'Quit', '1995-07-01 00:00:00', 'patientpass131', 'Emergency Contact 131', '1835017138', 'POL38591', '864 Elm St', 'assets/patient131.jpg', 'High blood pressure', '2024-09-26 21:31:23'),
('James Moore', 'patient132@care.com', '1518464796', 'Group 3', 'Dermatology', 'Rest', '1980-07-20 00:00:00', 'patientpass132', 'Emergency Contact 132', '1380227376', 'POL82262', '872 Elm St', 'assets/patient132.jpg', 'No known allergies', '2024-09-21 21:31:23'),
('Sophia White', 'patient133@care.com', '1748984679', 'Group 3', 'Neurology', 'Quit', '1995-03-26 00:00:00', 'patientpass133', 'Emergency Contact 133', '1558297182', 'POL65780', '538 Elm St', 'assets/patient133.jpg', 'Asthma patient', '2024-09-21 21:31:23'),
('Grace Taylor', 'patient134@care.com', '1461759681', 'Group 5', 'Pediatrics', 'Rest', '2006-03-09 00:00:00', 'patientpass134', 'Emergency Contact 134', '1490983358', 'POL42392', '922 Elm St', 'assets/patient134.jpg', 'High blood pressure', '2024-09-21 21:31:23'),
('Robert Martinez', 'patient135@care.com', '1204738124', 'Group 1', 'Oncology', 'Rest', '2003-12-24 00:00:00', 'patientpass135', 'Emergency Contact 135', '1824833398', 'POL66181', '526 Elm St', 'assets/patient135.jpg', 'No known allergies', '2024-10-02 21:31:23'),
('Michael Davis', 'patient136@care.com', '1646254025', 'Group 5', 'Orthopedics', 'Rest', '1992-03-22 00:00:00', 'patientpass136', 'Emergency Contact 136', '1741632392', 'POL94467', '142 Elm St', 'assets/patient136.jpg', 'Asthma patient', '2024-09-10 21:31:23'),
('Ethan Smith', 'patient137@care.com', '1172931609', 'Group 2', 'Dermatology', 'Online', '1987-07-05 00:00:00', 'patientpass137', 'Emergency Contact 137', '1334408322', 'POL38030', '582 Elm St', 'assets/patient137.jpg', 'High blood pressure', '2024-09-07 21:31:23'),
('Ethan Garcia', 'patient138@care.com', '1569992961', 'Group 1', 'Oncology', 'Rest', '1989-02-26 00:00:00', 'patientpass138', 'Emergency Contact 138', '1884543045', 'POL38444', '150 Elm St', 'assets/patient138.jpg', 'No notes', '2024-09-09 21:31:23'),
('Jane Brown', 'patient139@care.com', '1643545745', 'Group 5', 'Oncology', 'Quit', '2003-04-28 00:00:00', 'patientpass139', 'Emergency Contact 139', '1141643624', 'POL26613', '318 Elm St', 'assets/patient139.jpg', 'No known allergies', '2024-09-24 21:31:23'),
('James Jackson', 'patient140@care.com', '1661040833', 'Group 1', 'Orthopedics', 'Rest', '2004-03-14 00:00:00', 'patientpass140', 'Emergency Contact 140', '1488138948', 'POL45404', '162 Elm St', 'assets/patient140.jpg', 'Diabetic', '2024-09-24 21:31:23'),
('Robert Brown', 'patient141@care.com', '1924677313', 'Group 2', 'Neurology', 'Rest', '2001-02-28 00:00:00', 'patientpass141', 'Emergency Contact 141', '1753943304', 'POL26951', '544 Elm St', 'assets/patient141.jpg', 'No known allergies', '2024-09-06 21:31:23'),
('Robert Moore', 'patient142@care.com', '1355021462', 'Group 5', 'Pediatrics', 'Rest', '2005-12-21 00:00:00', 'patientpass142', 'Emergency Contact 142', '1362809602', 'POL60937', '126 Elm St', 'assets/patient142.jpg', 'No known allergies', '2024-09-14 21:31:23'),
('Sarah Jackson', 'patient143@care.com', '1159282900', 'Group 1', 'Pediatrics', 'Quit', '2011-11-12 00:00:00', 'patientpass143', 'Emergency Contact 143', '1950093364', 'POL78996', '719 Elm St', 'assets/patient143.jpg', 'No known allergies', '2024-09-12 21:31:23'),
('Sophia Miller', 'patient144@care.com', '1146694980', 'Group 3', 'Dermatology', 'Rest', '1989-09-08 00:00:00', 'patientpass144', 'Emergency Contact 144', '1880935906', 'POL86875', '112 Elm St', 'assets/patient144.jpg', 'Asthma patient', '2024-09-24 21:31:23'),
('Anna Smith', 'patient145@care.com', '1173488590', 'Group 1', 'Dermatology', 'Quit', '1981-09-24 00:00:00', 'patientpass145', 'Emergency Contact 145', '1238542029', 'POL65271', '102 Elm St', 'assets/patient145.jpg', 'Asthma patient', '2024-09-13 21:31:23'),
('Anna Brown', 'patient146@care.com', '1369215357', 'Group 5', 'Neurology', 'Online', '1986-01-26 00:00:00', 'patientpass146', 'Emergency Contact 146', '1479706008', 'POL34600', '732 Elm St', 'assets/patient146.jpg', 'High blood pressure', '2024-09-13 21:31:23'),
('Daniel Smith', 'patient147@care.com', '1470984278', 'Group 5', 'Dermatology', 'Quit', '1997-07-06 00:00:00', 'patientpass147', 'Emergency Contact 147', '1219802217', 'POL82257', '248 Elm St', 'assets/patient147.jpg', 'Asthma patient', '2024-09-16 21:31:23'),
('Anna Smith', 'patient148@care.com', '1789709614', 'Group 4', 'Dermatology', 'Rest', '2006-02-22 00:00:00', 'patientpass148', 'Emergency Contact 148', '1808564528', 'POL73961', '561 Elm St', 'assets/patient148.jpg', 'No known allergies', '2024-09-19 21:31:23'),
('David Miller', 'patient149@care.com', '1778155969', 'Group 1', 'Dermatology', 'Rest', '2003-09-14 00:00:00', 'patientpass149', 'Emergency Contact 149', '1859437023', 'POL76298', '705 Elm St', 'assets/patient149.jpg', 'High blood pressure', '2024-09-25 21:31:23'),
('Olivia Brown', 'patient150@care.com', '1181881611', 'Group 4', 'Neurology', 'Quit', '1982-01-04 00:00:00', 'patientpass150', 'Emergency Contact 150', '1890035859', 'POL13906', '357 Elm St', 'assets/patient150.jpg', 'Diabetic', '2024-10-05 21:31:23'),
('Mia Walker', 'patient151@care.com', '1128498399', 'Group 5', 'Neurology', 'Rest', '2003-08-28 00:00:00', 'patientpass151', 'Emergency Contact 151', '1473130788', 'POL47025', '236 Elm St', 'assets/patient151.jpg', 'High blood pressure', '2024-09-08 21:31:23'),
('Ethan Rodriguez', 'patient152@care.com', '1199626371', 'Group 2', 'Orthopedics', 'Online', '1994-03-11 00:00:00', 'patientpass152', 'Emergency Contact 152', '1606048941', 'POL72268', '625 Elm St', 'assets/patient152.jpg', 'High blood pressure', '2024-09-22 21:31:23'),
('James Harris', 'patient153@care.com', '1584205023', 'Group 4', 'Pediatrics', 'Online', '2003-02-02 00:00:00', 'patientpass153', 'Emergency Contact 153', '1291999940', 'POL59718', '722 Elm St', 'assets/patient153.jpg', 'Asthma patient', '2024-09-10 21:31:23'),
('Sarah Moore', 'patient154@care.com', '1726682362', 'Group 3', 'Neurology', 'Quit', '1983-12-26 00:00:00', 'patientpass154', 'Emergency Contact 154', '1599170212', 'POL69519', '467 Elm St', 'assets/patient154.jpg', 'Diabetic', '2024-09-11 21:31:23'),
('Ethan Jackson', 'patient155@care.com', '1468483392', 'Group 1', 'Neurology', 'Rest', '2017-08-06 00:00:00', 'patientpass155', 'Emergency Contact 155', '1989694668', 'POL79641', '508 Elm St', 'assets/patient155.jpg', 'High blood pressure', '2024-09-25 21:31:23'),
('Emily Harris', 'patient156@care.com', '1249794822', 'Group 1', 'Dermatology', 'Rest', '2002-07-01 00:00:00', 'patientpass156', 'Emergency Contact 156', '1487444223', 'POL34865', '259 Elm St', 'assets/patient156.jpg', 'No notes', '2024-09-28 21:31:23'),
('James Miller', 'patient157@care.com', '1132150549', 'Group 3', 'Pediatrics', 'Rest', '1993-10-21 00:00:00', 'patientpass157', 'Emergency Contact 157', '1173401054', 'POL97969', '263 Elm St', 'assets/patient157.jpg', 'Diabetic', '2024-09-20 21:31:23'),
('Olivia Johnson', 'patient158@care.com', '1190666579', 'Group 2', 'Pediatrics', 'Quit', '1987-07-01 00:00:00', 'patientpass158', 'Emergency Contact 158', '1384425602', 'POL44213', '147 Elm St', 'assets/patient158.jpg', 'High blood pressure', '2024-10-01 21:31:23'),
('Laura Moore', 'patient159@care.com', '1685746987', 'Group 5', 'Orthopedics', 'Rest', '1986-08-19 00:00:00', 'patientpass159', 'Emergency Contact 159', '1460420482', 'POL44351', '929 Elm St', 'assets/patient159.jpg', 'Diabetic', '2024-09-24 21:31:23'),
('Robert Martinez', 'patient160@care.com', '1946721324', 'Group 1', 'Oncology', 'Online', '2014-08-09 00:00:00', 'patientpass160', 'Emergency Contact 160', '1139960716', 'POL13348', '289 Elm St', 'assets/patient160.jpg', 'No known allergies', '2024-09-29 21:31:23'),
('David Clark', 'patient161@care.com', '1428826824', 'Group 4', 'Orthopedics', 'Online', '1982-07-02 00:00:00', 'patientpass161', 'Emergency Contact 161', '1130659209', 'POL85383', '811 Elm St', 'assets/patient161.jpg', 'Asthma patient', '2024-09-29 21:31:23'),
('Lucas Lee', 'patient162@care.com', '1362469095', 'Group 4', 'Orthopedics', 'Quit', '2010-10-07 00:00:00', 'patientpass162', 'Emergency Contact 162', '1310944559', 'POL34798', '490 Elm St', 'assets/patient162.jpg', 'Diabetic', '2024-09-22 21:31:23'),
('Sophia Clark', 'patient163@care.com', '1413900785', 'Group 2', 'Pediatrics', 'Rest', '1993-06-05 00:00:00', 'patientpass163', 'Emergency Contact 163', '1266053360', 'POL96534', '407 Elm St', 'assets/patient163.jpg', 'Diabetic', '2024-10-01 21:31:23'),
('Laura Clark', 'patient164@care.com', '1602725397', 'Group 5', 'Orthopedics', 'Online', '2013-11-27 00:00:00', 'patientpass164', 'Emergency Contact 164', '1142765587', 'POL96650', '902 Elm St', 'assets/patient164.jpg', 'No known allergies', '2024-09-09 21:31:23'),
('Daniel Wilson', 'patient165@care.com', '1932388981', 'Group 5', 'Dermatology', 'Rest', '1984-02-15 00:00:00', 'patientpass165', 'Emergency Contact 165', '1898618413', 'POL62058', '693 Elm St', 'assets/patient165.jpg', 'High blood pressure', '2024-09-09 21:31:23'),
('Lucas Smith', 'patient166@care.com', '1928223573', 'Group 1', 'Pediatrics', 'Quit', '1988-02-16 00:00:00', 'patientpass166', 'Emergency Contact 166', '1579952444', 'POL38885', '433 Elm St', 'assets/patient166.jpg', 'High blood pressure', '2024-09-19 21:31:23'),
('John Davis', 'patient167@care.com', '1955556095', 'Group 4', 'Neurology', 'Online', '1998-12-18 00:00:00', 'patientpass167', 'Emergency Contact 167', '1212252642', 'POL64349', '994 Elm St', 'assets/patient167.jpg', 'No known allergies', '2024-09-08 21:31:23'),
('Emma Miller', 'patient168@care.com', '1771800772', 'Group 3', 'Pediatrics', 'Online', '2017-03-12 00:00:00', 'patientpass168', 'Emergency Contact 168', '1352630840', 'POL71341', '331 Elm St', 'assets/patient168.jpg', 'No notes', '2024-09-20 21:31:23'),
('James Walker', 'patient169@care.com', '1678311393', 'Group 4', 'Neurology', 'Quit', '2012-07-26 00:00:00', 'patientpass169', 'Emergency Contact 169', '1223798895', 'POL36094', '455 Elm St', 'assets/patient169.jpg', 'Diabetic', '2024-09-25 21:31:23'),
('Olivia Clark', 'patient170@care.com', '1829580985', 'Group 4', 'Oncology', 'Online', '2000-02-21 00:00:00', 'patientpass170', 'Emergency Contact 170', '1366754690', 'POL40010', '802 Elm St', 'assets/patient170.jpg', 'Asthma patient', '2024-09-06 21:31:23'),
('Ethan Wilson', 'patient171@care.com', '1199183044', 'Group 4', 'Neurology', 'Rest', '1981-03-19 00:00:00', 'patientpass171', 'Emergency Contact 171', '1161549028', 'POL84151', '592 Elm St', 'assets/patient171.jpg', 'Diabetic', '2024-09-16 21:31:23'),
('Olivia Lewis', 'patient172@care.com', '1329979397', 'Group 5', 'Orthopedics', 'Quit', '1984-10-17 00:00:00', 'patientpass172', 'Emergency Contact 172', '1305130772', 'POL92563', '791 Elm St', 'assets/patient172.jpg', 'No known allergies', '2024-09-09 21:31:23'),
('Jane Johnson', 'patient173@care.com', '1553083961', 'Group 2', 'Neurology', 'Online', '1985-10-16 00:00:00', 'patientpass173', 'Emergency Contact 173', '1281624330', 'POL89374', '615 Elm St', 'assets/patient173.jpg', 'Diabetic', '2024-10-04 21:31:23'),
('Olivia Anderson', 'patient174@care.com', '1294824793', 'Group 5', 'Oncology', 'Rest', '2018-10-13 00:00:00', 'patientpass174', 'Emergency Contact 174', '1661693432', 'POL42446', '551 Elm St', 'assets/patient174.jpg', 'No notes', '2024-09-28 21:31:23'),
('Liam White', 'patient175@care.com', '1715615314', 'Group 4', 'Dermatology', 'Online', '1996-05-11 00:00:00', 'patientpass175', 'Emergency Contact 175', '1803189244', 'POL84675', '909 Elm St', 'assets/patient175.jpg', 'Diabetic', '2024-09-27 21:31:23'),
('Emily Taylor', 'patient176@care.com', '1602536726', 'Group 4', 'Dermatology', 'Online', '2005-08-12 00:00:00', 'patientpass176', 'Emergency Contact 176', '1479840022', 'POL41844', '603 Elm St', 'assets/patient176.jpg', 'Diabetic', '2024-09-23 21:31:23'),
('Daniel Garcia', 'patient177@care.com', '1561099769', 'Group 5', 'Orthopedics', 'Rest', '2006-06-02 00:00:00', 'patientpass177', 'Emergency Contact 177', '1684692686', 'POL20340', '261 Elm St', 'assets/patient177.jpg', 'Diabetic', '2024-09-09 21:31:23'),
('Emily Rodriguez', 'patient178@care.com', '1951028985', 'Group 1', 'Dermatology', 'Rest', '2015-10-20 00:00:00', 'patientpass178', 'Emergency Contact 178', '1888718110', 'POL52298', '678 Elm St', 'assets/patient178.jpg', 'Diabetic', '2024-09-30 21:31:23'),
('Grace Anderson', 'patient179@care.com', '1816777980', 'Group 3', 'Neurology', 'Quit', '2012-10-07 00:00:00', 'patientpass179', 'Emergency Contact 179', '1243347639', 'POL65445', '350 Elm St', 'assets/patient179.jpg', 'Diabetic', '2024-09-08 21:31:23'),
('Daniel Thompson', 'patient180@care.com', '1238541972', 'Group 4', 'Pediatrics', 'Online', '1982-04-03 00:00:00', 'patientpass180', 'Emergency Contact 180', '1629057875', 'POL29902', '810 Elm St', 'assets/patient180.jpg', 'No notes', '2024-09-15 21:31:23'),
('Mia Anderson', 'patient181@care.com', '1691018780', 'Group 3', 'Pediatrics', 'Online', '1981-04-05 00:00:00', 'patientpass181', 'Emergency Contact 181', '1536507101', 'POL13538', '271 Elm St', 'assets/patient181.jpg', 'Diabetic', '2024-09-11 21:31:23'),
('Emma Walker', 'patient182@care.com', '1636036958', 'Group 2', 'Pediatrics', 'Online', '1982-06-26 00:00:00', 'patientpass182', 'Emergency Contact 182', '1130908651', 'POL46610', '563 Elm St', 'assets/patient182.jpg', 'No known allergies', '2024-09-24 21:31:23'),
('John Brown', 'patient183@care.com', '1206742609', 'Group 5', 'Dermatology', 'Quit', '1993-02-08 00:00:00', 'patientpass183', 'Emergency Contact 183', '1928696875', 'POL35393', '913 Elm St', 'assets/patient183.jpg', 'Asthma patient', '2024-09-16 21:31:23'),
('Jane Jackson', 'patient184@care.com', '1160218444', 'Group 4', 'Neurology', 'Rest', '2018-11-15 00:00:00', 'patientpass184', 'Emergency Contact 184', '1541206984', 'POL57721', '898 Elm St', 'assets/patient184.jpg', 'Asthma patient', '2024-09-26 21:31:23'),
('Daniel Anderson', 'patient185@care.com', '1468835202', 'Group 1', 'Dermatology', 'Quit', '1993-08-08 00:00:00', 'patientpass185', 'Emergency Contact 185', '1386299049', 'POL45338', '141 Elm St', 'assets/patient185.jpg', 'Asthma patient', '2024-09-08 21:31:23'),
('Michael Anderson', 'patient186@care.com', '1620951818', 'Group 4', 'Neurology', 'Rest', '2007-11-01 00:00:00', 'patientpass186', 'Emergency Contact 186', '1975312857', 'POL31125', '329 Elm St', 'assets/patient186.jpg', 'High blood pressure', '2024-09-14 21:31:23'),
('Lucas Davis', 'patient187@care.com', '1958420941', 'Group 1', 'Dermatology', 'Rest', '2002-09-28 00:00:00', 'patientpass187', 'Emergency Contact 187', '1836264507', 'POL81318', '341 Elm St', 'assets/patient187.jpg', 'No notes', '2024-09-10 21:31:23'),
('Emma Brown', 'patient188@care.com', '1949134936', 'Group 4', 'Orthopedics', 'Online', '1981-11-10 00:00:00', 'patientpass188', 'Emergency Contact 188', '1318757909', 'POL63809', '550 Elm St', 'assets/patient188.jpg', 'Asthma patient', '2024-10-03 21:31:23'),
('John Smith', 'patient189@care.com', '1538251439', 'Group 2', 'Oncology', 'Rest', '2000-06-28 00:00:00', 'patientpass189', 'Emergency Contact 189', '1719599105', 'POL26583', '380 Elm St', 'assets/patient189.jpg', 'No known allergies', '2024-09-27 21:31:23'),
('Anna Lee', 'patient190@care.com', '1269620079', 'Group 2', 'Orthopedics', 'Online', '2002-03-06 00:00:00', 'patientpass190', 'Emergency Contact 190', '1890416086', 'POL74294', '611 Elm St', 'assets/patient190.jpg', 'No known allergies', '2024-09-15 21:31:23'),
('Michael Garcia', 'patient191@care.com', '1443104421', 'Group 4', 'Neurology', 'Quit', '2011-05-18 00:00:00', 'patientpass191', 'Emergency Contact 191', '1595812821', 'POL26968', '518 Elm St', 'assets/patient191.jpg', 'High blood pressure', '2024-09-25 21:31:23'),
('Emma White', 'patient192@care.com', '1586443901', 'Group 3', 'Oncology', 'Quit', '1995-01-05 00:00:00', 'patientpass192', 'Emergency Contact 192', '1623558472', 'POL47246', '552 Elm St', 'assets/patient192.jpg', 'No notes', '2024-09-29 21:31:23'),
('Ethan Miller', 'patient193@care.com', '1903991623', 'Group 1', 'Orthopedics', 'Quit', '1994-12-20 00:00:00', 'patientpass193', 'Emergency Contact 193', '1143600194', 'POL26872', '524 Elm St', 'assets/patient193.jpg', 'No known allergies', '2024-09-15 21:31:23'),
('Anna Brown', 'patient194@care.com', '1866316201', 'Group 5', 'Orthopedics', 'Quit', '2009-01-11 00:00:00', 'patientpass194', 'Emergency Contact 194', '1553557340', 'POL38934', '663 Elm St', 'assets/patient194.jpg', 'Asthma patient', '2024-09-22 21:31:23'),
('Ethan Walker', 'patient195@care.com', '1718967213', 'Group 5', 'Dermatology', 'Online', '1995-06-26 00:00:00', 'patientpass195', 'Emergency Contact 195', '1106453564', 'POL26315', '798 Elm St', 'assets/patient195.jpg', 'High blood pressure', '2024-09-29 21:31:23'),
('Ethan Walker', 'patient196@care.com', '1508206499', 'Group 1', 'Pediatrics', 'Online', '2008-09-18 00:00:00', 'patientpass196', 'Emergency Contact 196', '1975654425', 'POL13866', '649 Elm St', 'assets/patient196.jpg', 'No known allergies', '2024-10-03 21:31:23'),
('Robert Jackson', 'patient197@care.com', '1863168099', 'Group 3', 'Pediatrics', 'Online', '2003-07-17 00:00:00', 'patientpass197', 'Emergency Contact 197', '1608594163', 'POL88085', '704 Elm St', 'assets/patient197.jpg', 'No known allergies', '2024-09-27 21:31:23'),
('David Wilson', 'patient198@care.com', '1722688962', 'Group 3', 'Oncology', 'Online', '1997-03-23 00:00:00', 'patientpass198', 'Emergency Contact 198', '1534907588', 'POL93482', '784 Elm St', 'assets/patient198.jpg', 'Diabetic', '2024-09-30 21:31:23'),
('Sarah Johnson', 'patient199@care.com', '1114092021', 'Group 1', 'Orthopedics', 'Rest', '2006-09-16 00:00:00', 'patientpass199', 'Emergency Contact 199', '1905198274', 'POL56148', '416 Elm St', 'assets/patient199.jpg', 'Diabetic', '2024-09-22 21:31:23'),
('John White', 'patient200@care.com', '1394829463', 'Group 3', 'Pediatrics', 'Online', '1982-05-15 00:00:00', 'patientpass200', 'Emergency Contact 200', '1469416968', 'POL22391', '502 Elm St', 'assets/patient200.jpg', 'No known allergies', '2024-09-16 21:31:23'),
('Lucas Taylor', 'patient201@care.com', '1230092141', 'Group 4', 'Orthopedics', 'Rest', '1996-05-04 00:00:00', 'patientpass201', 'Emergency Contact 201', '1900916901', 'POL39450', '455 Elm St', 'assets/patient201.jpg', 'Diabetic', '2024-10-04 21:31:23'),
('Robert Lee', 'patient202@care.com', '1745834092', 'Group 5', 'Pediatrics', 'Rest', '2017-09-18 00:00:00', 'patientpass202', 'Emergency Contact 202', '1168858528', 'POL97115', '675 Elm St', 'assets/patient202.jpg', 'No notes', '2024-10-05 21:31:23'),
('Mia Davis', 'patient203@care.com', '1615781938', 'Group 2', 'Orthopedics', 'Quit', '2015-06-03 00:00:00', 'patientpass203', 'Emergency Contact 203', '1767146907', 'POL31931', '298 Elm St', 'assets/patient203.jpg', 'High blood pressure', '2024-10-02 21:31:23'),
('Emma White', 'patient204@care.com', '1204066966', 'Group 4', 'Pediatrics', 'Online', '2007-06-22 00:00:00', 'patientpass204', 'Emergency Contact 204', '1833135527', 'POL91130', '335 Elm St', 'assets/patient204.jpg', 'Asthma patient', '2024-10-05 21:31:23'),
('Emma Taylor', 'patient205@care.com', '1709574823', 'Group 4', 'Neurology', 'Online', '2009-09-22 00:00:00', 'patientpass205', 'Emergency Contact 205', '1996768968', 'POL96045', '256 Elm St', 'assets/patient205.jpg', 'High blood pressure', '2024-10-01 21:31:23'),
('Anna White', 'patient206@care.com', '1757260348', 'Group 2', 'Oncology', 'Rest', '2019-02-26 00:00:00', 'patientpass206', 'Emergency Contact 206', '1650588462', 'POL31120', '294 Elm St', 'assets/patient206.jpg', 'No notes', '2024-10-04 21:31:23'),
('Benjamin Thompson', 'patient207@care.com', '1606370588', 'Group 5', 'Pediatrics', 'Quit', '1991-02-21 00:00:00', 'patientpass207', 'Emergency Contact 207', '1156658828', 'POL28441', '216 Elm St', 'assets/patient207.jpg', 'Asthma patient', '2024-10-04 21:31:23'),
('Emily Harris', 'patient208@care.com', '1389736564', 'Group 5', 'Oncology', 'Quit', '2003-06-26 00:00:00', 'patientpass208', 'Emergency Contact 208', '1131969958', 'POL13041', '459 Elm St', 'assets/patient208.jpg', 'High blood pressure', '2024-10-05 21:31:23'),
('Sophia Miller', 'patient209@care.com', '1259732079', 'Group 5', 'Neurology', 'Rest', '2003-07-10 00:00:00', 'patientpass209', 'Emergency Contact 209', '1889334654', 'POL10367', '961 Elm St', 'assets/patient209.jpg', 'No notes', '2024-10-02 21:31:23'),
('Lucas Harris', 'patient210@care.com', '1708236545', 'Group 5', 'Dermatology', 'Quit', '1998-12-14 00:00:00', 'patientpass210', 'Emergency Contact 210', '1522185382', 'POL49849', '225 Elm St', 'assets/patient210.jpg', 'Asthma patient', '2024-10-01 21:31:23'),
('Jane Johnson', 'patient211@care.com', '1513332748', 'Group 3', 'Dermatology', 'Rest', '1980-12-19 00:00:00', 'patientpass211', 'Emergency Contact 211', '1672455817', 'POL69409', '509 Elm St', 'assets/patient211.jpg', 'No known allergies', '2024-10-04 21:31:23'),
('Jane Lee', 'patient212@care.com', '1911768631', 'Group 2', 'Orthopedics', 'Rest', '2004-09-06 00:00:00', 'patientpass212', 'Emergency Contact 212', '1242040850', 'POL92125', '344 Elm St', 'assets/patient212.jpg', 'Asthma patient', '2024-10-05 21:31:23'),
('Anna White', 'patient213@care.com', '1338455632', 'Group 3', 'Neurology', 'Rest', '1985-12-14 00:00:00', 'patientpass213', 'Emergency Contact 213', '1804238467', 'POL66796', '852 Elm St', 'assets/patient213.jpg', 'Asthma patient', '2024-10-04 21:31:23'),
('Benjamin Lewis', 'patient214@care.com', '1707303900', 'Group 4', 'Neurology', 'Online', '1998-03-07 00:00:00', 'patientpass214', 'Emergency Contact 214', '1550290274', 'POL36734', '652 Elm St', 'assets/patient214.jpg', 'No known allergies', '2024-10-04 21:31:23'),
('Ethan Davis', 'patient215@care.com', '1898366279', 'Group 1', 'Oncology', 'Quit', '2007-03-20 00:00:00', 'patientpass215', 'Emergency Contact 215', '1582054546', 'POL31815', '382 Elm St', 'assets/patient215.jpg', 'Diabetic', '2024-09-30 21:31:23'),
('James Harris', 'patient216@care.com', '1805227279', 'Group 2', 'Neurology', 'Quit', '1982-06-03 00:00:00', 'patientpass216', 'Emergency Contact 216', '1679621698', 'POL66493', '400 Elm St', 'assets/patient216.jpg', 'High blood pressure', '2024-09-30 21:31:23'),
('Mia White', 'patient217@care.com', '1616766891', 'Group 1', 'Oncology', 'Online', '1993-01-04 00:00:00', 'patientpass217', 'Emergency Contact 217', '1315424308', 'POL27068', '344 Elm St', 'assets/patient217.jpg', 'No notes', '2024-10-04 21:31:23'),
('Olivia Miller', 'patient218@care.com', '1836678604', 'Group 3', 'Dermatology', 'Quit', '2011-05-14 00:00:00', 'patientpass218', 'Emergency Contact 218', '1903951570', 'POL23665', '388 Elm St', 'assets/patient218.jpg', 'Diabetic', '2024-09-30 21:31:23'),
('Liam Harris', 'patient219@care.com', '1547562855', 'Group 5', 'Dermatology', 'Online', '1983-08-14 00:00:00', 'patientpass219', 'Emergency Contact 219', '1447010957', 'POL88462', '614 Elm St', 'assets/patient219.jpg', 'Diabetic', '2024-10-04 21:31:23'),
('Emily Jackson', 'patient220@care.com', '1475525656', 'Group 2', 'Oncology', 'Online', '1984-07-14 00:00:00', 'patientpass220', 'Emergency Contact 220', '1793101396', 'POL53978', '451 Elm St', 'assets/patient220.jpg', 'No known allergies', '2024-10-05 21:31:23'),
('Mia Martinez', 'patient221@care.com', '1656036229', 'Group 3', 'Orthopedics', 'Quit', '2011-10-22 00:00:00', 'patientpass221', 'Emergency Contact 221', '1540064819', 'POL53150', '802 Elm St', 'assets/patient221.jpg', 'Diabetic', '2024-09-30 21:31:23'),
('Robert Harris', 'patient222@care.com', '1937862493', 'Group 1', 'Pediatrics', 'Online', '1984-06-28 00:00:00', 'patientpass222', 'Emergency Contact 222', '1175528164', 'POL70866', '676 Elm St', 'assets/patient222.jpg', 'No known allergies', '2024-10-05 21:31:23'),
('John Moore', 'patient223@care.com', '1258946452', 'Group 1', 'Neurology', 'Quit', '2010-02-26 00:00:00', 'patientpass223', 'Emergency Contact 223', '1795571814', 'POL82051', '432 Elm St', 'assets/patient223.jpg', 'High blood pressure', '2024-10-05 21:31:23'),
('Liam Taylor', 'patient224@care.com', '1669337202', 'Group 3', 'Orthopedics', 'Rest', '1982-08-10 00:00:00', 'patientpass224', 'Emergency Contact 224', '1756347327', 'POL60141', '353 Elm St', 'assets/patient224.jpg', 'High blood pressure', '2024-09-30 21:31:23'),
('John Brown', 'patient225@care.com', '1996119246', 'Group 1', 'Pediatrics', 'Online', '2012-07-18 00:00:00', 'patientpass225', 'Emergency Contact 225', '1394369892', 'POL38735', '442 Elm St', 'assets/patient225.jpg', 'High blood pressure', '2024-10-03 21:31:23'),
('Emily Smith', 'patient226@care.com', '1185058540', 'Group 2', 'Oncology', 'Rest', '2005-06-20 00:00:00', 'patientpass226', 'Emergency Contact 226', '1528952025', 'POL45278', '465 Elm St', 'assets/patient226.jpg', 'No known allergies', '2024-09-29 21:31:23'),
('Robert Davis', 'patient227@care.com', '1958461979', 'Group 5', 'Pediatrics', 'Online', '1998-08-02 00:00:00', 'patientpass227', 'Emergency Contact 227', '1200573025', 'POL36043', '331 Elm St', 'assets/patient227.jpg', 'Diabetic', '2024-09-30 21:31:23'),
('Emily Martinez', 'patient228@care.com', '1532048517', 'Group 4', 'Oncology', 'Online', '1996-08-12 00:00:00', 'patientpass228', 'Emergency Contact 228', '1791766508', 'POL55267', '955 Elm St', 'assets/patient228.jpg', 'High blood pressure', '2024-10-05 21:31:23'),
('Grace Taylor', 'patient229@care.com', '1347238356', 'Group 3', 'Neurology', 'Online', '2001-03-10 00:00:00', 'patientpass229', 'Emergency Contact 229', '1816021042', 'POL56695', '446 Elm St', 'assets/patient229.jpg', 'No known allergies', '2024-10-02 21:31:23'),
('Grace Smith', 'patient230@care.com', '1757557714', 'Group 3', 'Orthopedics', 'Rest', '2013-07-11 00:00:00', 'patientpass230', 'Emergency Contact 230', '1708504968', 'POL29359', '544 Elm St', 'assets/patient230.jpg', 'No notes', '2024-10-04 21:31:23'),
('Liam Smith', 'patient231@care.com', '1477809827', 'Group 4', 'Neurology', 'Online', '2008-03-08 00:00:00', 'patientpass231', 'Emergency Contact 231', '1110887244', 'POL32624', '392 Elm St', 'assets/patient231.jpg', 'No notes', '2024-10-05 21:31:23'),
('Anna Walker', 'patient232@care.com', '1268420152', 'Group 5', 'Dermatology', 'Rest', '2009-03-21 00:00:00', 'patientpass232', 'Emergency Contact 232', '1898878939', 'POL43976', '735 Elm St', 'assets/patient232.jpg', 'No notes', '2024-09-29 21:31:23'),
('Michael Clark', 'patient233@care.com', '1120018996', 'Group 4', 'Orthopedics', 'Quit', '1980-01-20 00:00:00', 'patientpass233', 'Emergency Contact 233', '1163356853', 'POL81824', '148 Elm St', 'assets/patient233.jpg', 'Asthma patient', '2024-10-05 21:31:23'),
('Robert Davis', 'patient234@care.com', '1220149175', 'Group 3', 'Pediatrics', 'Quit', '2017-11-27 00:00:00', 'patientpass234', 'Emergency Contact 234', '1382054283', 'POL54545', '162 Elm St', 'assets/patient234.jpg', 'High blood pressure', '2024-10-03 21:31:23'),
('Grace Harris', 'patient235@care.com', '1587403287', 'Group 1', 'Neurology', 'Rest', '2010-01-27 00:00:00', 'patientpass235', 'Emergency Contact 235', '1581749897', 'POL52590', '397 Elm St', 'assets/patient235.jpg', 'High blood pressure', '2024-10-03 21:31:23'),
('David Wilson', 'patient236@care.com', '1852664828', 'Group 1', 'Oncology', 'Online', '1982-02-28 00:00:00', 'patientpass236', 'Emergency Contact 236', '1708544030', 'POL54625', '323 Elm St', 'assets/patient236.jpg', 'Diabetic', '2024-09-30 21:31:23'),
('James Davis', 'patient237@care.com', '1218129049', 'Group 2', 'Dermatology', 'Rest', '2009-05-22 00:00:00', 'patientpass237', 'Emergency Contact 237', '1280277884', 'POL70303', '970 Elm St', 'assets/patient237.jpg', 'Asthma patient', '2024-09-29 21:31:23'),
('Mia Lee', 'patient238@care.com', '1803687368', 'Group 1', 'Orthopedics', 'Rest', '1985-08-15 00:00:00', 'patientpass238', 'Emergency Contact 238', '1248941570', 'POL27796', '417 Elm St', 'assets/patient238.jpg', 'No known allergies', '2024-10-05 21:31:23'),
('Lucas Clark', 'patient239@care.com', '1566263077', 'Group 4', 'Neurology', 'Online', '1985-08-22 00:00:00', 'patientpass239', 'Emergency Contact 239', '1732488686', 'POL24266', '407 Elm St', 'assets/patient239.jpg', 'Asthma patient', '2024-10-04 21:31:23'),
('David Lee', 'patient240@care.com', '1324821967', 'Group 5', 'Dermatology', 'Quit', '2012-09-22 00:00:00', 'patientpass240', 'Emergency Contact 240', '1548908670', 'POL91509', '254 Elm St', 'assets/patient240.jpg', 'Asthma patient', '2024-10-05 21:31:23'),
('Emma Rodriguez', 'patient241@care.com', '1533344592', 'Group 5', 'Dermatology', 'Rest', '1996-06-12 00:00:00', 'patientpass241', 'Emergency Contact 241', '1963892413', 'POL34318', '627 Elm St', 'assets/patient241.jpg', 'High blood pressure', '2024-09-29 21:31:23'),
('David Walker', 'patient242@care.com', '1127922404', 'Group 2', 'Oncology', 'Online', '1991-06-24 00:00:00', 'patientpass242', 'Emergency Contact 242', '1662568991', 'POL64058', '786 Elm St', 'assets/patient242.jpg', 'No known allergies', '2024-09-29 21:31:23'),
('Benjamin Harris', 'patient243@care.com', '1120864266', 'Group 3', 'Neurology', 'Rest', '1997-12-11 00:00:00', 'patientpass243', 'Emergency Contact 243', '1627766804', 'POL32008', '696 Elm St', 'assets/patient243.jpg', 'High blood pressure', '2024-10-04 21:31:23'),
('Grace Rodriguez', 'patient244@care.com', '1189432301', 'Group 3', 'Neurology', 'Quit', '2002-05-14 00:00:00', 'patientpass244', 'Emergency Contact 244', '1827897006', 'POL81337', '311 Elm St', 'assets/patient244.jpg', 'No known allergies', '2024-10-01 21:31:23'),
('Emily Brown', 'patient245@care.com', '1205469946', 'Group 5', 'Dermatology', 'Quit', '2016-07-21 00:00:00', 'patientpass245', 'Emergency Contact 245', '1881570160', 'POL21741', '708 Elm St', 'assets/patient245.jpg', 'No known allergies', '2024-10-04 21:31:23'),
('Sophia Smith', 'patient246@care.com', '1511964666', 'Group 1', 'Orthopedics', 'Online', '1993-11-04 00:00:00', 'patientpass246', 'Emergency Contact 246', '1857835957', 'POL19486', '730 Elm St', 'assets/patient246.jpg', 'No known allergies', '2024-10-05 21:31:23'),
('Jane Rodriguez', 'patient247@care.com', '1767817517', 'Group 2', 'Dermatology', 'Online', '2002-12-24 00:00:00', 'patientpass247', 'Emergency Contact 247', '1908559069', 'POL81671', '967 Elm St', 'assets/patient247.jpg', 'Diabetic', '2024-09-29 21:31:23'),
('Lucas Thompson', 'patient248@care.com', '1139999703', 'Group 1', 'Oncology', 'Rest', '2008-08-05 00:00:00', 'patientpass248', 'Emergency Contact 248', '1735882989', 'POL19607', '116 Elm St', 'assets/patient248.jpg', 'Asthma patient', '2024-10-03 21:31:23'),
('Ethan Smith', 'patient249@care.com', '1176951164', 'Group 2', 'Neurology', 'Quit', '1988-01-13 00:00:00', 'patientpass249', 'Emergency Contact 249', '1612002148', 'POL62248', '814 Elm St', 'assets/patient249.jpg', 'Diabetic', '2024-10-01 21:31:23'),
('Michael Johnson', 'patient250@care.com', '1923337081', 'Group 1', 'Dermatology', 'Quit', '1998-06-11 00:00:00', 'patientpass250', 'Emergency Contact 250', '1400525372', 'POL60793', '918 Elm St', 'assets/patient250.jpg', 'High blood pressure', '2024-10-04 21:31:23'),
('Mia Smith', 'patient251@care.com', '1321224577', 'Group 4', 'Dermatology', 'Online', '1996-09-25 00:00:00', 'patientpass251', 'Emergency Contact 251', '1515648538', 'POL32577', '956 Elm St', 'assets/patient251.jpg', 'High blood pressure', '2024-09-06 21:31:23'),
('Anna Walker', 'patient252@care.com', '1974521199', 'Group 5', 'Dermatology', 'Online', '1988-03-10 00:00:00', 'patientpass252', 'Emergency Contact 252', '1506376239', 'POL27176', '340 Elm St', 'assets/patient252.jpg', 'Asthma patient', '2024-02-09 21:31:23'),
('Sophia Harris', 'patient253@care.com', '1986444174', 'Group 3', 'Pediatrics', 'Rest', '1999-12-13 00:00:00', 'patientpass253', 'Emergency Contact 253', '1878039772', 'POL19128', '688 Elm St', 'assets/patient253.jpg', 'No notes', '2024-04-04 21:31:23'),
('James Brown', 'patient254@care.com', '1245830912', 'Group 3', 'Oncology', 'Online', '2018-05-27 00:00:00', 'patientpass254', 'Emergency Contact 254', '1937641463', 'POL36325', '100 Elm St', 'assets/patient254.jpg', 'Asthma patient', '2023-12-07 21:31:23'),
('Michael Jackson', 'patient255@care.com', '1509592292', 'Group 5', 'Oncology', 'Quit', '1986-02-10 00:00:00', 'patientpass255', 'Emergency Contact 255', '1867108728', 'POL47415', '781 Elm St', 'assets/patient255.jpg', 'No known allergies', '2024-02-04 21:31:23'),
('Benjamin Wilson', 'patient256@care.com', '1632944020', 'Group 5', 'Oncology', 'Quit', '1981-10-20 00:00:00', 'patientpass256', 'Emergency Contact 256', '1704237295', 'POL92986', '562 Elm St', 'assets/patient256.jpg', 'Asthma patient', '2024-03-31 21:31:23'),
('Anna White', 'patient257@care.com', '1153892740', 'Group 3', 'Dermatology', 'Quit', '1999-05-17 00:00:00', 'patientpass257', 'Emergency Contact 257', '1930191876', 'POL20461', '219 Elm St', 'assets/patient257.jpg', 'No known allergies', '2024-02-08 21:31:23'),
('Anna Taylor', 'patient258@care.com', '1233540337', 'Group 5', 'Pediatrics', 'Online', '2017-01-15 00:00:00', 'patientpass258', 'Emergency Contact 258', '1550727630', 'POL74980', '287 Elm St', 'assets/patient258.jpg', 'No notes', '2023-11-24 21:31:23'),
('Liam White', 'patient259@care.com', '1640180977', 'Group 3', 'Neurology', 'Rest', '1985-11-12 00:00:00', 'patientpass259', 'Emergency Contact 259', '1411614205', 'POL14990', '519 Elm St', 'assets/patient259.jpg', 'Asthma patient', '2024-09-13 21:31:23'),
('David Jackson', 'patient260@care.com', '1383173205', 'Group 3', 'Dermatology', 'Quit', '2009-08-02 00:00:00', 'patientpass260', 'Emergency Contact 260', '1700676851', 'POL49682', '322 Elm St', 'assets/patient260.jpg', 'Diabetic', '2024-01-25 21:31:23'),
('Michael Wilson', 'patient261@care.com', '1798693966', 'Group 5', 'Oncology', 'Quit', '2017-07-15 00:00:00', 'patientpass261', 'Emergency Contact 261', '1741127620', 'POL99720', '148 Elm St', 'assets/patient261.jpg', 'High blood pressure', '2024-07-28 21:31:23'),
('David Moore', 'patient262@care.com', '1655694659', 'Group 1', 'Neurology', 'Quit', '1981-11-10 00:00:00', 'patientpass262', 'Emergency Contact 262', '1397426609', 'POL58302', '923 Elm St', 'assets/patient262.jpg', 'No notes', '2024-01-15 21:31:23'),
('Laura Johnson', 'patient263@care.com', '1265039139', 'Group 4', 'Pediatrics', 'Online', '2003-08-19 00:00:00', 'patientpass263', 'Emergency Contact 263', '1349416932', 'POL47193', '296 Elm St', 'assets/patient263.jpg', 'Asthma patient', '2023-12-03 21:31:23'),
('Emily Garcia', 'patient264@care.com', '1857075961', 'Group 2', 'Dermatology', 'Rest', '2012-12-16 00:00:00', 'patientpass264', 'Emergency Contact 264', '1789562329', 'POL43225', '858 Elm St', 'assets/patient264.jpg', 'Diabetic', '2024-04-08 21:31:23'),
('Olivia White', 'patient265@care.com', '1963023788', 'Group 5', 'Orthopedics', 'Quit', '1990-03-09 00:00:00', 'patientpass265', 'Emergency Contact 265', '1158197223', 'POL39997', '152 Elm St', 'assets/patient265.jpg', 'Asthma patient', '2024-01-07 21:31:23'),
('Sophia Walker', 'patient266@care.com', '1262004709', 'Group 1', 'Orthopedics', 'Online', '2001-12-02 00:00:00', 'patientpass266', 'Emergency Contact 266', '1557420110', 'POL13554', '161 Elm St', 'assets/patient266.jpg', 'High blood pressure', '2024-02-11 21:31:23'),
('Emily Harris', 'patient267@care.com', '1140136341', 'Group 3', 'Oncology', 'Rest', '1999-02-24 00:00:00', 'patientpass267', 'Emergency Contact 267', '1441889120', 'POL53580', '652 Elm St', 'assets/patient267.jpg', 'No notes', '2024-06-26 21:31:23'),
('Jane Wilson', 'patient268@care.com', '1458814046', 'Group 3', 'Pediatrics', 'Rest', '2012-10-09 00:00:00', 'patientpass268', 'Emergency Contact 268', '1836812722', 'POL15493', '490 Elm St', 'assets/patient268.jpg', 'No known allergies', '2024-06-20 21:31:23'),
('Grace Harris', 'patient269@care.com', '1739966158', 'Group 5', 'Orthopedics', 'Online', '1986-06-11 00:00:00', 'patientpass269', 'Emergency Contact 269', '1464096064', 'POL19109', '550 Elm St', 'assets/patient269.jpg', 'Asthma patient', '2023-10-21 21:31:23'),
('David Johnson', 'patient270@care.com', '1494389994', 'Group 2', 'Oncology', 'Online', '1996-03-27 00:00:00', 'patientpass270', 'Emergency Contact 270', '1960147434', 'POL81637', '503 Elm St', 'assets/patient270.jpg', 'No notes', '2023-11-27 21:31:23'),
('Michael Clark', 'patient271@care.com', '1660424186', 'Group 1', 'Dermatology', 'Online', '1981-03-10 00:00:00', 'patientpass271', 'Emergency Contact 271', '1191050099', 'POL53732', '551 Elm St', 'assets/patient271.jpg', 'No known allergies', '2024-01-13 21:31:23'),
('Jane Clark', 'patient272@care.com', '1715639499', 'Group 2', 'Orthopedics', 'Online', '2006-12-23 00:00:00', 'patientpass272', 'Emergency Contact 272', '1365434563', 'POL80206', '386 Elm St', 'assets/patient272.jpg', 'Asthma patient', '2023-12-26 21:31:23'),
('Sophia Lee', 'patient273@care.com', '1269269741', 'Group 4', 'Dermatology', 'Online', '1989-09-09 00:00:00', 'patientpass273', 'Emergency Contact 273', '1297657856', 'POL58166', '488 Elm St', 'assets/patient273.jpg', 'No known allergies', '2024-03-13 21:31:23'),
('John Garcia', 'patient274@care.com', '1287353005', 'Group 3', 'Neurology', 'Rest', '1985-11-08 00:00:00', 'patientpass274', 'Emergency Contact 274', '1345368250', 'POL35901', '967 Elm St', 'assets/patient274.jpg', 'Asthma patient', '2023-12-20 21:31:23'),
('Benjamin Wilson', 'patient275@care.com', '1512234998', 'Group 5', 'Neurology', 'Rest', '2019-05-19 00:00:00', 'patientpass275', 'Emergency Contact 275', '1852409853', 'POL20438', '239 Elm St', 'assets/patient275.jpg', 'Diabetic', '2023-11-24 21:31:23'),
('Sarah Walker', 'patient276@care.com', '1659992165', 'Group 3', 'Dermatology', 'Quit', '1982-02-11 00:00:00', 'patientpass276', 'Emergency Contact 276', '1765577611', 'POL11212', '705 Elm St', 'assets/patient276.jpg', 'Diabetic', '2023-12-26 21:31:23'),
('Ethan Garcia', 'patient277@care.com', '1687107849', 'Group 1', 'Pediatrics', 'Online', '1982-03-11 00:00:00', 'patientpass277', 'Emergency Contact 277', '1360463311', 'POL10876', '557 Elm St', 'assets/patient277.jpg', 'Diabetic', '2024-09-19 21:31:23'),
('Daniel Lewis', 'patient278@care.com', '1318686679', 'Group 2', 'Dermatology', 'Quit', '2017-06-17 00:00:00', 'patientpass278', 'Emergency Contact 278', '1605801367', 'POL48706', '823 Elm St', 'assets/patient278.jpg', 'Diabetic', '2024-09-25 21:31:23'),
('Olivia Anderson', 'patient279@care.com', '1983972564', 'Group 4', 'Pediatrics', 'Quit', '2009-01-24 00:00:00', 'patientpass279', 'Emergency Contact 279', '1899912964', 'POL84931', '911 Elm St', 'assets/patient279.jpg', 'No known allergies', '2024-08-23 21:31:23'),
('Emily Taylor', 'patient280@care.com', '1973987156', 'Group 1', 'Pediatrics', 'Quit', '2018-12-05 00:00:00', 'patientpass280', 'Emergency Contact 280', '1143878347', 'POL66525', '872 Elm St', 'assets/patient280.jpg', 'Diabetic', '2024-06-13 21:31:23'),
('Laura Lee', 'patient281@care.com', '1147184104', 'Group 3', 'Oncology', 'Quit', '2010-01-07 00:00:00', 'patientpass281', 'Emergency Contact 281', '1872362245', 'POL48121', '769 Elm St', 'assets/patient281.jpg', 'Asthma patient', '2024-06-14 21:31:23'),
('Jane Walker', 'patient282@care.com', '1465319073', 'Group 4', 'Dermatology', 'Online', '1995-05-06 00:00:00', 'patientpass282', 'Emergency Contact 282', '1803530507', 'POL52369', '862 Elm St', 'assets/patient282.jpg', 'Diabetic', '2024-03-16 21:31:23'),
('Ethan Smith', 'patient283@care.com', '1411805680', 'Group 4', 'Pediatrics', 'Online', '2000-03-11 00:00:00', 'patientpass283', 'Emergency Contact 283', '1480350995', 'POL50419', '501 Elm St', 'assets/patient283.jpg', 'Diabetic', '2023-11-19 21:31:23'),
('Grace Taylor', 'patient284@care.com', '1527679892', 'Group 2', 'Dermatology', 'Online', '1993-07-08 00:00:00', 'patientpass284', 'Emergency Contact 284', '1883510386', 'POL43274', '452 Elm St', 'assets/patient284.jpg', 'No known allergies', '2024-06-03 21:31:23'),
('James Rodriguez', 'patient285@care.com', '1665690856', 'Group 5', 'Dermatology', 'Rest', '2005-05-28 00:00:00', 'patientpass285', 'Emergency Contact 285', '1402308772', 'POL60664', '203 Elm St', 'assets/patient285.jpg', 'No known allergies', '2023-11-20 21:31:23'),
('Sarah Walker', 'patient286@care.com', '1709525181', 'Group 4', 'Orthopedics', 'Rest', '2001-07-25 00:00:00', 'patientpass286', 'Emergency Contact 286', '1450569355', 'POL28385', '114 Elm St', 'assets/patient286.jpg', 'Asthma patient', '2024-02-01 21:31:23'),
('Sarah Brown', 'patient287@care.com', '1419020684', 'Group 2', 'Pediatrics', 'Rest', '1983-08-23 00:00:00', 'patientpass287', 'Emergency Contact 287', '1416816541', 'POL73737', '760 Elm St', 'assets/patient287.jpg', 'High blood pressure', '2023-10-20 21:31:23'),
('David Martinez', 'patient288@care.com', '1776513508', 'Group 5', 'Dermatology', 'Quit', '1982-02-04 00:00:00', 'patientpass288', 'Emergency Contact 288', '1802587674', 'POL61573', '914 Elm St', 'assets/patient288.jpg', 'No known allergies', '2024-08-12 21:31:23'),
('Emily White', 'patient289@care.com', '1126255913', 'Group 4', 'Orthopedics', 'Rest', '1993-07-26 00:00:00', 'patientpass289', 'Emergency Contact 289', '1963403036', 'POL10473', '358 Elm St', 'assets/patient289.jpg', 'No known allergies', '2024-07-12 21:31:23'),
('Liam Wilson', 'patient290@care.com', '1693915235', 'Group 5', 'Dermatology', 'Online', '2017-05-11 00:00:00', 'patientpass290', 'Emergency Contact 290', '1404750908', 'POL24070', '890 Elm St', 'assets/patient290.jpg', 'Asthma patient', '2023-12-07 21:31:23'),
('Michael Johnson', 'patient291@care.com', '1832076968', 'Group 3', 'Orthopedics', 'Quit', '2018-06-03 00:00:00', 'patientpass291', 'Emergency Contact 291', '1846673745', 'POL76003', '280 Elm St', 'assets/patient291.jpg', 'No notes', '2024-02-22 21:31:23'),
('Michael Brown', 'patient292@care.com', '1426313413', 'Group 2', 'Neurology', 'Online', '1984-04-07 00:00:00', 'patientpass292', 'Emergency Contact 292', '1552413445', 'POL97501', '482 Elm St', 'assets/patient292.jpg', 'Asthma patient', '2024-08-08 21:31:23'),
('David Harris', 'patient293@care.com', '1420407129', 'Group 1', 'Oncology', 'Quit', '2011-12-13 00:00:00', 'patientpass293', 'Emergency Contact 293', '1871810582', 'POL11571', '881 Elm St', 'assets/patient293.jpg', 'Asthma patient', '2023-12-14 21:31:23'),
('David Johnson', 'patient294@care.com', '1442703820', 'Group 3', 'Orthopedics', 'Rest', '1986-10-22 00:00:00', 'patientpass294', 'Emergency Contact 294', '1313649663', 'POL83596', '736 Elm St', 'assets/patient294.jpg', 'Asthma patient', '2024-01-08 21:31:23'),
('Olivia Harris', 'patient295@care.com', '1743413719', 'Group 3', 'Dermatology', 'Rest', '1988-09-03 00:00:00', 'patientpass295', 'Emergency Contact 295', '1679680622', 'POL38456', '173 Elm St', 'assets/patient295.jpg', 'Asthma patient', '2024-09-06 21:31:23'),
('Anna Wilson', 'patient296@care.com', '1629936899', 'Group 5', 'Orthopedics', 'Quit', '1999-07-28 00:00:00', 'patientpass296', 'Emergency Contact 296', '1199458720', 'POL85925', '259 Elm St', 'assets/patient296.jpg', 'Diabetic', '2024-08-05 21:31:23'),
('Robert Wilson', 'patient297@care.com', '1151348465', 'Group 3', 'Pediatrics', 'Online', '1994-07-28 00:00:00', 'patientpass297', 'Emergency Contact 297', '1116961911', 'POL43597', '458 Elm St', 'assets/patient297.jpg', 'No notes', '2024-01-10 21:31:23'),
('Olivia White', 'patient298@care.com', '1343752402', 'Group 1', 'Dermatology', 'Rest', '2009-05-14 00:00:00', 'patientpass298', 'Emergency Contact 298', '1590667930', 'POL87419', '143 Elm St', 'assets/patient298.jpg', 'Diabetic', '2024-06-17 21:31:23'),
('Sarah Brown', 'patient299@care.com', '1596899240', 'Group 2', 'Dermatology', 'Online', '1983-09-25 00:00:00', 'patientpass299', 'Emergency Contact 299', '1973636311', 'POL70943', '403 Elm St', 'assets/patient299.jpg', 'High blood pressure', '2024-08-16 21:31:23'),
('Emma Walker', 'patient300@care.com', '1674151798', 'Group 5', 'Oncology', 'Online', '1991-06-04 00:00:00', 'patientpass300', 'Emergency Contact 300', '1926442203', 'POL32293', '708 Elm St', 'assets/patient300.jpg', 'No known allergies', '2024-04-12 21:31:23');

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
