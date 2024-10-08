<?php
// Start session and include database connection
session_start();
include 'inc/dbconn.inc.php';
include 'inc/side.inc.php';

// Check if 'patient_id' is present in the URL
if (isset($_GET['patient_id'])) {
    $patientId = intval($_GET['patient_id']);

    // Fetch patient information from the database
    $sql = "SELECT 
                p.id, 
                p.name, 
                p.photo, 
                g.name AS group_name, 
                d.name AS disease_name
            FROM Patients p
            LEFT JOIN grouppatient gp ON gp.patient_id = p.id
            LEFT JOIN Groups g ON g.id = gp.group_id
            LEFT JOIN patienttherapistdisease ptd ON ptd.patient_id = p.id
            LEFT JOIN mentaldiseases d ON d.id = ptd.disease_id
            WHERE p.id = ?";
    
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $patientId); // Bind patient ID
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        $patient = $result->fetch_assoc();
    } else {
        echo "No patient found.";
        exit;
    }

    $stmt->close();
} else {
    echo "Patient ID is required.";
    exit;
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Therapist Dashboard</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600&display=swap">
    <link rel="stylesheet" href="css/index.css"> 
    <link rel="stylesheet" href="css/patients.css"> 
    <link rel="stylesheet" href="css/calendar.css"> 
    
    <script src="components/icon/index.js"></script>
    <style>
      .profile {
        display: flex;
        flex-direction: column;
        align-items: center;
        margin-bottom: 1rem;
      }

      .profile-img {
        border-radius: 1rem;
        width: 140px;
        height: 140px;
        object-fit: cover;
        margin-bottom: 0.5rem;
      }

      .event-list h2 {
        font-size: 1rem;
        color: #2260FF;
        text-align: center;
        margin-bottom: .5rem;
      }

      h3 {
        font-size: 1rem;
        color: #2260FF;
      }

      p {
        margin: 0.2rem 0;
        font-size: 0.9rem;
        color: #666;
      }

      .diagnostic-section,
      .goals-section,
      .interventions-section,
      .frequency-section {
        margin: 0.5rem 0;
        display: flex;
        flex-direction: column;
      }

      label {
        font-size: .825rem;
        color: #0F67FE;
        margin-bottom: 0.3rem;
        text-align: center;

      }

      .pill-button {
        background-color: #007bff;
        color: #fff;
        border: none;
        border-radius: 12px;
        line-height: 24px;
        padding: 0.5rem 1rem;
        font-size: 0.9rem;
        cursor: pointer;
        margin-top: 0.3rem;
      }

      .pill-button:hover {
        background-color: #0056b3;
      }

      .note {
        font-size: 0.8rem;
        color: #999;
        margin-top: 1rem;
      }

      .page-scrum {
        justify-content: start;
        gap: 1rem;
      }
      .go-back {
        cursor: pointer;
      }
    </style>
</head>
<body>
    <div class="dashboard">
        <div class="main-content" style="padding-left: 1rem;">         
          <div class="doc-main">
            <!-- Top bar -->
            <div class="top-bar">
              <div class="search-bar">
                <input type="text" placeholder="Search anything..." />
                <svg class="icon" aria-hidden="true">
                  <use xlink:href="#icon-search"></use>
                </svg>
                <svg class="wifi-icon" aria-hidden="true">
                  <use xlink:href="#icon-wifi"></use>
                </svg>
              </div>
              <button class="icon-btn">
                <svg class="icon" aria-hidden="true">
                  <use xlink:href="#icon-alarm"></use>
                </svg>
              </button>
              <button class="icon-btn">
                <svg class="icon" aria-hidden="true">
                  <use xlink:href="#icon-mail"></use>
                </svg>
              </button>
            </div>
            <div class="main-section">
              <div class="page-scrum">
                <h2 class="go-back" id="go-back">Patient Detail </h2><h2>></h2><h2>Treatment Record</h2>
              </div>
              <div class="calendar-container">
                <div class="event-list" style="justify-content: start;">
                  <div class="profile">
                  <img src="<?= htmlspecialchars($patient['photo']) ?>" alt="Patient Photo" class="profile-img">
                  <h2>Patient ID: <?= htmlspecialchars($patient['id']) ?><br><?= htmlspecialchars($patient['name']) ?></h2>
                  <p>Patient Group: <?= htmlspecialchars($patient['group_name']) ?></p>
                </div>
                <div class="diagnostic-section">
                <label>Diagnostic:</label>
                                <button class="pill-button"><?= htmlspecialchars($patient['disease_name']) ?></button>
                </div>
                <div class="goals-section">
                    <label>Goals:</label>
                    <button class="pill-button">Sleep Quality</button>
                </div>
                <div class="interventions-section">
                    <label>Interventions:</label>
                    <button class="pill-button">CBT</button>
                </div>
                <div class="frequency-section">
                    <label>Frequency:</label>
                    <button class="pill-button">Weekly</button>
                </div>
                <div class="frequency-section">
                  <label>Note:</label>
                  <p>This is just an example, and the specific goals, interventions, and frequency of sessions will vary depending on the individual client's needs and circumstances.</p>
                </div>
                </div>
                <div class="calendar-host">                  
                  <div class="calendar-header">
                    <button id="prev-month">&lt;</button>
                    <h2 id="calendar-month-year"></h2>
                    <button id="next-month">&gt;</button> 
                  </div>
              
                  <div class="view-options">
                      <button class="toggle-button">Day</button>
                      <button class="toggle-button">Week</button>
                      <button class="toggle-button active">Month</button>
                  </div>
              
                  <table class="calendar-table">
                      <thead>
                          <tr>
                              <th>MON</th>
                              <th>TUE</th>
                              <th>WED</th>
                              <th>THU</th>
                              <th>FRI</th>
                              <th>SAT</th>
                              <th>SUN</th>
                          </tr>
                      </thead>
                      <tbody id="calendar-body">
                          <!-- Calendar dates will be inserted here via JavaScript -->
                      </tbody>
                  </table>
                </div>
              </div>

              
            </div>
      </div>
    </div>
    <script src="js/calendar.js"></script>
    <script>
      document.addEventListener('DOMContentLoaded', function() {



        const treatmentRecordBtn = document.getElementById('go-back');

        treatmentRecordBtn.addEventListener('click', function() {
            // Navigate to the 'record.html' page
            window.location.href = 'patients.php';
        });
      });
    </script>
    <script src="js/nav_php.js"></script>
</body>
</html>
