<?php
// Start session
session_start();

// Include the database connection
include 'inc/dbconn.inc.php';

// Fetch user-specific data (example for mood, diet, sleep, and exercise)
$user_id = $_SESSION['user_id'];

// Fetch mood distribution
$mood_sql = "SELECT mood, COUNT(*) AS count FROM mood_tracker WHERE user_id = ? GROUP BY mood";
$stmt = $conn->prepare($mood_sql);
$stmt->bind_param('i', $user_id);
$stmt->execute();
$mood_data = $stmt->get_result()->fetch_all(MYSQLI_ASSOC);

// Fetch diet status, sleep, and exercise records (similar queries can be added)
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="Styles/Basical.css">
    <link rel="stylesheet" href="Styles/NagBar.css">
    <link rel="stylesheet" href="css/index.css">
</head>

<body>
    <!-- Mood Distribution -->
    <div class="container">
        <h2>Mood Distribution</h2>
        <div class="card mood">
            <div class="icons">
                <?php foreach ($mood_data as $mood): ?>
                <div class="icon-item">
                    <div class="icon-content">
                        <img src="images/emotion-<?php echo strtolower($mood['mood']); ?>.png" alt="<?php echo $mood['mood']; ?> face">
                        <div class="text-content">
                            <p><?php echo ucfirst($mood['mood']); ?></p>
                            <p><?php echo round(($mood['count'] / array_sum(array_column($mood_data, 'count'))) * 100); ?>%</p>
                        </div>
                    </div>
                </div>
                <?php endforeach; ?>
            </div>
        </div>

        <!-- Diet Status, Sleep Mode, and Exercise Record sections here -->

        <!-- My Therapist Section -->
        <h2>My Therapist</h2>
        <div class="card therapist">
            <div class="section therapist">
                <div class="therapist-image">
                    <img src="images/image 1.png" alt="Therapist">
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
        <div class="nav-bar">
            <button><a href="home.php"><img src="images/home-icon.png" alt="Home"></a></button>
            <button><a href="analytics.php"><img src="images/analytics-icon.png" alt="Analytics"></a></button>
            <div class="center-btn">
                <button><a href="add.php"><img src="images/add-icon.png" alt="Add"></a></button>
            </div>
            <button><a href="services.php"><img src="images/services-icon.png" alt="Services"></a></button>
            <button><a href="profile.php"><img src="images/profile-icon.png" alt="Profile"></a></button>
        </div>
    </div>
</body>
</html>
