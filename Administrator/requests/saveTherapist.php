<?php
// Include database connection
require_once '../inc/dbconn.inc.php';

$data = json_decode(file_get_contents('php://input'), true);

$name = $data['name'];
$email = $data['email'];
$field = $data['field'];
$brief = $data['brief'];
$certificates = $data['certificates'];
$patients = $data['patients'];
$groups = $data['groups'];

// Generate a default password hash (SHA256 for "123456")
$defaultPassword = hash('sha256', '123456');

// Insert/Update the therapist's basic information
$therapistId = null; // Initialize the therapist ID

// Check if this is an existing therapist by email or name
$checkSql = "SELECT id FROM therapists WHERE email = ? OR name = ?";
$stmt = $conn->prepare($checkSql);
$stmt->bind_param("ss", $email, $name);
$stmt->execute();
$stmt->bind_result($existingTherapistId);
if ($stmt->fetch()) {
    $therapistId = $existingTherapistId;
}
$stmt->close();

if ($therapistId) {
    // Update the existing therapist
    $updateSql = "UPDATE therapists SET name = ?, email = ?, field = ?, brief = ? WHERE id = ?";
    $stmt = $conn->prepare($updateSql);
    $stmt->bind_param("ssssi", $name, $email, $field, $brief, $therapistId);
} else {
    // Insert a new therapist with the default password
    $insertSql = "INSERT INTO therapists (name, email, field, brief, password) VALUES (?, ?, ?, ?, ?)";
    $stmt = $conn->prepare($insertSql);
    $stmt->bind_param("sssss", $name, $email, $field, $brief, $defaultPassword);
    $stmt->execute();
    $therapistId = $stmt->insert_id; // Get the newly inserted therapist ID
}
$stmt->close();

// Handle patients - Clear existing assignments for this therapist first
$clearPatientsSql = "DELETE FROM therapist_assigned_patients WHERE therapist_id = ?";
$stmt = $conn->prepare($clearPatientsSql);
$stmt->bind_param("i", $therapistId);
$stmt->execute();
$stmt->close();

// Insert new patient assignments
foreach ($patients as $patient) {
    if ($patient['selected']) {
        $patientId = $patient['id'];
        $assignmentType = 'Primary'; // Default assignment type
        $status = 'Active'; // Default status
        $assignedDate = date('Y-m-d'); // Assign the current date

        $insertPatientSql = "INSERT INTO therapist_assigned_patients (therapist_id, patient_id, assignment_type, assigned_date, status) VALUES (?, ?, ?, ?, ?)";
        $stmt = $conn->prepare($insertPatientSql);
        $stmt->bind_param("iisss", $therapistId, $patientId, $assignmentType, $assignedDate, $status);
        $stmt->execute();
        $stmt->close();
    }
}

// Handle certificates - This can be similarly done as per your project needs (optional)
if (!empty($certificates)) {
    // Handle certificate uploading logic here (optional)
}

// Handle groups - This can be similarly done as per your project needs (optional)
if (!empty($groups)) {
    // Handle group logic here (optional)
}

// Return success response
echo json_encode(['success' => true, 'message' => 'Therapist information and assignments saved successfully.']);
?>
