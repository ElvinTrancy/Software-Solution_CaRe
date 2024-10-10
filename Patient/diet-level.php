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

if (isset($_SESSION['moodValue']) && isset($_SESSION['selectedDate']) && isset($_SESSION['selectedDate']) && isset($_SESSION['sleep_level'])) {
    
} else {
    header("Location: add.php"); 
}

// Check if the form was submitted
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $diet_level = $_POST['dietLevel'] ?? '';

    if (isset($diet_level)) {
        
        $_SESSION['diet_level'] = $diet_level;

        // Return a success message to JavaScript
        header("Location: noteNote.php"); 
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
    <title>Diet Level</title>
    <link rel="stylesheet" href="Styles/Basical.css">
    <link rel="stylesheet" href="Styles/DietNote.css">
    <link rel="stylesheet" href="Styles/Select.css">
    <style>
        .selected_diet {
            border: 2px solid #0F67FE; /* Add a blue border to the selected image */
            border-radius: 10px; /* Slightly round the corners */
            box-shadow: 0px 0px 15px rgba(15, 103, 254, 0.7); /* Add a glow effect */
            transform: scale(1.1); /* Scale up the selected image slightly */
            transition: all 0.2s ease-in-out; /* Smooth transition for scaling */
        }
    </style>
</head>
<body>
    <div class="mood-select">
        <div class="header">
            <button class="back-btn">
                <a href="sleep-level.php"><img src="images/back-icon.png" alt="Back"></a>
            </button>
            <img src="images/Progress Bar.png" alt="Progress Bar" style="height: 8px;">
            <a href="home.php"><button>Close</button></a>
        </div>

        <!-- Diet form -->
        <form method="POST" action="">
            <div class="mood-buttons">
                <button type="submit" name="diet" value="A">A</button>
                <button type="submit" name="diet" value="B">B</button>
                <button type="submit" name="diet" value="C" class="active">C</button>
                <button type="submit" name="diet" value="..">..</button>
                <button type="submit" name="diet" value="Y">Y</button>
                <button type="submit" name="diet" value="Z">Z</button>
                <button type="submit" name="diet" value="search">🔍</button>
            </div>

            <div class="card">
                <div class="scroll-container" id="scroll-container">
                    <img src="images/diet1.png" alt="diet 1">
                    <img src="images/diet2.png" alt="diet 2">
                    <img src="images/diet3.png" alt="diet 3">
                    <img src="images/diet4.png" alt="diet 4">
                    <img src="images/diet5.png" alt="diet 5">
                    <img src="images/diet6.png" alt="diet 6">
                    <img src="images/diet1.png" alt="diet 1">
                    <img src="images/diet2.png" alt="diet 2">
                    <img src="images/diet3.png" alt="diet 3">
                    <img src="images/diet4.png" alt="diet 4">
                    <img src="images/diet5.png" alt="diet 5">
                    <img src="images/diet6.png" alt="diet 6">
                    <img src="images/diet1.png" alt="diet 1">
                    <img src="images/diet2.png" alt="diet 2">
                    <img src="images/diet3.png" alt="diet 3">
                    <img src="images/diet4.png" alt="diet 4">
                    <img src="images/diet5.png" alt="diet 5">
                    <img src="images/diet6.png" alt="diet 6">
                    <img src="images/diet1.png" alt="diet 1">
                    <img src="images/diet2.png" alt="diet 2">
                    <img src="images/diet3.png" alt="diet 3">
                    <img src="images/diet4.png" alt="diet 4">
                    <img src="images/diet5.png" alt="diet 5">
                    <img src="images/diet6.png" alt="diet 6">
                    <img src="images/diet1.png" alt="diet 1">
                    <img src="images/diet2.png" alt="diet 2">
                    <img src="images/diet3.png" alt="diet 3">
                    <img src="images/diet4.png" alt="diet 4">
                    <img src="images/diet5.png" alt="diet 5">
                    <img src="images/diet6.png" alt="diet 6">
                    <img src="images/diet1.png" alt="diet 1">
                    <img src="images/diet2.png" alt="diet 2">
                    <img src="images/diet3.png" alt="diet 3">
                    <img src="images/diet4.png" alt="diet 4">
                    <img src="images/diet5.png" alt="diet 5">
                    <img src="images/diet6.png" alt="diet 6">
                    <img src="images/diet1.png" alt="diet 1">
                    <img src="images/diet2.png" alt="diet 2">
                    <img src="images/diet3.png" alt="diet 3">
                    <img src="images/diet4.png" alt="diet 4">
                    <img src="images/diet5.png" alt="diet 5">
                    <img src="images/diet6.png" alt="diet 6">
                    <img src="images/diet1.png" alt="diet 1">
                    <img src="images/diet2.png" alt="diet 2">
                    <img src="images/diet3.png" alt="diet 3">
                    <img src="images/diet4.png" alt="diet 4">
                    <img src="images/diet5.png" alt="diet 5">
                    <img src="images/diet6.png" alt="diet 6">
                </div>
                <h2 id="percentage-display">Junk</h2>
            </div>

            <button type="submit" class="continue-btn">Continue +</button>
        </form>
    </div>

    <script src="JS/dietnote.js"></script>

    <script>
        let selectedDiet = '0';
        document.querySelectorAll('#scroll-container img').forEach((img) => {
            img.addEventListener('click', function() {
                // Remove the 'selected_diet' class from any previously selected image
                document.querySelectorAll('#scroll-container img').forEach((i) => {
                    i.classList.remove('selected_diet');
                });
                
                // Add the 'selected_diet' class to the clicked image
                this.classList.add('selected_diet');
                
                // Get the alt attribute (e.g., 'diet 1') and extract the diet number
                selectedDiet = this.getAttribute('alt').split(' ')[1];
                
                // Store the selected diet number (you can save it to a session, form, or use it directly)
                console.log('Selected diet: ' + selectedDiet);
                // Store this value in a variable or handle it however you want.
            });
        });


        document.querySelector('.continue-btn').addEventListener('click', function() {
            // Use AJAX to send the data to the server without using a form
            const xhr = new XMLHttpRequest();
            xhr.open("POST", "diet-level.php", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {                   
                    window.location.href = "noteNote.php";
                }
            };

            // Send the data to PHP (encoded as URL parameters)
            const data = `dietLevel=${encodeURIComponent(selectedDiet)}`;
            xhr.send(data);
        });
    </script>
</body>
</html>
