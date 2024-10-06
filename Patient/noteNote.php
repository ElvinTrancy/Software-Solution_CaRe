<?php
// Start session
session_start();

// Include the database connection
include 'inc/dbconn.inc.php';

// Check if the form was submitted
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $location = $_POST['location'] ?? '';
    $note_text = $_POST['note_text'] ?? '';
    
    // Validate input
    if (empty($note_text)) {
        $error_message = "Please enter a note.";
    } else {
        // Insert the note into the database
        $sql = "INSERT INTO mood_notes (user_id, location, note_text, created_at) VALUES (?, ?, ?, NOW())";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param('iss', $_SESSION['user_id'], $location, $note_text);
        $stmt->execute();

        // Redirect to profile or another page
        header("Location: profile.php");
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
    <link rel="stylesheet" href="Styles/noteNote.css">
</head>
<body>

    <div class="mood-select">
        <div class="header">
            <button class="back-btn">
                <a href="diet-level.php">
                    <img src="images/back-icon.png" alt="Back">
                </a>
            </button>
            <img src="images/Progress Bar.png" alt="Progress Bar" style="height: 8px;">
            <a href="home.php">
                <button>Close</button>
            </a>
        </div>
        
        <!-- Form for adding a note -->
        <form method="POST" action="">
            <div class="card">
                <!-- Icon and Date Section -->
                <div class="note-header">
                    <img src="images/Solid emotion neutral.png" alt="Mood Icon" class="icon">
                    <div class="date-time">
                        <p class="date">20.08.2024</p>
                        <p class="time">12:20</p>
                    </div>
                </div>

                <!-- Location Section -->
                <div class="location-section">
                    <label for="location">Location</label>
                    <div class="location-input">
                        <input type="text" id="location" name="location" value="Flinders University" readonly>
                        <button class="location-btn">
                            <img src="images/location-icon.png" alt="Location">
                        </button>
                    </div>
                </div>

                <!-- Text Input Section -->
                <div class="input-section">
                    <textarea id="text-input" name="note_text" maxlength="250" rows="4">I haven’t been eating well lately, and I don't know why...</textarea>
                    <p class="char-counter">100/250</p>
                </div>

                <!-- Footer Section -->
                <div class="footer">
                    <button class="voice-btn">
                        <img src="images/microphone-icon.png" alt="Voice">
                        Add Voice
                    </button>
                    <button class="camera-btn">
                        <img src="images/camera-icon.png" alt="Camera">
                    </button>
                </div>
            </div>
            <button type="submit" class="continue-btn">Continue +</button>
        </form>
    </div>

</body>
</html>
