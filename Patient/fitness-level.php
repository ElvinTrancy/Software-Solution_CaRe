<?php
// Start session
session_start();

// Include the database connection
include 'inc/dbconn.inc.php';

// Check if the form was submitted
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $fitness_level = $_POST['fitness_level'] ?? '';

    // Validate the input
    if (empty($fitness_level)) {
        $error_message = "Please select your fitness level.";
    } else {
        // Insert the fitness level into the database
        $sql = "INSERT INTO fitness_tracker (user_id, fitness_level, created_at) VALUES (?, ?, NOW())";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param('is', $_SESSION['user_id'], $fitness_level);
        $stmt->execute();

        // Redirect to the next step
        header("Location: sleep-level.php");
        exit;
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Exercise Tracker</title>
    <link rel="stylesheet" href="Styles/Basical.css">
    <link rel="stylesheet" href="Styles/Select.css">
    <link rel="stylesheet" href="Styles/moodNote.css">
</head>

<body>
    <div class="mood-select">
        <div class="header">
            <button class="back-btn">
                 <a href="add.php">
                    <img src="images/back-icon.png" alt="Back">
                </a>
            </button>
            <img src="images/Progress Bar.png" alt="Progress Bar" style="height: 8px;">
            <a href="home.php"><button>Close</button></a>
        </div>

        <div>
           <h1>What is your current fitness level?</h1>
        </div>

        <!-- Fitness Level Form -->
        <form method="POST" action="">
            <div class="centered-image">
                <img src="images/fitness-level.png" alt="Fitness Level Icon">
            </div>

            <!-- Slider Section -->
            <div class="slider-container">
                <div class="slider-track">
                    <div class="slider-progress" id="slider-progress"></div>
                    <div class="slider-thumb" id="slider-thumb">»</div>
                </div>
                <p id="fitness-level-text">Level 3 (6 Hour/Day)</p>
                <input type="hidden" name="fitness_level" id="fitness-level-input" value="Level 3">
            </div>

            <button type="submit" class="continue-btn">Continue +</button>
        </form>
    </div>

    <script src="JS/exercise.js"></script>
</body>
</html>
