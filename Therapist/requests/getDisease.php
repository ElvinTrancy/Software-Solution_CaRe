<?php
session_start();
require_once '../inc/dbconn.inc.php';

function getDiseaseCountPerDay($month, $year) {
    global $conn;

    // Prepare the SQL query to get disease count grouped by day and disease for the specified month and year
    $sql = "
        SELECT 
            d.name AS disease, 
            DATE(ptd.diagnosed_date) AS day, 
            COUNT(*) AS patient_count
        FROM PatientTherapistDisease ptd
        JOIN MentalDiseases d ON ptd.disease_id = d.id
        WHERE MONTH(ptd.diagnosed_date) = ? 
        AND YEAR(ptd.diagnosed_date) = ?
        GROUP BY day, disease
        ORDER BY day;
    ";

    // Prepare the statement to avoid SQL injection
    $stmt = $conn->prepare($sql);
    $stmt->bind_param('ii', $month, $year); // 'ii' for two integer parameters (month, year)
    $stmt->execute();
    $result = $stmt->get_result();

    $data = [];
    while ($row = $result->fetch_assoc()) {
        $data[] = [
            'day' => $row['day'], 
            'disease' => $row['disease'], 
            'patient_count' => $row['patient_count']
        ];
    }

    // Return the day-wise data grouped by disease
    return $data;
}

// Handle AJAX request
if (isset($_POST['month']) && isset($_POST['year'])) {
    $month = $_POST['month'];
    $year = $_POST['year'];
    header('Content-Type: application/json');

    $diseaseData = getDiseaseCountPerDay($month, $year);

    
    echo json_encode($diseaseData); // Return the data as JSON
    exit;
} else {
    header('Content-Type: application/json');
    echo json_encode(['error' => 'Month and year are required']);
    exit;
}
