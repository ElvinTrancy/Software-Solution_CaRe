<?php
// Start session
session_start();

// Include the database connection
include 'inc/dbconn.inc.php';

// Check if the form was submitted
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $diet_choice = $_POST['diet'] ?? '';

    // Validate input
    if (empty($diet_choice)) {
        $error_message = "Please select a diet option.";
    } else {
        // Insert diet choice into the database
        $sql = "INSERT INTO diet_tracker (user_id, diet_choice, created_at) VALUES (?, ?, NOW())";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param('is', $_SESSION['user_id'], $diet_choice);
        $stmt->execute();

        // Redirect to the next page
        header("Location: next-step.php");
        exit;
    }
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
                    <!-- Add images or other data dynamically -->
                </div>
                <h2 id="percentage-display">Junk</h2>
            </div>

            <button type="submit" class="continue-btn">Continue +</button>
        </form>
    </div>
</body>
</html>
