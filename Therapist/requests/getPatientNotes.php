<?php
session_start();
require_once '../inc/dbconn.inc.php';

if (isset($_GET['patient_id'])) {
    $patientId = intval($_GET['patient_id']);

    // Fetch notes from the database for the given patient
    $sql = "SELECT note_text, DATE_FORMAT(note_date, '%d–%b–%Y') AS note_date 
            FROM PatientNotes 
            WHERE patient_id = ? 
            ORDER BY note_id DESC";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $patientId);
    $stmt->execute();
    $result = $stmt->get_result();

    $notes = [];
    while ($row = $result->fetch_assoc()) {
        $notes[] = [
            'text' => $row['note_text'],
            'date' => $row['note_date']
        ];
    }

    // Return the notes as JSON
    echo json_encode(['notes' => $notes]);
    exit;
} else {
    echo json_encode(['error' => 'Patient ID is required']);
    exit;
}
?>
