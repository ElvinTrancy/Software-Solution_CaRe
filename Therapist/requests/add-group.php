<?php
include '../inc/dbconn.inc.php';

header('Content-Type: application/json');

// Read the JSON input
$data = json_decode(file_get_contents('php://input'), true);

$groupName = $data['groupName'];
$groupLeader = $data['groupLeader'];
$assignedPatients = $data['assignedPatients'];

// Initialize response
$response = ['success' => false];

// Insert group into the Groups table
$insertGroupSql = "INSERT INTO Groups (name, therapist_id, creation_date, status) VALUES (?, ?, NOW(), 'Active')";
$stmt = $conn->prepare($insertGroupSql);
$stmt->bind_param("si", $groupName, $groupLeader);

if ($stmt->execute()) {
    // Get the newly inserted group ID
    $groupId = $stmt->insert_id;
    
    // Insert assigned patients into GroupPatient table
    if (!empty($assignedPatients)) {
        $insertPatientsSql = "INSERT INTO GroupPatient (group_id, patient_id) VALUES (?, ?)";
        $stmtPatients = $conn->prepare($insertPatientsSql);

        foreach ($assignedPatients as $patientId) {
            $stmtPatients->bind_param("ii", $groupId, $patientId);
            $stmtPatients->execute();
        }

        $stmtPatients->close();
    }

    // Set success response
    $response['success'] = true;
    $response['groupId'] = $groupId; // Send the new group ID back to the client
} else {
    $response['success'] = false;
}

$stmt->close();
$conn->close();

// Return response as JSON
echo json_encode($response);
?>
