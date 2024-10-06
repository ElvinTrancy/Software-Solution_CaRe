<?php
// Start session
session_start();

// Include the database connection
include 'inc/dbconn.inc.php';

// Fetch user profile data
$user_id = $_SESSION['user_id'];

// Fetch patient and therapist data
$profile_sql = "SELECT p.patient_id, p.name AS patient_name, t.name AS therapist_name, p.diagnostic, p.group
                FROM patients p
                JOIN therapists t ON p.therapist_id = t.id
                WHERE p.user_id = ?";
$stmt = $conn->prepare($profile_sql);
$stmt->bind_param('i', $user_id);
$stmt->execute();
$profile_data = $stmt->get_result()->fetch_assoc();

// Fetch user activity logs
$log_sql = "SELECT * FROM activity_logs WHERE user_id = ? ORDER BY created_at DESC";
$stmt = $conn->prepare($log_sql);
$stmt->bind_param('i', $user_id);
$stmt->execute();
$activity_logs = $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
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
                <h2>Patient ID: <?php echo $profile_data['patient_id']; ?></h2>
                <div class="therapist-content">
                    <div class="therapist-image">
                        <img src="images/TaoZhe.jpeg" alt="Patient">
                    </div>
                    <div class="session-info">
                        <h2 style="color:#0F67FE;"><?php echo $profile_data['therapist_name']; ?></h2>
                        <h3>Patient Group: <?php echo $profile_data['group']; ?></h3>
                        <p style="color:#666;">Diagnostic: <?php echo $profile_data['diagnostic']; ?></p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Activity Logs -->
        <div class="entry-content">
            <?php foreach ($activity_logs as $log): ?>
            <div class="entry-info">
                <div class="entry-time">
                    <img src="images/Subtract.png" alt="Mood Icon" class="mood-icon">
                    <span class="time-text"><?php echo date('H:i', strtotime($log['created_at'])); ?></span>
                </div>
                <div class="entry-quote">
                    <img src="images/24 quote.png" alt="Quote Icon" class="quote-icon">
                    <p class="quote-text"><?php echo htmlspecialchars($log['note']); ?></p>
                </div>
                <div class="entry-details">
                    <img src="images/37 filter.png" alt="Filter Icon" class="icon">
                    <span><?php echo htmlspecialchars($log['location']); ?></span>
                </div>
                <div class="entry-activities">
                    <img src="images/77 activity hiking.png" alt="Activity Icon" class="icon">
                    <span><?php echo $log['activity_duration']; ?> hour</span>
                    <img src="images/91 sleep zzz.png" alt="Sleep Icon" class="icon">
                    <span><?php echo $log['sleep_duration']; ?> hour</span>
                </div>
            </div>
            <?php endforeach; ?>
        </div>

        <!-- Navigation Bar -->
        <div class="nav-bar">
            <button><a href="home.php"><img src="images/home-icon.png" alt="Home"></a></button>
            <button><a href="analytics.php"><img src="images/analytics-icon.png" alt="Analytics"></a></button>
            <div class="center-btn"><button><a href="add.php"><img src="images/add-icon.png" alt="Add"></a></button></div>
            <button><a href="services.php"><img src="images/services-icon.png" alt="Services"></a></button>
            <button><a href="profile.php"><img src="images/profile-icon.png" alt="Profile"></a></button>
        </div>
    </div>
</body>
</html>
