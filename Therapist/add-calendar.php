<?php
// Include database connection and sidebar files
include 'inc/dbconn.inc.php';  // Adjust the path if necessary
include 'inc/side.inc.php';    // Adjust the path if necessary

// Start the session if needed
session_start();

// Check if therapist is logged in
if (!isset($_SESSION['therapist_id'])) {
  header('Location: login.php');
  exit;
}

$groupSql = "SELECT g.id, g.name, t.name AS leader_name 
             FROM Groups g
             LEFT JOIN Therapists t ON g.therapist_id = t.id";
$result = $conn->query($groupSql);

if ($result->num_rows > 0) {
    $groups = $result->fetch_all(MYSQLI_ASSOC);
} else {
    $groups = [];
}
?>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Therapist Dashboard</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600&display=swap">
    <link rel="stylesheet" href="css/index.css"> 
    <link rel="stylesheet" href="css/patients.css"> 
    <link rel="stylesheet" href="css/add-group.css">
    <script src="components/icon/index.js"></script>
    <style>
      .notification {
          position: fixed;
          top: 20px;
          right: 20px;
          padding: 15px;
          background-color: #4CAF50; /* Green for success */
          color: white;
          font-size: 16px;
          border-radius: 5px;
          z-index: 1000;
          opacity: 0.9;
      }

      .notification.error {
          background-color: #f44336; /* Red for error */
      }

      .notification.success {
          background-color: #4CAF50; /* Green for success */
      }
      .patient-group {
        flex: 1;
      }

      .group-card {
        margin: .5rem;
      }

      .selectable-icon.selected {
        fill: #007bff; /* Color when selected */
      }

      /* Optional: Add a hover effect */
      .selectable-icon:hover {
        fill: #555; /* Hover state color */
      }

      .confirm-btn.add {
        background-color: #0F67FE;
        margin: .5rem;
      }

      .page-scrum {
        justify-content: start;
        gap: 1rem;
      }
      .go-back {
        cursor: pointer;
      }
      #group-select {
        width: 48%;
        padding: 10px;
        font-size: 16px;
        border: 1px solid #ccc;
        border-radius: 8px;
        background-color: #0F67FE;
        color: white;
      }
    </style>
</head>
<body>
    <div class="dashboard">
        <div class="main-content" style="padding-left: 1rem;">         
          <div class="doc-main">
            <!-- Top bar -->
            <div class="top-bar">
              <div class="search-bar">
                <input type="text" placeholder="Search anything..." />
                <svg class="icon" aria-hidden="true">
                  <use xlink:href="#icon-search"></use>
                </svg>
                <svg class="wifi-icon" aria-hidden="true">
                  <use xlink:href="#icon-wifi"></use>
                </svg>
              </div>
              <button class="icon-btn">
                <svg class="icon" aria-hidden="true">
                  <use xlink:href="#icon-alarm"></use>
                </svg>
              </button>
              <button class="icon-btn">
                <svg class="icon" aria-hidden="true">
                  <use xlink:href="#icon-mail"></use>
                </svg>
              </button>
            </div>
            <div class="main-section">
              <div class="page-scrum">
                <h2 onclick="window.location.href = 'group.php'" class="go-back" id="go-back">Patient Group list   </h2><h2>></h2><h2>Initiating Group Therapy</h2>
              </div>
              <div class="add-group-container">
                <div class="add-group-header">
                <select id="group-select" name="group_id">
                    <option value="">Select a group</option>
                    <?php foreach ($groups as $group): ?>
                        <option value="<?= htmlspecialchars($group['id']) ?>" 
                                data-group-name="<?= htmlspecialchars($group['name']) ?>"
                                data-leader-name="<?= htmlspecialchars($group['leader_name']) ?>">
                            <?= htmlspecialchars($group['name']) ?>
                        </option>
                    <?php endforeach; ?>
                </select>
                    <div class="add-group-actions">
                      <button class="add-group-cancel-btn" onclick="window.location.href = 'group.php'">Cancel</button>
                      <button class="add-group-confirm-btn" >Confirm</button>
                  </div>
                </div>
                <div class="add-group-form-section">
                    <div class="add-group-input-group">
                        <label for="group-name">Group Name:</label>
                        <span id="group-name"></span>
                    </div>
                    <div class="add-group-input-group">
                        <label for="group-study">Group Leader:</label>
                        <span id="group-leader"></span>
                    </div>
                </div>
                <div class="group-editor">                 
                  <div class="meeting-form-container">
                    <label for="group-member"> Initiating Group Therapy:</label>
                    <!-- Online / In-Clinic Switch -->
                    <div class="meeting-mode-switch">
                        <button class="active">Online</button>
                        <button>In-Clinic</button>
                    </div>
            
                    <!-- Meeting Theme Input -->
                    <div class="meeting-theme">
                        <label for="theme">Meeting Theme:</label>
                        <input type="text" id="meeting-theme" placeholder="">
                    </div>
            
                    <!-- Meeting Time -->
                    <div class="meeting-time">
                        <label for="meeting-time">Meeting Time:</label>
                        <div class="time-inputs">
                            <input type="date" id="meeting-date">
                            <input type="time" id="meeting-time">
                        </div>
                    </div>
            
                    <!-- Meeting Reminder Switch -->
                    <div class="meeting-reminder">
                        <label for="reminder">Meeting reminder:</label>
                        <div class="reminder-switch">
                            <button class="active">On</button>
                            <button>Off</button>
                        </div>
                    </div>
            
                    <!-- Meeting Notification Textarea -->
                    <div class="meeting-notification">
                        <label for="notification">Meeting Notification:</label>
                        <textarea id="notification" rows="5" placeholder="I haven’t been eating well lately, and I don’t know why. My right foot also hurts so much, please help me, doc A!"></textarea>
                        <div class="char-count" id="char-count">0/250</div>
                    </div>
                </div>
                </div>
             
            </div>
          </div>
      </div>
    </div>
    <script src="js/nav_php.js"></script>
    <script>

