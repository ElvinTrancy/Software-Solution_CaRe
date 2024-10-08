<?php
session_start();
require_once '../inc/dbconn.inc.php';

// Check if the therapist is logged in
if (!isset($_SESSION['therapist_id'])) {
    echo json_encode(['error' => 'Therapist not logged in']);
    exit;
}

// Get the raw POST data
$input = file_get_contents('php://input');
$data = json_decode($input, true);

if (isset($data['patient_id']) && isset($data['note_text'])) {
    $patientId = intval($data['patient_id']);
    $noteText = trim($data['note_text']);
    $therapistId = intval($_SESSION['therapist_id']); // Get therapist ID from session

    if ($noteText === '' || strlen($noteText) > 250) {
        echo json_encode(['error' => 'Invalid note text.']);
        exit;
    }

    // Insert the note into the database
    $sql = "INSERT INTO PatientNotes (patient_id, note_text, therapist_id, note_date) VALUES (?, ?, ?, NOW())";
    $stmt = $conn->prepare($sql);

    if ($stmt === false) {
        echo json_encode(['error' => 'Database error']);
        exit;
    }

    $stmt->bind_param('isi', $patientId, $noteText, $therapistId);

    if ($stmt->execute()) {
        echo json_encode(['success' => true]);
    } else {
        echo json_encode(['error' => 'Failed to insert note']);
    }

    $stmt->close();
} else {
    echo json_encode(['error' => 'Missing patient ID or note text']);
}
?>
