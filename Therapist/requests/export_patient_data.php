<?php
session_start();
require_once '../inc/dbconn.inc.php';

// Function to export patient data as CSV
function exportPatientData() {
    global $conn;

    // SQL query to retrieve patient data, their diseases, and the doctors assigned
    $sql = "
        SELECT 
            p.id AS patient_id,
            p.name AS patient_name,
            p.email AS patient_email,
            p.phone_number AS patient_phone,
            p.date_of_birth AS patient_dob,
            p.address AS patient_address,
            d.name AS disease_name,
            t.name AS doctor_name
        FROM Patients p
        LEFT JOIN PatientTherapistDisease ptd ON p.id = ptd.patient_id
        LEFT JOIN MentalDiseases d ON ptd.disease_id = d.id
        LEFT JOIN Therapists t ON ptd.therapist_id = t.id
        ORDER BY p.id;
    ";

    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        // Set headers to force download the file as CSV
        header('Content-Type: text/csv; charset=utf-8');
        header('Content-Disposition: attachment; filename=patient_data.csv');
        
        // Create a file pointer connected to the output stream
        $output = fopen('php://output', 'w');

        // Output column headings
        fputcsv($output, array('Patient ID', 'Patient Name', 'Email', 'Phone Number', 'Date of Birth', 'Address', 'Disease', 'Doctor'));

        // Loop through the rows and output the data as CSV
        while ($row = $result->fetch_assoc()) {
            fputcsv($output, [
                $row['patient_id'],
                $row['patient_name'],
                $row['patient_email'],
                $row['patient_phone'],
                $row['patient_dob'],
                $row['patient_address'],
                $row['disease_name'] ?: 'N/A',  // If no disease, display 'N/A'
                $row['doctor_name'] ?: 'N/A'    // If no doctor, display 'N/A'
            ]);
        }

        // Close the output stream
        fclose($output);
    } else {
        echo "No data found.";
    }
}

// Call the export function
exportPatientData();
?>