document.addEventListener('DOMContentLoaded', function() {
      const modes = document.querySelectorAll('.meeting-mode-switch button');

      modes.forEach(button => {
          button.addEventListener('click', function() {
              // Remove 'active' class from all buttons
              modes.forEach(btn => btn.classList.remove('active'));

              // Add 'active' class to the clicked button
              this.classList.add('active');
          });
      });

      const reminders = document.querySelectorAll('.reminder-switch button');

      reminders.forEach(button => {
          button.addEventListener('click', function() {
              // Remove 'active' class from all buttons
              reminders.forEach(btn => btn.classList.remove('active'));

              // Add 'active' class to the clicked button
              this.classList.add('active');
          });
      });

      const confirmButton = document.querySelector('.add-group-confirm-btn');

      confirmButton.addEventListener('click', function() {
        // Capture the meeting details (example fields)
        //const groupId = getGroupIdFromUrl();  // Function to retrieve group ID from the URL
        const meetingDate = document.querySelector('#meeting-date').value;
        const meetingTime = document.querySelector('#meeting-time').value;
        const theme = document.querySelector('#meeting-theme').value;
        const mode = document.querySelector('.meeting-mode-switch .active').textContent;
        const notification = document.getElementById('notification').value;
        // Send data to the server using a POST request (AJAX)

        if (!groupId || groupId.trim() === '') {
            showNotification("Select a group first!", true);
            return; // Prevent submission
        }
         // Check if the theme is empty
        if (!theme || theme.trim() === '') {
            showNotification("Theme cannot be empty!", true);
            return; // Prevent submission
        }

        // Check if the meeting date and time are valid
        if (!meetingDate) {
            showNotification("Please select a valid meeting date!", true);
            return;
        }
        
        if (!meetingTime) {
            showNotification("Please select a valid meeting time!", true);
            return;
        }

        // Construct date-time object from meeting date and time
        const currentDateTime = new Date();
        const meetingDateTime = new Date(`${meetingDate}T${meetingTime}`);
        
        // Check if the selected meeting date and time are in the past
        if (isNaN(meetingDateTime.getTime())) {
            showNotification("Invalid meeting date or time!", true);
            return; // Prevent submission
        }
        
        if (meetingDateTime < currentDateTime) {
            showNotification("Meeting date and time cannot be earlier than the current time!", true);
            return; // Prevent submission
        }
        
        fetch('requests/save-meeting.php', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                group_id: groupId,
                meeting_date: meetingDate,
                meeting_time: meetingTime,
                theme: theme,
                mode: mode,
                notification: notification
            }),
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                // Redirect to another page after successful meeting creation
                window.location.href = `group.php?group=${groupId}`;
            } else {
                alert('Error saving the meeting. Please try again.');
            }
        })
        .catch(error => {
            console.error('Error:', error);
        });
    });


    function getGroupIdFromUrl() {
        const urlParams = new URLSearchParams(window.location.search);
        return urlParams.get('group');
    }

    function showNotification(message, isError = false) {
        const notification = document.createElement('div');
        notification.className = `notification ${isError ? 'error' : 'success'}`;
        notification.textContent = message;

        document.body.appendChild(notification);

        // Automatically remove the notification after 3 seconds
        setTimeout(() => {
            notification.remove();
        }, 3000);
    }

    document.getElementById('group-select').addEventListener('change', function() {
        const selectedOption = this.options[this.selectedIndex];

        // Get group name and leader name from data attributes
        const groupName = selectedOption.getAttribute('data-group-name');
        const leaderName = selectedOption.getAttribute('data-leader-name');
        groupId = selectedOption.getAttribute('value');
        console.log(groupId);
        // Update the fields
        document.getElementById('group-name').textContent = groupName;
        document.getElementById('group-leader').textContent = leaderName;
    });
  });
    </script>

</body>
</html>
