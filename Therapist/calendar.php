<?php
// Include database connection and session check
include 'inc/dbconn.inc.php';
include 'inc/side.inc.php';

session_start();

// Check if therapist is logged in
if (!isset($_SESSION['therapist_id'])) {
    header('Location: login.php');
    exit;
}

$therapist_id = $_SESSION['therapist_id'];
$sql = "
    SELECT g.id AS group_id, g.name AS group_name, gm.meeting_date, gm.meeting_time, g.leader, 
    (SELECT COUNT(*) FROM GroupPatient gp WHERE gp.group_id = g.id) AS number_of_members
    FROM Groups g
    JOIN GroupMeetings gm ON g.id = gm.group_id
    WHERE g.status = 'Active' AND g.therapist_id = ?
    ORDER BY gm.meeting_date ASC, gm.meeting_time ASC
";
$stmt = $conn->prepare($sql);
$stmt->bind_param('i', $therapist_id); // Bind the therapist_id parameter
$stmt->execute();
$meetingRecords = $stmt->get_result()->fetch_all(MYSQLI_ASSOC);

// Encode meeting records as JSON for JavaScript to access
$meetingRecordsJson = json_encode($meetingRecords);
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Therapist Dashboard</title>
    <link rel="stylesheet" href="css/index.css"> 
    <link rel="stylesheet" href="css/calendar.css"> 
    <script src="components/icon/index.js"></script>
</head>
<body>
    <div class="dashboard">
        <div class="main-content" style="padding-left: 1rem;">
            <div class="doc-main">
                <div class="top-bar">
                    <div class="search-bar">
                        <input type="text" placeholder="Search anything..." />
                        <svg class="icon" aria-hidden="true">
                            <use xlink:href="#icon-search"></use>
                        </svg>
                    </div>
                </div>

                <div class="calendar-container">
                    <div class="event-list">
                        <button class="add-event-btn" onclick="window.location.href = 'add-calendar.php'">+ Add New Event</button>

                        <h2>Upcoming Events</h2>

                        <?php foreach ($meetingRecords as $record): ?>
                        <div class="event-card">
                            <div class="event-icon"></div>
                            <div class="event-info">
                                <h3><?php echo htmlspecialchars($record['group_name']); ?></h3>
                                <p><?php echo htmlspecialchars(date('d F Y', strtotime($record['meeting_date']))); ?> at <?php echo htmlspecialchars($record['meeting_time']); ?></p>
                                <p>Leader: <?php echo htmlspecialchars($record['leader']); ?></p>
                                <div class="attendees">
                                  <img src="assets/head1.png" alt="Attendee 1">
                                  <img src="assets/head2.png" alt="Attendee 2">
                                  <img src="assets/head0.png" alt="Attendee 3">
                                  <span class="attendee-count">+<?php echo htmlspecialchars($record['number_of_members']); ?></span>
                                </div>
                              </div>
                        </div>
                        <?php endforeach; ?>

                        <?php if (count($meetingRecords) == 0): ?>
                            <p>No upcoming events.</p>
                        <?php endif; ?>
                    </div>

                    <!-- Calendar structure -->
                    <div class="calendar-host">
                        <div class="calendar-header">
                            <!-- <button id="prev-month">&lt;</button> -->
                            <h2 id="calendar-month-year"></h2>
                            <!-- <button id="next-month">&gt;</button> -->
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

    <!-- Pass PHP data to JavaScript -->
    <script>
        
    </script>
    
    <script src="js/calendar.js"></script> 
    <script>
      let currentDate = new Date();
      let meetingRecords = <?php echo $meetingRecordsJson; ?>;
      console.log(meetingRecords);
      generateCalendar(currentDate, meetingRecords);
    </script>
    <script src="js/nav_php.js"></script>
</body>
</html>
