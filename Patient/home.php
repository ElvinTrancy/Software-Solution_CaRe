<?php

// Start session
session_start();

// Include the database connection
include 'inc/dbconn.inc.php';



// Fetch user-specific data 
$patientId = $_SESSION['patient_id'] ?? null;

if ($patientId === null) {
    // Handle the case where the session variable is missing
    header("Location: login.php"); 
    exit();
}


$sql = "
SELECT 
    SUM(CASE WHEN mood >= 5 THEN 1 ELSE 0 END) AS optimism,
    SUM(CASE WHEN mood < 5 THEN 1 ELSE 0 END) AS pessimism,
    COUNT(mood) AS total, 
    ROUND(AVG(fitness_level), 2) AS avg_fitness_level, 
    ROUND(AVG(sleep_hours), 2) AS avg_sleep_hours, 
    ROUND(AVG(caloric_intake), 2) AS avg_caloric_intake, 
    GROUP_CONCAT(diet ORDER BY record_date ASC) AS diet_history
FROM 
    patientdailyrecords 
WHERE 
    patient_id = ?

";

$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $patientId); // Bind the patient ID
$stmt->execute();
$result = $stmt->get_result();

$patientData = $result->fetch_assoc();

$dietList = explode(',', $patientData["diet_history"]);

$dietListJson = json_encode($patientId);


$therapistSql = "
    SELECT 
        t.id AS therapist_id, 
        t.photo,
        t.name as name 
    FROM 
        patienttherapistdisease ptd
    JOIN 
        therapists t ON ptd.therapist_id = t.id
    WHERE 
        ptd.patient_id = ?
";

$stmt = $conn->prepare($therapistSql);
$stmt->bind_param("i", $patientId);
$stmt->execute();
$therapistResult = $stmt->get_result();

$stmt->close();
$therapistId = "";
$therapistPhoto = "";
$therapistName = "";

if ($therapistResult->num_rows > 0) {
    $therapistData = $therapistResult->fetch_assoc();
   
    $therapistId = $therapistData['therapist_id'];
    $therapistPhoto = $therapistData['photo'];
    $therapistName = $therapistData['name'];
}


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
$patientDetail = $patientResult->fetch_assoc();

?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <link rel="stylesheet" href="Styles/DataVis.css">
    <link rel="stylesheet" href="Styles/profile.css">
    <link rel="stylesheet" href="Styles/Basical.css">
    <link rel="stylesheet" href="Styles/NagBar.css">
    <link rel="stylesheet" href="css/index.css">
</head>

