<?php
include '../inc/dbconn.inc.php';

header('Content-Type: application/json');

$patientId = $_GET['patient_id']; // Assuming the patient ID comes from the URL

$sql = "
    SELECT 
        SUM(CASE WHEN mood >= 5 THEN 1 ELSE 0 END) AS optimism,
        SUM(CASE WHEN mood < 5 THEN 1 ELSE 0 END) AS pessimism,
        COUNT(mood) AS total, 
        AVG(fitness_level) AS avg_fitness_level, 
        AVG(sleep_hours) AS avg_sleep_hours, 
        AVG(caloric_intake) AS avg_caloric_intake, 
        diet 
    FROM patientdailyrecords 
    WHERE patient_id = ?
    GROUP BY diet
";

$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $patientId); // Bind the patient ID
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
    $row = $result->fetch_assoc();

    // Prepare data for JavaScript
    $patientData = [
        'optimism' => $row['optimism'],
        'pessimism' => $row['pessimism'],
        'mood' => $row['total'],
        'fitness_level' => $row['avg_fitness_level'],
        'sleep_hours' => $row['avg_sleep_hours'],
        'caloric_intake' => $row['avg_caloric_intake'],
        'diet' => $row['diet']
    ];

    echo json_encode($patientData); // Send data back as JSON for use in JavaScript
} else {
    echo json_encode(['error' => 'No data found for this patient.']);
}
?>
