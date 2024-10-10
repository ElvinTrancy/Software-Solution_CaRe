<?php

session_start();

include 'inc/side.inc.php';
include 'inc/nav.inc.php';
include 'inc/dbconn.inc.php';

if (!isset($_SESSION['user_id'])) {
    header('Location: login.php');
    exit();
}

$sql = "SELECT id, therapist_id, patient_id, appointment_date, notes, status FROM appointments";
    
$result = $conn->query($sql);

$appointments = $result->fetch_all(MYSQLI_ASSOC);

?>



<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Therapist Management</title>
    <link rel="stylesheet" href="components/modal/index.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/index.css">
    <link rel="stylesheet" href="pages/appointment/index.css">   
    <link rel="stylesheet" href="components/filter/index.css">
    <link rel="stylesheet" href="css/calendar.css">
    <link href="components/pagination/index.css" rel="stylesheet">
    <link href="components/statusBar/index.css" rel="stylesheet">
    <link href="components/loading/index.css" rel="stylesheet">
    <script src="components/icon/index.js"></script>
</head>
<body>
  <div class="content">
    <div class="bread-bar">
        <div class="link">
          Group management >
        </div>
        <div class="announcement">
            <svg class="icon arrow-icon" aria-hidden="true">
                <use xlink:href="#icon-announcement"></use>
            </svg>
            <span style="margin-left: 4px;">announcement</span>
        </div>
    </div>
    <div class="calender-container">
      <!-- <div id='calendar'></div> -->
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
            </tbody>
        </table>
      </div>
    </div>
  </div>
  
  </div>

  <div class="bottom-info">
    <span>Privacy Policy</span>
    <span style="margin-left: 3rem;">Terms of Use</span>
  </div>
 
  <script src="components/modal/confirm.js"></script>
  <script>
    const randomEvents = Object.values(<?php echo json_encode($appointments); ?>);
  </script>
 
<script src="js/calendar.js"></script>
</body>
</html>
