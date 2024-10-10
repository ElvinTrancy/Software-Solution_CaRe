<?php
// Start session
session_start();

// Include the database connection file
require_once '../inc/dbconn.inc.php';

// Read the input data
$data = json_decode(file_get_contents('php://input'), true);

$mood = $data['mood'];
$selectedDate = $data['selectedDate'];
$fitness = $data['fitness'];
$sleep = $data['sleep'];
$notes = $data['notes'];
$location = $data['location'];
$voice = $data['voice'] ?? null; // Optional field
$picture = $data['picture'] ?? null; // Optional field
$patientId = $_SESSION['patient_id']; 
$diet = $data["dietLevel"];

// Prepare the SQL insert query
$sql = "INSERT INTO patientdailyrecords (patient_id, record_date, mood, fitness_level, sleep_hours, notes, location, voice, picture, diet) 
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

$stmt = $conn->prepare($sql);
$stmt->bind_param('isssssssss', $patientId, $selectedDate, $mood, $fitness, $sleep, $notes, $location, $voice, $picture, $diet);

if ($stmt->execute()) {
    // Successfully inserted
    echo json_encode(['success' => true]);
} else {
    // Error inserting
    echo json_encode(['success' => false, 'error' => $stmt->error]);
}

$stmt->close();
$conn->close();
?>