<body>
    <!-- Mood Distribution -->
    <div class="container">
        <div class="card">
            <div class="section therapist">
                <!-- <h2>Patient ID: <?php echo htmlspecialchars($patientDetail['id']); ?></h2> -->
                <div class="therapist-content">
                    <div class="therapist-image">
                        <img onerror="this.src = 'images/taozhe.jpeg'" src="<?php echo htmlspecialchars($patientDetail['photo']); ?>" alt="Patient">
                    </div>
                    <div class="session-info">
                        <h2 style="color:#0F67FE;"><?php echo htmlspecialchars($patientDetail['name']); ?></h2>
                        <h3>Patient Group: </h3>
                        <h3><?php echo htmlspecialchars($patientDetail['group_name']); ?></h3>
                        <p style="color:#666;">Diagnostic: <?php echo htmlspecialchars($patientDetail['disease_name']); ?></p>
                    </div>
                </div>
            </div>
        </div>
        <h2>Mood Distribution</h2>
        <div class="card mood">
            <div class="icons">
                <div class="icon-item">
                    <div class="icon-content">
                        <img src="images/emotion-happy.png" alt="Happy face">
                        <div class="text-content">
                            <p>Optimism</p>
                            <p><?php echo $patientData['total'] != 0 ? round(($patientData['optimism'] / $patientData['total']) * 100, 0) . '%' : 'N/A'; ?></p>

                        </div>
                    </div>
                </div>
                <div class="icon-item">
                    <div class="icon-content">
                        <img src="images/emotion-neutral.png" alt="Neutral face">
                        <div class="text-content">
                            <p>Pessimism</p>
                            <p><?php echo $patientData['total'] != 0 ? round(($patientData['pessimism'] / $patientData['total']) * 100, 0) . '%' : 'N/A'; ?></p>

                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Diet -->
        <h2>Diet Status</h2>
        <div class="card diet">            
            <div class="scroll-container">
            <?php foreach ($dietList as $diet): ?>
                <img src="images/diet<?php echo htmlspecialchars($diet); ?>.png" alt="Diet <?php echo htmlspecialchars($diet); ?>">
            <?php endforeach; ?>
            </div>
        </div>

        <!-- Sleep Mode -->
        <h2>Sleep Mode</h2>
        <div class="card sleep">
            <div class="sleep-chart">
            </div>
            <div class="sleep-info">
                <div class="num"><?php echo round($patientData['avg_sleep_hours'], 2); ?> Hour/</div>
                <div class="unit">Day</div>
            </div>
        </div>

        <!-- Exercise Record -->
        <h2>Exercise Record</h2>
        <div class="card exercise">
            <div class="exercise-chart">
            </div>
            <div class="sleep-info">
                <div class="num"><?php echo round($patientData['avg_fitness_level'], 2); ?> Hour/</div>
                <div class="unit">Day</div>
            </div>
        </div>

        <!-- My Therapist -->
        <h2>My Therapist</h2>
        <div class="card therapist">
            <div class="section therapist">
                <div class="therapist-image">
                <img src="images/<?php echo htmlspecialchars($therapistPhoto); ?>" alt="Therapist" onerror="this.src = 'images/image 1.png'">
                </div>
                <div class="session-info">
                    <h2>1 on 1 Sessions</h2>
                    <h3>Let’s open up to the things that matter the most</h3>
                    <div class="book-now-button">
                        <span>Book Now</span>
                    </div>
                </div>
            </div>
        </div>
        <!-- Navigation Bar -->
        <?php include 'inc/nav-bar.php'; ?>
    </div>
    <script>
        function showPatientDetails(patient) {
            patientId = patient.id;
            // Populate the patient details div with selected patient data
            document.querySelector('.patient-photo').src = patient.photo || 'default_image.png'; // Use default if no photo
            document.querySelector('.pid').textContent = 'Patient ID: ' + patient.id;
            document.querySelector('.pna').textContent = patient.name;
            document.querySelector('.png').textContent = 'Patient Group: ' + (patient.group_name || 'No Group');

            // Update diagnostic dropdown
            const diagnosticSelect = document.querySelector('.diagnostic');
            diagnosticSelect.innerHTML = 'Diagnostic:' + (patient.disease_name || 'No Diagnosis'); 

            fetch('requests/getPatientDetails.php?patient_id=' + patientId)
            .then(response => response.json())
            .then(record => {
                if (record.error) {
                    alert('Error: no record yet');

                    document.querySelector('.mood-op').textContent = 'N/A';

                document.querySelector('.mood-pe').textContent = 'N/A';
                document.querySelector('.fitness-level').textContent = 'N/A';
                document.getElementById('sleep-hours').textContent = 'N/A';
                document.querySelector('.diet-status').textContent = 'Diet: ' + ('N/A');
                    return;
                }
                // Update the DOM elements with the average data
                document.querySelector('.mood-op').textContent = record.mood != 0 ? (100 *record.optimism / record.mood).toFixed(0) + '%' : 'N/A';
                document.querySelector('.mood-pe').textContent = record.mood != 0 ? (100*record.pessimism / record.mood).toFixed(0) + '%' : 'N/A';
                document.querySelector('.fitness-level').textContent = record.fitness_level ? record.fitness_level.toFixed(1) + ' hour/Day' : 'N/A';
                document.getElementById('sleep-hours').textContent = record.sleep_hours ? record.sleep_hours + ' hours/day' : 'N/A';
                document.querySelector('.diet-status').textContent = 'Diet: ' + (record.diet || 'N/A');
            })
            .catch(error => console.error('Error fetching patient data:', error));
            }
    </script>
</body>

</html>