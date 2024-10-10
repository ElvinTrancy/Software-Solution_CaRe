<?php
// Start session
session_start();

// Include the database connection
include 'inc/dbconn.inc.php';

// Fetch user-specific data 
$patient_id = $_SESSION['patient_id'] ?? null;

if ($patient_id === null) {
    // Handle the case where the session variable is missing
    header("Location: login.php"); 
    exit();
}

if (isset($_SESSION['moodValue']) && isset($_SESSION['selectedDate']) && isset($_SESSION['selectedDate'])) {
    
} else {
    header("Location: add.php"); 
}


// Check if the form was submitted
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $sleep_level = $_POST['sleepLevel'] ?? '';

    $moodValue = $_SESSION['moodValue'];  // Retrieve mood value
    $selectedDate = $_SESSION['selectedDate'];  // Retrieve selected date
    
    // Now you can use $moodValue and $selectedDate as needed
    echo "Mood: " . $moodValue . "<br>";
    echo "Selected Date: " . $selectedDate . "<br>";
    if (isset($_SESSION['moodValue']) && isset($_SESSION['selectedDate']) && isset($_SESSION['fitness_level'])) {
        
        $_SESSION['sleep_level'] = $sleep_level;

        // Return a success message to JavaScript
        echo "Data saved successfully!";
    } else {
        header("Location: diet-level.php"); 
    }
    exit(); // End script execution here
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
        <div method="POST" action="">
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
        </div>
    </div>

    <script src="JS/sleep.js"></script>

    <script>
        document.querySelector('.continue-btn').addEventListener('click', function() {
            // Use AJAX to send the data to the server without using a form
            const xhr = new XMLHttpRequest();
            xhr.open("POST", "sleep-level.php", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

            const sleepLevel = document.getElementById('sleep-level-input').value;
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    console.log(xhr.responseText); // Handle the response if needed

                    // Redirect to the next step after data is saved in session
                    window.location.href = "diet-level.php";
                }
            };

            // Send the data to PHP (encoded as URL parameters)
            const data = `sleepLevel=${encodeURIComponent(sleepLevel)}`;
            xhr.send(data);
        });
    </script>
</body>
</html>
