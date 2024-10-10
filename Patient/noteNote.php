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


$selectedDate = isset($_SESSION['selectedDate']) ? $_SESSION['selectedDate'] : date('Y-m-d');
$currentTime = date('H:i');

$moodValue = isset($_SESSION['moodValue']) ? $_SESSION['moodValue'] : null;

// Determine the image source based on mood value
$imageSrc = 'images/Solid emotion neutral.png'; // Default image

if ($moodValue !== null) {
    if ($moodValue <= 2) {
        $imageSrc = 'images/Solid emotion depressed.png'; // Mood 1-2
    } elseif ($moodValue >= 3 && $moodValue <= 4) {
        $imageSrc = 'images/Solid emotion sad.png';  // Mood 3-4
    } elseif ($moodValue >= 5 && $moodValue <= 6) {
        $imageSrc = 'images/Solid emotion neutral.png';  // Mood 5-6
    } elseif ($moodValue >= 7 && $moodValue <= 8) {
        $imageSrc = 'images/Solid emotion happy.png';    // Mood 7-8
    } elseif ($moodValue >= 9) {
        $imageSrc = 'images/Solid emotion overjoyed.png'; // Mood 9-10
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
    <style>
        .modal {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1000; /* Sit on top */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: rgb(0,0,0); /* Fallback color */
            background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
        }

        .modal-content {
            background-color: #fefefe;
            margin: 15% auto; /* 15% from the top and centered */
            padding: 20px;
            border: 1px solid #888;
            width: 80%; /* Could be more or less, depending on screen size */
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
    </style>
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
        <div method="POST" action="">
            <div class="card">
                <!-- Icon and Date Section -->
                <div class="note-header">
                    <img src="<?php echo htmlspecialchars($imageSrc); ?>" alt="Mood Icon" class="icon">
                    <div class="date-time">
                        <p class="date"><?php echo htmlspecialchars($selectedDate); ?></p>
                        <p class="time"><?php echo htmlspecialchars($currentTime); ?></p>
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
                    <textarea id="text-input"  oninput="updateWordCount()" name="note_text" maxlength="250" rows="4" placeholder="record you daily"></textarea>
                    <p class="char-counter" id="char-counter">0/250</p>
                </div>

                <!-- Footer Section -->
                <div class="footer">
                <form id="upload-form" style="display: none;">
                    <input type="file" id="voice-upload" name="voice" accept="audio/*">
                    <input type="file" id="camera-upload" name="camera" accept="image/*">
                    <input type="submit" id="submit-upload">
                </form>

                    <button class="voice-btn" id="voice-btn">
                        <img src="images/microphone-icon.png" alt="Voice">
                        Add Voice
                    </button>
                    <button class="camera-btn" id="camera-btn">
                        <img src="images/camera-icon.png" alt="Camera">
                    </button>
                </div>
            </div>
            <button type="submit" class="continue-btn">Continue +</button>
        </div>

        <div id="uploadModal" class="modal">
            <div class="modal-content">
                <span class="close">&times;</span>
                <p id="modal-message"></p>
            </div>
        </div>
    </div>

    <script>
        function updateWordCount() {
            const textInput = document.getElementById('text-input');
            const charCounter = document.getElementById('char-counter');
            const charCount = textInput.value.length;
            const maxLength = textInput.maxLength;
            
            charCounter.textContent = `${charCount}/${maxLength}`;
        }
    </script>

<script>

    let voice = '';
    let img = '';

function showModal(message) {
    const modal = document.getElementById("uploadModal");
    const modalMessage = document.getElementById("modal-message");

    // Update the message and display the modal
    modalMessage.textContent = message;
    modal.style.display = "block";

    // Close the modal when the user clicks the "x" button
    const closeBtn = document.getElementsByClassName("close")[0];
    closeBtn.onclick = function() {
        modal.style.display = "none";
    };

    // Close the modal when the user clicks anywhere outside of it
    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    };
}

    function uploadFile(fileInputId) {
        const fileInput = document.getElementById(fileInputId);
        const formData = new FormData();
        formData.append(fileInput.name, fileInput.files[0]);

        // Perform the AJAX request
        fetch('requests/upload.php', {
            method: 'POST',
            body: formData
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                showModal('File uploaded successfully!');

                if (fileInputId === 'voice-upload') {
                    voice =  data.filePath;
                } else {
                    img =  data.filePath;
                }
            } else {
                console.error('Error uploading file:', data.error);
            }
        })
        .catch(error => console.error('Error:', error));
    }

    // Trigger the file upload for voice (audio)
    document.getElementById('voice-btn').addEventListener('click', function() {
        document.getElementById('voice-upload').click();
    });

    // Trigger the file upload for camera (image)
    document.getElementById('camera-btn').addEventListener('click', function() {
        document.getElementById('camera-upload').click();
    });

    // Submit form after selecting a voice file (using AJAX)
    document.getElementById('voice-upload').addEventListener('change', function() {
        if (this.files.length > 0) {
            uploadFile('voice-upload'); // Use AJAX to upload the voice file
        }
    });

    // Submit form after selecting a camera file (using AJAX)
    document.getElementById('camera-upload').addEventListener('change', function() {
        if (this.files.length > 0) {
            uploadFile('camera-upload'); // Use AJAX to upload the camera file
        }
    });


    document.querySelector('.continue-btn').addEventListener('click', function () {
    // Get the mood, sleep, and fitness values from session storage or inputs


    const notes = document.getElementById('text-input').value;

    if (!notes) {
        alert('input your dairy first.');
        return
    }
    const moodValue = "<?php echo isset($_SESSION['moodValue']) ? htmlspecialchars($_SESSION['moodValue']) : ''; ?>";
    const selectedDate = "<?php echo isset($_SESSION['selectedDate']) ? htmlspecialchars($_SESSION['selectedDate']) : ''; ?>";
    const fitnessLevel = "<?php echo isset($_SESSION['fitness_level']) ? htmlspecialchars($_SESSION['fitness_level']) : ''; ?>";
    const sleepLevel = "<?php echo isset($_SESSION['sleep_level']) ? htmlspecialchars($_SESSION['sleep_level']) : ''; ?>";
    const dietLevel = "<?php echo isset($_SESSION['diet_level']) ? htmlspecialchars($_SESSION['diet_level']) : ''; ?>";
    
    const location = document.getElementById('location').value || "Flinders University Bedford Park campus"; // Default location
    const v = voice;
    const picture = img;

    // Level conversion (for fitness and sleep)
    const fitnessLevels = {
        "Level 1": 1,
        "Level 2": 3,
        "Level 3": 6,
        "Level 4": 9,
        "Level 5": 12
    };

    const fitnessValue = fitnessLevels[fitnessLevel];
    const sleepValue = fitnessLevels[sleepLevel];

    console.log(fitnessValue);
    console.log(sleepValue);

    // Prepare the data to be submitted
    const data = {
        mood: moodValue,
        selectedDate: selectedDate,
        fitness: fitnessValue,
        sleep: sleepValue,
        notes: notes,
        voice: v,
        location: location,
        picture: picture,
        dietLevel: dietLevel
    };

    // Perform the AJAX request
    fetch('requests/insertRecord.php', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(data)
    })
    .then(response => response.json())
    .then(result => {
        if (result.success) {
            showModal('Dairy published successfully!');
            window.location.href = 'home.php';
        } else {
            alert('Error adding record: ' + result.error);
        }
    })
    .catch(error => console.error('Error:', error));
});

</script>

</body>
</html>
