<?php
// Start session
session_start();

// Include the database connection
include 'inc/dbconn.inc.php';

$patientId = $_SESSION['patient_id'] ?? null;

if ($patientId === null) {
    // Handle the case where the session variable is missing
    header("Location: login.php"); 
    exit();
}

// 1. Fetch patient data
$patientsSql = "
    SELECT 
        p.id AS id, 
        p.name AS name, 
        p.photo, 
        MAX(g.name) AS group_name, 
        MAX(d.name) AS disease_name
    FROM Patients p
    LEFT JOIN grouppatient gp ON gp.patient_id = p.id
    LEFT JOIN Groups g ON g.id = gp.group_id
    LEFT JOIN patienttherapistdisease ptd ON ptd.patient_id = p.id
    LEFT JOIN mentaldiseases d ON d.id = ptd.disease_id
    WHERE p.id = ?
    GROUP BY p.id, p.name, p.photo
";

$stmt = $conn->prepare($patientsSql);
$stmt->bind_param("i", $patientId);
$stmt->execute();
$patientResult = $stmt->get_result();
$patientData = $patientResult->fetch_assoc();

// 2. Now fetch patient daily records
$dailyRecordsSql = "
    SELECT 
        record_date, 
        mood, 
        fitness_level, 
        sleep_hours, 
        diet, 
        caloric_intake, 
        sleep_time, 
        exercise_time, 
        notes,
        location
    FROM patientdailyrecords 
    WHERE patient_id = ?
    ORDER BY record_date DESC
";

$stmt = $conn->prepare($dailyRecordsSql);
$stmt->bind_param("i", $patientId);
$stmt->execute();
$dailyRecordsResult = $stmt->get_result();

// 3. Save daily records into an array
$dailyRecords = [];
while ($row = $dailyRecordsResult->fetch_assoc()) {
    $dailyRecords[] = $row;
}

$stmt->close();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile</title>
    <link rel="stylesheet" href="Styles/Basical.css">
    <link rel="stylesheet" href="Styles/DataVis.css">
    <link rel="stylesheet" href="Styles/NagBar.css">
    <link rel="stylesheet" href="Styles/profile.css">
</head>

<body>
    <div class="container">
        <!-- Patient & Therapist Information -->
        <div class="card">
        <div class="section therapist">
            <h2>Patient ID: <?php echo htmlspecialchars($patientData['id']); ?></h2>
            <div class="therapist-content">
                <div class="therapist-image" onclick="triggerFileUpload()">
                    <img id="patient-photo" onerror="this.src = 'images/taozhe.jpeg'" src="<?php echo htmlspecialchars($patientData['photo']); ?>" alt="Patient">
                    <input type="file" id="camera-upload" name="camera" style="display: none;" accept="image/*">
                </div>
                <div class="session-info">
                    <h2 style="color:#0F67FE;"><?php echo htmlspecialchars($patientData['name']); ?></h2>
                    <h3>Patient Group: </h3>
                    <h3><?php echo htmlspecialchars($patientData['group_name']); ?></h3>
                    <p style="color:#666;">Diagnostic: <?php echo htmlspecialchars($patientData['disease_name']); ?></p>
                </div>
            </div>
        </div>
        </div>

        <?php foreach ($dailyRecords as $record) {?>
            <div class="entry-header">
                <span class="date"><?php echo date('d/m/Y', strtotime($record['record_date'])); ?></span>
            </div>
            <div class="entry-content">
                <div class="entry-info">
                    <div class="entry-time">
                        <img src="images/Subtract.png" alt="Mood Icon" class="mood-icon">
                        <span class="time-text"><?php echo date('H:i', strtotime($record['sleep_time'])); ?></span>
                    </div>

                    <div class="entry-quote">
                        <img src="images/24 quote.png" alt="Quote Icon" class="quote-icon">
                        <p class="quote-text"><?php echo htmlspecialchars($record['notes']); ?></p>
                    </div>

                    <div class="entry-details">
                        <img src="images/37 filter.png" alt="Filter Icon" class="icon">
                        <span><?php echo htmlspecialchars($record['location'] ?? 'Unknown Location'); ?></span> <!-- Assuming there's a location field -->
                    </div>

                    <div class="entry-activities">
                        <img src="images/77 activity hiking.png" alt="Activity Icon" class="icon">
                        <span><?php echo $record['exercise_time']; ?> hour</span>
                        <img src="images/91 sleep zzz.png" alt="Sleep Icon" class="icon">
                        <span><?php echo $record['sleep_hours']; ?> hour</span>
                    </div>
                </div>
                <!-- <div class="additional-entry">
                    <div class="additional-entry-header">
                        <img src="images/Subtract.png" alt="Mood Icon" class="mood-icon">
                        <span class="time-text"><?php echo date('H:i', strtotime($record['sleep_time'])); ?></span>
                    </div>

                    <div class="entry-record">
                        <img src="images/voice record.png" alt="Voice Record Icon" style="padding-left: 20px;">
                    </div>

                    <div class="entry-quote">
                        <img src="images/24 quote.png" alt="Quote Icon" class="quote-icon">
                        <p class="quote-text"><?php echo htmlspecialchars($record['notes']); ?></p>
                    </div>

                    <div class="entry-details">
                        <img src="images/37 filter.png" alt="Filter Icon" class="icon">
                        <span><?php echo htmlspecialchars($record['location'] ?? 'Unknown Location'); ?></span>
                    </div>

                    <div class="entry-activities">
                        <img src="images/77 activity hiking.png" alt="Activity Icon" class="icon">
                        <span><?php echo $record['exercise_time']; ?> hour</span>
                        <img src="images/91 sleep zzz.png" alt="Sleep Icon" class="icon">
                        <span><?php echo $record['sleep_hours']; ?> hour</span>
                    </div>
                </div> -->
            </div>
        <?php
        }
        ?>
        <?php include 'inc/nav-bar.php'; ?>
    </div>
    <script>

        document.getElementById('camera-upload').addEventListener('change', function() {
            uploadFile('camera-upload');
        });
        function triggerFileUpload() {
            // Trigger the file input dialog
            document.getElementById('camera-upload').click();
        }

        function uploadFile(fileInputId) {
            const fileInput = document.getElementById(fileInputId);
            const formData = new FormData();
            formData.append(fileInput.name, fileInput.files[0]);

            // Perform the AJAX request to upload.php
            fetch('requests/upload.php', {
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    
                    // Update the image src to the new path
                    document.getElementById('patient-photo').src = data.filePath;

                    // After successful upload, send another request to update the patient's photo field
                    updatePatientPhoto(data.filePath);
                } else {
                    alert('Error uploading file: ' + data.error);
                }
            })
            .catch(error => console.error('Error:', error));
        }

        function updatePatientPhoto(filePath) {
            const patientId = <?php echo json_encode($patientData['id']); ?>; // Assuming patient ID is available in PHP
            
            // Send the updated photo path to the server to update the patient's photo in the database
            fetch('requests/updatePatientPhoto.php', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ patient_id: patientId, photo: filePath })
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('Patient photo updated successfully.');
                } else {
                    alert('Error updating patient photo: ' + data.error);
                }
            })
            .catch(error => console.error('Error:', error));
        }
    </script>
</body>
</html>
