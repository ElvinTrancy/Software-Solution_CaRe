<?php
require_once '../inc/dbconn.inc.php';

// Get the raw POST data
$data = json_decode(file_get_contents('php://input'), true);

$groupId = $data['group_id'];
$assignedPatients = $data['assigned_patients'];

// First, delete existing assignments for this group
$deleteSql = "DELETE FROM GroupPatient WHERE group_id = ?";
$stmt = $conn->prepare($deleteSql);
$stmt->bind_param("i", $groupId);
$stmt->execute();
$stmt->close();

// Then, insert the new assigned patients
$insertSql = "INSERT INTO GroupPatient (group_id, patient_id) VALUES (?, ?)";
$stmt = $conn->prepare($insertSql);

foreach ($assignedPatients as $patientId) {
    $stmt->bind_param("ii", $groupId, $patientId);
    $stmt->execute();
}

$stmt->close();

// Return success response
echo json_encode(['success' => true]);
