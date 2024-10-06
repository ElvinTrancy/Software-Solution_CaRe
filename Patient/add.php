<?php
// Start session
session_start();

// Include the database connection
include 'inc/dbconn.inc.php';

// Check if the form was submitted
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Capture the selected mood and date (today, yesterday, tomorrow)
    $mood = $_POST['mood'] ?? '';
    $date_option = $_POST['date_option'] ?? '';

    // Validate the input
    if (empty($mood) || empty($date_option)) {
        $error_message = "Please select a mood and a date.";
    } else {
        // Insert the mood into the database
        $sql = "INSERT INTO mood_tracker (user_id, mood, date_option, created_at) VALUES (?, ?, ?, NOW())";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param('iss', $_SESSION['user_id'], $mood, $date_option);
        $stmt->execute();

        // Redirect to the next step (e.g., fitness-level.html)
        header("Location: fitness-level.php");
        exit;
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mood Tracker</title>
    <link rel="stylesheet" href="Styles/Basical.css">
    <link rel="stylesheet" href="Styles/moodNote.css">
    <link rel="stylesheet" href="Styles/Select.css">
    <link rel="stylesheet" href="css/add.css">
</head>
<body>
    <div class="mood-select">
        <div class="header">
            <button class="back-btn">
                <a href="index.php">
                <img src="images/back-icon.png" alt="Back">
                </a>
            </button>
            <img src="images/Progress Bar.png" alt="Progress Bar" style="height: 8px;">
            <a href="home.php">
            <button>Close</button>
            </a>
        </div>

        <!-- Mood form -->
        <form method="POST" action="">
            <div class="mood-buttons">
                <button name="date_option" value="yesterday" id="yesterday">Yesterday</button>
                <button name="date_option" value="today" id="today" class="active">Today</button>
                <button name="date_option" value="tomorrow" id="tomorrow">Tomorrow</button>
            </div>

            <div class="arrow-container">
                <div class="arrow reversed"></div>
            </div>

            <div class="scroll-container" id="scroll-container">
                <input type="radio" name="mood" value="depressed" id="mood-depressed" required>
                <label for="mood-depressed">
                    <img src="images/Solid emotion depressed.png" alt="emotion 1">
                </label>

                <input type="radio" name="mood" value="sad" id="mood-sad">
                <label for="mood-sad">
                    <img src="images/Solid emotion sad.png" alt="emotion 2">
                </label>

                <input type="radio" name="mood" value="neutral" id="mood-neutral">
                <label for="mood-neutral">
                    <img src="images/Solid emotion neutral.png" alt="emotion 3">
                </label>

                <input type="radio" name="mood" value="happy" id="mood-happy">
                <label for="mood-happy">
                    <img src="images/Solid emotion happy.png" alt="emotion 4">
                </label>

                <input type="radio" name="mood" value="overjoyed" id="mood-overjoyed">
                <label for="mood-overjoyed">
                    <img src="images/Solid emotion overjoyed.png" alt="emotion 5">
                </label>
            </div>

            <div class="arrow-container">
                <div class="arrow"></div>
            </div>

            <div class="mood-label" id="percentage-display">I'm feeling neutral.</div>

            <!-- Submit button -->
            <button type="submit" class="continue-btn">Continue +</button>
        </form>
    </div>

    <script src="JS/script.js"></script>
</body>
</html>
