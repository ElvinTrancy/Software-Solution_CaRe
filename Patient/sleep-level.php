<?php
// Start session
session_start();

// Include the database connection
include 'inc/dbconn.inc.php';

// Check if the form was submitted
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $sleep_level = $_POST['sleep_level'] ?? '';

    // Validate input
    if (empty($sleep_level)) {
        $error_message = "Please select your sleep level.";
    } else {
        // Insert sleep level into the database
        $sql = "INSERT INTO sleep_tracker (user_id, sleep_level, created_at) VALUES (?, ?, NOW())";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param('is', $_SESSION['user_id'], $sleep_level);
        $stmt->execute();

        // Redirect to the next step
        header("Location: diet-level.php");
        exit;
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sleep Tracker</title>
    <link rel="stylesheet" href="Styles/Basical.css">
    <link rel="stylesheet" href="Styles/Select.css">
    <link rel="stylesheet" href="Styles/moodNote.css">
</head>

<body>
    <div class="mood-select">
        <div class="header">
            <button class="back-btn">
                <a href="fitness-level.php">
                    <img src="images/back-icon.png" alt="Back">
                </a>
            </button>
            <img src="images/Progress Bar.png" alt="Progress Bar" style="height: 8px;">
            <a href="home.php"><button>Close</button></a>
        </div>

        <div>
           <h1>What is your current sleep level?</h1>
        </div>

        <!-- Sleep Level Form -->
        <form method="POST" action="">
            <div class="centered-image">
                <img src="images/sleep-level.png" alt="Sleep Level Icon">
            </div>

            <!-- Slider Section -->
            <div class="slider-container">
                <div class="slider-track">
                    <div class="slider-progress" id="slider-progress"></div>
                    <div class="slider-thumb" id="slider-thumb">»</div>
                </div>
                <p id="sleep-level-text">Level 3 (6 Hour/Day)</p>
                <input type="hidden" name="sleep_level" id="sleep-level-input" value="Level 3">
            </div>

            <button type="submit" class="continue-btn">Continue +</button>
        </form>
    </div>

    <script src="JS/exercise.js"></script>
    <script src="JS/moodnote.js"></script>
</body>
</html>
