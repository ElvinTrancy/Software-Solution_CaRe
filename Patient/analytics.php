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

// Prepare the SQL queries
$weekSql = "SELECT * FROM patientdailyrecords WHERE patient_id = ? AND record_date >= CURDATE() - INTERVAL 7 DAY";
$monthSql = "SELECT * FROM patientdailyrecords WHERE patient_id = ? AND record_date >= CURDATE() - INTERVAL 30 DAY";
$sixtyDaySql = "SELECT * FROM patientdailyrecords WHERE patient_id = ? AND record_date >= CURDATE() - INTERVAL 60 DAY";

// Execute query for last week
$stmt = $conn->prepare($weekSql);
$stmt->bind_param('i', $patient_id);
$stmt->execute();
$weekData = $stmt->get_result()->fetch_all(MYSQLI_ASSOC);

// Execute query for last 30 days
$stmt = $conn->prepare($monthSql);
$stmt->bind_param('i', $patient_id);
$stmt->execute();
$monthData = $stmt->get_result()->fetch_all(MYSQLI_ASSOC);

// Execute query for last 60 days
$stmt = $conn->prepare($sixtyDaySql);
$stmt->bind_param('i', $patient_id);
$stmt->execute();
$sixtyDayData = $stmt->get_result()->fetch_all(MYSQLI_ASSOC);

$stmt->close();

?>



<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <link rel="stylesheet" href="Styles/Basical.css">
    <link rel="stylesheet" href="Styles/DataVis.css">
    <link rel="stylesheet" href="Styles/NagBar.css">
    <link rel="stylesheet" href="Styles/Select.css">
    <style>
        #calendar {
            display: grid;
            grid-template-columns: repeat(7, 1fr);
            grid-gap: 5px;
            width: 100%;
            text-decoration: none !important;
        }

        #calendar div {
            width: 40px;
            height: 40px;
            background-color: #0056ff;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
            text-decoration: none !important;
        }

        #calendar div.empty {
            background-color: transparent;
            text-decoration: none !important;
        }

        #calendar div.header {
            background-color: white;
            color: black;
            font-weight: bold;
            text-decoration: none !important;
        }
    </style>

    <script src="JS/script.js"></script>

</head>

<body>
    <div class="container">
        <!-- Select time -->
        <div class="card">
            <button class="dropbtn" id="dropdownButton">
                LAST 7 DAYS
                <span class="arrow">&#9660;</span>
            </button>
            <div class="dropdown-content" id="dropdownContent">
                <a href="#" class="dropdown-item" data-value="LAST 7 DAYS">LAST 7 DAYS</a>
                <a href="#" class="dropdown-item" data-value="LAST 30 DAYS">LAST 30 DAYS</a>
                <a href="#" class="dropdown-item" data-value="LAST 60 DAYS">LAST 60 DAYS</a>
            </div>
        </div>

        <!-- Mood Record -->
        <div class="card">
            <h2>Mood Record</h2>
            <h4>August 2024</h4>
            <div class="card-content">
                <div id="calendar"></div>
            </div>
        </div>

        <!-- Mood Distribution -->
        <div class="container">
            <div class="card mood">
                <h2>Mood Distribution</h2>
                <div class="icons">
                    <div class="icon-item">
                        <div class="icon-content">
                            <img src="images/emotion-happy.png" alt="Happy face">
                            <div class="text-content">
                                <p>Optimism</p>
                                <p>90%</p>
                            </div>
                        </div>
                    </div>
                    <div class="icon-item">
                        <div class="icon-content">
                            <img src="images/emotion-neutral.png" alt="Neutral face">
                            <div class="text-content">
                                <p>Pessimism</p>
                                <p>10%</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!--Daily Mood Distribution -->
            <div class="card mood">
                <h2>Daily Mood Distribution</h2>
                <div class="card-content">
                    <img src="images/mood-weekly-distribution.png" alt="Sleep Mode">
                </div>
            </div>
        </div>
        <!-- Navigation Bar -->
        <div>
            <div class="nav-bar">
                <button>
                    <a href="home.html">
                        <img src="images/home-icon.png" alt="Home">
                    </a>
                </button>
                <button>
                    <a href="analytics.html">
                        <img src="images/analytics-icon.png" alt="Analytics">
                    </a>
                </button>
                <div class="center-btn">
                    <button>
                         <a href="add.html">
                            <img src="images/add-icon.png" alt="Add">
                        </a>
                    </button>
                </div>
                <button>
                    <a href="services.html">
                        <img src="images/services-icon.png" alt="Services">
                    </a>
                </button>
                <button>
                    <a href="profile.html">
                        <img src="images/profile-icon.png" alt="Profile">
                    </a>
                </button>
            </div>
        </div>

    <script>

        const weekData = <?php echo json_encode($weekData); ?>;
        const monthData = <?php echo json_encode($monthData); ?>;
        const sixtyDayData = <?php echo json_encode($sixtyDayData); ?>;

        document.querySelectorAll('.dropdown-item').forEach(item => {
            item.addEventListener('click', function(event) {
                event.preventDefault();
                const selectedValue = this.getAttribute('data-value');

                // Update the button text with the selected value
                document.getElementById('dropdownButton').textContent = selectedValue;

                // Repaint the calendar based on the selected time range
                if (selectedValue === 'LAST 7 DAYS') {
                    createCalendar(weekData);
                } else if (selectedValue === 'LAST 30 DAYS') {
                    createCalendar(monthData);
                } else if (selectedValue === 'LAST 60 DAYS') {
                    createCalendar(sixtyDayData);
                }
            });
        });


        function createCalendar(data) {
            const currentDate = new Date();
            const year = currentDate.getFullYear();
            const month = currentDate.getMonth() + 1; 
            const calendarContainer = document.getElementById('calendar');
            calendarContainer.innerHTML = ''; // Clear previous content

            const daysOfWeek = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
            const firstDay = new Date(year, month - 1, 1).getDay(); // Day of week for the 1st of the month
            const daysInMonth = new Date(year, month, 0).getDate(); // Total days in the month

            // Create a map of the dates and corresponding mood data
            const moodMap = new Map();
            data.forEach(item => {
                const date = new Date(item.record_date);
                const day = date.getDate();
                moodMap.set(day, item.mood);
            });

            // Add the day headers
            daysOfWeek.forEach(day => {
                const headerDiv = document.createElement('div');
                headerDiv.textContent = day;
                headerDiv.classList.add('header');
                calendarContainer.appendChild(headerDiv);
            });

            // Adjust first day (Sunday as 0 in JavaScript)
            const offset = firstDay === 0 ? 6 : firstDay - 1;

            // Create empty boxes for days before the 1st
            for (let i = 0; i < offset; i++) {
                const emptyDiv = document.createElement('div');
                emptyDiv.classList.add('empty');
                calendarContainer.appendChild(emptyDiv);
            }

            // Create boxes for each day of the month
            for (let day = 1; day <= daysInMonth; day++) {
                const dayDiv = document.createElement('div');

                // Check if this day exists in the moodMap
                if (moodMap.has(day)) {
                    const mood = moodMap.get(day);
                    const img = document.createElement('img');
                    if (mood >= 5) {
                        img.src = "images/emotion-happy.png";
                        img.alt = "Happy face";
                    } else {
                        img.src = "images/emotion-neutral.png";
                        img.alt = "Neutral face";
                    }
                    dayDiv.appendChild(img); // Add the image to the dayDiv
                } else {
                    //dayDiv.textContent = day; // No mood data, display the day number
                }

                calendarContainer.appendChild(dayDiv);
            }
        }

        createCalendar(weekData);
    </script>

</body>

</html>