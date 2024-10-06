<?php
session_start();
require_once '../inc/dbconn.inc.php';

function getPatientCountPerDay($range) {
    global $conn;

    // Prepare SQL query for day-wise count and total count based on the time range
    switch ($range) {
        case '1 Day':
            $sql = "SELECT DATE(register_at) AS day, COUNT(*) AS patient_count 
                    FROM Patients 
                    WHERE register_at >= DATE_SUB(NOW(), INTERVAL 1 DAY) 
                    GROUP BY day 
                    ORDER BY day";
            $sql_total = "SELECT COUNT(*) AS total_count FROM Patients WHERE register_at >= DATE_SUB(NOW(), INTERVAL 1 DAY)";
            break;
        case '1 Week':
            $sql = "SELECT DATE(register_at) AS day, COUNT(*) AS patient_count 
                    FROM Patients 
                    WHERE register_at >= DATE_SUB(NOW(), INTERVAL 1 WEEK) 
                    GROUP BY day 
                    ORDER BY day";
            $sql_total = "SELECT COUNT(*) AS total_count FROM Patients WHERE register_at >= DATE_SUB(NOW(), INTERVAL 1 WEEK)";
            break;
        case '1 Month':
            $sql = "SELECT DATE(register_at) AS day, COUNT(*) AS patient_count 
                    FROM Patients 
                    WHERE register_at >= DATE_SUB(NOW(), INTERVAL 1 MONTH) 
                    GROUP BY day 
                    ORDER BY day";
            $sql_total = "SELECT COUNT(*) AS total_count FROM Patients WHERE register_at >= DATE_SUB(NOW(), INTERVAL 1 MONTH)";
            break;
        case '1 Year':
            $sql = "SELECT DATE(register_at) AS day, COUNT(*) AS patient_count 
                    FROM Patients 
                    WHERE register_at >= DATE_SUB(NOW(), INTERVAL 1 YEAR) 
                    GROUP BY day 
                    ORDER BY day";
            $sql_total = "SELECT COUNT(*) AS total_count FROM Patients WHERE register_at >= DATE_SUB(NOW(), INTERVAL 1 YEAR)";
            break;
        case 'All':
        default:
            $sql = "SELECT DATE(register_at) AS day, COUNT(*) AS patient_count 
                    FROM Patients 
                    GROUP BY day 
                    ORDER BY day";
            $sql_total = "SELECT COUNT(*) AS total_count FROM Patients";
            break;
    }

    // Execute the query to get day-wise data
    $result = $conn->query($sql);
    $data = [];
    while ($row = $result->fetch_assoc()) {
        $data[] = ['day' => $row['day'], 'patient_count' => $row['patient_count']];
    }

    // Execute the query to get the total count
    $result_total = $conn->query($sql_total);
    $total_count = 0;
    if ($result_total && $row_total = $result_total->fetch_assoc()) {
        $total_count = $row_total['total_count'];
    }

    // Return both the day-wise data and total count
    return ['day_data' => $data, 'total_count' => $total_count];
}

// Handle AJAX request
if (isset($_POST['range'])) {
    $range = $_POST['range'];
    $patientData = getPatientCountPerDay($range);
    echo json_encode($patientData); // Return the data as JSON
    exit;
}
