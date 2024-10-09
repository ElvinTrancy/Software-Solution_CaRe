<?php
// Start session and include database connection
session_start();
include 'inc/dbconn.inc.php';
include 'inc/side.inc.php';
if (!isset($_SESSION['therapist_id'])) {
  header('Location: login.php');
  exit;
}


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

    $notesSql = "SELECT note_id, note_text, therapist_id, DATE_FORMAT(note_date, '%d–%b–%Y') AS note_date FROM PatientNotes WHERE patient_id = ? ORDER BY note_id DESC";
    $stmtNotes = $conn->prepare($notesSql);
    $stmtNotes->bind_param("i", $patientId);
    $stmtNotes->execute();
    $resultNotes = $stmtNotes->get_result();

    $patientNotes = [];
    if ($resultNotes->num_rows > 0) {
        while ($row = $resultNotes->fetch_assoc()) {
            $patientNotes[] = [
                'note_id' => $row['note_id'],
                'note_text' => $row['note_text'],
                'therapist_id' => $row['therapist_id'],
                'note_date' => $row['note_date']
            ];
        }
    }

    $patientNotesJson = json_encode($patientNotes);

    $stmtNotes->close();

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
                  <div class="calendar-header" style="display: none;">
                    <button id="prev-month">&lt;</button>
                    <h2 id="calendar-month-year"></h2>
                    <button id="next-month">&gt;</button> 
                  </div>
              
                  <div class="view-options" style="display: none;">
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

      function convertDate(dateString) {
          // Split the date string into components
          const dateParts = dateString.split("–");
          
          const day = dateParts[0].trim();
          const month = dateParts[1].trim();
          const year = dateParts[2].trim();

          // Convert the month name to a two-digit month number
          const months = {
              "Jan": "01",
              "Feb": "02",
              "Mar": "03",
              "Apr": "04",
              "May": "05",
              "Jun": "06",
              "Jul": "07",
              "Aug": "08",
              "Sep": "09",
              "Oct": "10",
              "Nov": "11",
              "Dec": "12"
          };

          const monthNumber = months[month];

          // Return the date in the desired format
          return `${year}-${monthNumber}-${day.padStart(2, '0')}`;
      }
      let currentDate = new Date();
      let patientNotes = <?php echo $patientNotesJson; ?>;
      let calendarEvents = [];
      patientNotes.forEach(tr => {
        calendarEvents.push({
          group_id: tr.note_id,
          group_name: tr.note_text,
          meeting_date: convertDate(tr.note_date),
          meeting_time: "00:00:00",
          leader: '0',
          number_of_members: '0'
        });
      });

      console.log(calendarEvents)
      generateCalendar(currentDate, calendarEvents);
    </script>
    <script>
      document.addEventListener('DOMContentLoaded', function() {

//         group_id
// : 
// 1
// group_name
// : 
// "Mindful Masters"
// leader
// : 
// "101"
// meeting_date
// : 
// "0000-00-00"
// meeting_time
// : 
// "00:00:00"
// number_of_members
// : 
// 3


// note_date
// : 
// "08–Oct–2024"
// note_id
// : 
// 28
// note_text
// : 
// "t"
// therapist_id
// : 
// 1
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
