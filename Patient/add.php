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

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // Check if both moodValue and selectedDate are present
    if (isset($_POST['moodValue']) && isset($_POST['selectedDate'])) {
        // Sanitize and store the values in session
        $moodValue = intval($_POST['moodValue']);  // Get the mood value (1-10)
        $selectedDate = $_POST['selectedDate'];    // Get the selected date

        // Save data to session
        $_SESSION['moodValue'] = $moodValue;
        $_SESSION['selectedDate'] = $selectedDate;

        // Return a success message to JavaScript
        echo "Data saved successfully!";
    } else {
        // Return an error message if the values are missing
        echo "Error: Mood value or date is missing!";
    }
    exit(); // End script execution here
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
                <a href="home.php">
                <img src="images/back-icon.png" alt="Back">
                </a>
            </button>
            <img src="images/Progress Bar.png" alt="Progress Bar" style="height: 8px;">
            <a href="home.php">
            <button>Close</button>
            </a>
        </div>

        <!-- Mood form -->
        <div>
            <div class="mood-buttons">
                <button name="date_option" value="yesterday" id="yesterday">Yesterday</button>
                <button name="date_option" value="today" id="today" class="active">Today</button>
                <button name="date_option" value="tomorrow" id="tomorrow">Tomorrow</button>
            </div>

            <div class="arrow-container">
                <div class="arrow reversed"></div>
            </div>

            <div class="scroll-container" id="scroll-container">
                <img src="images/Solid emotion depressed.png" alt="emotion 1">
                <img src="images/Solid emotion sad.png" alt="emotion 2">
                <img src="images/Solid emotion neutral.png" alt="emotion 3">
                <img src="images/Solid emotion happy.png" alt="emotion 4">
                <img src="images/Solid emotion overjoyed.png" alt="emotion 5">
            </div>

            <div class="arrow-container">
                <div class="arrow"></div>
            </div>

            <div class="mood-label" id="percentage-display">I'm feeling neutral.</div>

            <!-- Submit button -->
            <button type="submit" class="continue-btn">Continue +</button>
        </div>
    </div>

    <script>

        window.onload = function() {
            const scrollContainer = document.getElementById('scroll-container');
            const images = scrollContainer.querySelectorAll('img');
            const middleIndex = Math.floor(images.length / 2) + 1;
                        
            // Calculate scroll position and scroll to the middle image
            const imageWidth = images[middleIndex].offsetWidth - 10;
            const containerWidth = scrollContainer.offsetWidth;
            
            // Scroll to the middle image
            scrollContainer.scrollLeft = (imageWidth + 20) * middleIndex - (containerWidth / 2) + (imageWidth / 2);
            
        };

        // Function to handle the button click and toggle active state
        function handleButtonClick(event) {
            event.stopPropagation();
            // Get all the buttons
            const buttons = document.querySelectorAll('.mood-buttons button');

            // Remove active class from all buttons
            buttons.forEach(button => {
                button.classList.remove('active');
            });

            // Add active class to the clicked button
            event.target.classList.add('active');
        }

        // Add event listeners to all buttons
        document.querySelectorAll('.mood-buttons button').forEach(button => {
            button.addEventListener('click', handleButtonClick);
        });

        const scrollContainer = document.getElementById('scroll-container');
        const images = scrollContainer.getElementsByTagName('img');
        const percentageDisplay = document.getElementById("percentage-display");

        scrollContainer.addEventListener("scroll", function() {
            const scrollWidth = scrollContainer.scrollWidth - scrollContainer.clientWidth;
            const scrollLeft = scrollContainer.scrollLeft;

        
            const scrollPercent = (scrollLeft / scrollWidth) * 100;

            if (scrollPercent < 20) {
                percentageDisplay.textContent = "I'm feeling depressed.";
            } else if (scrollPercent < 40) {
                percentageDisplay.textContent = "I'm feeling sad.";
            } else if (scrollPercent < 60) {
                percentageDisplay.textContent = "I'm feeling neutral.";
            } else if (scrollPercent < 80) {
                percentageDisplay.textContent = "I'm feeling happy.";
            } else {
                percentageDisplay.textContent = "I'm feeling overjoyed.";
            }
        });

        document.querySelector('.continue-btn').addEventListener('click', function() {
            const scrollContainer = document.getElementById('scroll-container');
            const scrollWidth = scrollContainer.scrollWidth - scrollContainer.clientWidth;
            const scrollPercent = scrollContainer.scrollLeft / scrollWidth; // Get percentage of the scroll
            const moodValue = Math.round(scrollPercent * 9) + 1; // Map it to 1-10 range

            const dateOption = document.querySelector('.mood-buttons .active').value; 

            let selectedDate;
            const currentDate = new Date();

            if (dateOption === 'yesterday') {
                currentDate.setDate(currentDate.getDate() - 1); // Go back one day
            } else if (dateOption === 'tomorrow') {
                currentDate.setDate(currentDate.getDate() + 1); // Go forward one day
            }
            selectedDate = currentDate.toISOString().split('T')[0]; // Convert to Y-m-d format
            
            // Use AJAX to send the data to the server without using a form
            const xhr = new XMLHttpRequest();
            xhr.open("POST", "add.php", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    console.log(xhr.responseText); // Handle the response if needed

                    // Redirect to the next step after data is saved in session
                    window.location.href = "fitness-level.php";
                }
            };

            // Send the data to PHP (encoded as URL parameters)
            const data = `moodValue=${encodeURIComponent(moodValue)}&selectedDate=${encodeURIComponent(selectedDate)}`;
            xhr.send(data);
        });

    </script>
</body>
</html>
