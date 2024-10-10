<?php
// Connect to the database
require_once '../inc/dbconn.inc.php';

// Get the raw POST data
$data = json_decode(file_get_contents('php://input'), true);

// Extract the patient ID and the new photo path
$patientId = $data['patient_id'];
$photoPath = $data['photo'];

if ($patientId && $photoPath) {
    // Update the patient's photo in the database
    $updateSql = "UPDATE patients SET photo = ? WHERE id = ?";
    $stmt = $conn->prepare($updateSql);
    $stmt->bind_param('si', $photoPath, $patientId);

    if ($stmt->execute()) {
        echo json_encode(['success' => true]);
    } else {
        echo json_encode(['success' => false, 'error' => 'Failed to update patient photo.']);
    }

    $stmt->close();
} else {
    echo json_encode(['success' => false, 'error' => 'Invalid data provided.']);
}

$conn->close();
?>
