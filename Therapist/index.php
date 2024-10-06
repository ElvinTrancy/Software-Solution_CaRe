<?php
session_start();
require_once 'inc/dbconn.inc.php'; // Include database connection
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Therapist Dashboard</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600&display=swap">
    <link rel="stylesheet" href="css/index.css">
    <script src="components/icon/index.js"></script>
</head>
<body>
    <div class="dashboard">
        <!-- Sidebar -->
        <?php require_once 'inc/side.inc.php'; ?>  <!-- Load Sidebar -->

        <!-- Main Content -->
        <div class="main-content">
            <div class="welcome-doc">
                <div class="assembled-images">
                    <img src="assets/shine.png" alt="Light Ray" class="light-ray">
                    <img src="assets/light.png" alt="Top Light" class="top-light">
                    <img src="assets/doc.png" alt="Doctor" class="doctor">
                </div>
                
                <?php
                // Fetch the logged-in therapist's name from the database using session
                $therapist_id = $_SESSION['therapist_id'] ?? null; // Assuming you set the session during login
                if ($therapist_id === null) {
                    // Redirect to the login page if therapist_id is null
                    header("Location: login.php"); // Replace with the correct path to your login page
                    exit(); // Ensure the script stops execution after the redirect
                }
                
                $therapist_name = "Therapist"; // Default name

                if ($therapist_id) {
                    $sql = "SELECT name FROM Therapists WHERE id = ?";
                    $stmt = $conn->prepare($sql);
                    $stmt->bind_param('i', $therapist_id);
                    $stmt->execute();
                    $result = $stmt->get_result();
                    if ($row = $result->fetch_assoc()) {
                        $therapist_name = $row['name'];
                    }
                    $stmt->close();
                }
                ?>
                
                <div class="greeting">
                    <span>🌞</span>
                    <h1>Hello,</h1>
                    <h1><?php echo htmlspecialchars($therapist_name); ?>!</h1> <!-- Display therapist name -->
                </div>
            </div>

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

            <!-- Schedule Reminder and Risk Patient Warning -->
              <div class="schedule-warning">
                  <div class="schedule-reminder">
                    <h2>Schedule Reminder</h2>
                    <?php
                        // Get current date
                        $currentDate = date('l - F j'); // Example: Wednesday - October 5

                        // Fetch appointment data for the current date from the database
                        $therapist_id = $_SESSION['therapist_id'] ?? null; // Assuming session stores therapist ID
                        $appointments = [];

                        if ($therapist_id) {
                            $sql = "SELECT * FROM Appointments WHERE therapist_id = ? AND DATE(appointment_date) = CURDATE() ORDER BY appointment_date";
                            $stmt = $conn->prepare($sql);
                            $stmt->bind_param('i', $therapist_id);
                            $stmt->execute();
                            $result = $stmt->get_result();

                            // Fetch all appointments into an array
                            while ($row = $result->fetch_assoc()) {
                                $appointments[] = $row;
                            }

                            $stmt->close();
                        }
                        ?>
                    <div class="reminder-details">
                        <p><?php echo date('j F Y'); ?></p>
                        <div class="time-block">
                            <div class="time">9 AM</div>
                            <div class="time-line"></div>
                        </div>
                        <div class="time-block">
                            <div class="time">10 AM</div>
                            <div class="time-line"></div>
                        </div>
                        <div class="time-block">
                            <div class="time">11 AM</div>
                            <div class="time-line"></div>
                        </div>
                        <div class="time-block">
                            <div class="time">12 AM</div>
                            <div class="time-line"></div>
                        </div>
                        <div class="time-block">
                          <div class="time">1 PM</div>
                          <div class="time-line"></div>
                        </div>
                        <div class="time-block">
                          <div class="time">2 PM</div>
                          <div class="time-line"></div>
                        </div>
                        <div class="time-block">
                          <div class="time">3 PM</div>
                          <div class="time-line"></div>
                        </div>
                        <div class="time-block">
                          <div class="time">4 PM</div>
                          <div class="time-line"></div>
                        </div>
                        <div class="time-block">
                          <div class="time">5 PM</div>
                          <div class="time-line"></div>
                        </div>
                        <?php foreach ($appointments as $appointment): ?>
                          <div class="reminder" style="cursor: pointer;" onclick="window.location.href = 'calendar.php'">
                              <p><?php echo htmlspecialchars($therapist_name); ?></p>
                              <span><?php echo htmlspecialchars($appointment['appointment_type']); ?> - <?php echo htmlspecialchars($appointment['location']); ?></span>
                              <div class="actions">
                                  <div class="btn-container">
                                      <button class="circle-btn">
                                          <svg class="icon" aria-hidden="true">
                                              <use xlink:href="#icon-mobile-check"></use>
                                          </svg>
                                      </button>
                                      <button class="circle-btn">
                                          <svg class="icon" aria-hidden="true">
                                              <use xlink:href="#icon-mobile-cross"></use>
                                          </svg>
                                      </button>
                                  </div>
                              </div>
                          </div>
                      <?php endforeach; ?>
                    </div>
                  </div>
                  <div class="risk-patient-warning">
                      <h2>Risk Patient Warning</h2>
                      <?php
                        // Fetch daily records for patients
                        $sql = "
                        SELECT p.name AS patient_name, p.photo AS patient_photo, r.mood, r.diet, r.notes
                        FROM Patients p
                        JOIN PatientDailyRecords r ON p.id = r.patient_id
                        WHERE r.record_date = CURDATE()
                        ";
                        $result = $conn->query($sql);
                        $patientRecords = $result->fetch_all(MYSQLI_ASSOC);
                        ?>
                      <div class="patient-cards">
                        <?php foreach ($patientRecords as $record): ?>
                            <div class="patient-card">
                                <img src="./<?php echo htmlspecialchars($record['patient_photo']); ?>" alt="<?php echo htmlspecialchars($record['patient_name']); ?>" class="patient-photo">
                                <p class="patient-name"><?php echo htmlspecialchars($record['patient_name']); ?></p>
                                <p class="patient-msg"><?php echo htmlspecialchars($record['notes']); ?></p>
                                <button class="contact-btn">Contact</button>
                            </div>
                        <?php endforeach; ?>
                    </div>
                  </div>
              </div>

              <!-- Summary and Patient Group -->
              <div class="summary-group">
                  <div class="patient-summary">
                      <h2>Summary of Patient Data</h2>
                      <?php
                        function getPatientCount($range) {
                            global $conn;

                            // Prepare SQL query based on the time range
                            switch ($range) {
                                case '1 Day':
                                    $sql = "SELECT COUNT(*) AS patient_count FROM Patients WHERE register_at >= DATE_SUB(NOW(), INTERVAL 1 DAY)";
                                    break;
                                case '1 Week':
                                    $sql = "SELECT COUNT(*) AS patient_count FROM Patients WHERE register_at >= DATE_SUB(NOW(), INTERVAL 1 WEEK)";
                                    break;
                                case '1 Month':
                                    $sql = "SELECT COUNT(*) AS patient_count FROM Patients WHERE register_at >= DATE_SUB(NOW(), INTERVAL 1 MONTH)";
                                    break;
                                case '1 Year':
                                    $sql = "SELECT COUNT(*) AS patient_count FROM Patients WHERE register_at >= DATE_SUB(NOW(), INTERVAL 1 YEAR)";
                                    break;
                                case 'All':
                                default:
                                    $sql = "SELECT COUNT(*) AS patient_count FROM Patients";
                                    break;
                            }

                            // Execute the query
                            $result = $conn->query($sql);
                            $count = 0;
                            if ($result && $row = $result->fetch_assoc()) {
                                $count = $row['patient_count'];
                            }
                            
                            return $count;
                        }

                        // Default to '1 Day' if no range is set
                        $range = $_GET['range'] ?? '1 Week';
                        $patientCount = getPatientCount($range);
                        ?>
                      <div class="patient-data">
                        <div class="new-patients">
                            <p class="patient-count" id="patient-count"><?php echo $patientCount; ?></p>
                            <p class="card-name">New Patients</p>
                            <span class="patient-flag">NORMAL</span>
                        </div>

                        <div class="chart">
                            <canvas class="chart-content" style="display: block;" id="lineChart">
                            </canvas>
                            <div class="chart-bar">
                                <!-- <div  onclick="updatePatientCount('1 Day')">1 Day</div> -->
                                <div class="active" onclick="updatePatientCount('1 Week')">1 Week</div>
                                <div onclick="updatePatientCount('1 Month')">1 Month</div>
                                <div onclick="updatePatientCount('1 Year')">1 Year</div>
                                <div onclick="updatePatientCount('All')">All</div>
                            </div>
                        </div>
                        </div>
                  </div>
                  <div class="patient-group">
                      <h2>Patient Group</h2>
                      <div class="group-container">
                        <div class="group-search">
                          <div class="alphabet-pagination" id="alphabet-pagination"></div>
                          <?php
                                // Fetch top 2 group info with real meeting time from database
                                $sql = "
                                SELECT g.name AS group_name, g.leader AS group_leader, g.number_of_members, g.assigned_patients, g.creation_date, g.status, g.head_img, 
                                    gm.meeting_date, gm.meeting_time, gm.theme, gm.mode
                                FROM Groups g
                                LEFT JOIN GroupMeetings gm ON g.id = gm.group_id
                                WHERE g.status = 'Active'
                                LIMIT 2";  // Limit to top 2 records

                                $result = $conn->query($sql);
                                $groupRecords = $result->fetch_all(MYSQLI_ASSOC);
                            ?>
                        <?php foreach ($groupRecords as $group): ?>
                            <div class="group-card">
                                <div class="group-info">
                                    <h3>Group: <?php echo htmlspecialchars($group['group_name']); ?><br><span>Leader: <?php echo htmlspecialchars($group['group_leader']); ?></span></h3>
                                    <p>Group Members: <?php echo htmlspecialchars($group['number_of_members']); ?> / Assigned Patients: <?php echo htmlspecialchars($group['assigned_patients']); ?></p>
                                    <div class="group-details">
                                        <div class="group-date">
                                            <svg class="icon" aria-hidden="true">
                                                <use xlink:href="#icon-calendar"></use>
                                            </svg>
                                            <span><?php echo date('jS F Y', strtotime($group['meeting_date'])); ?></span>
                                        </div>
                                        <div class="group-time">
                                            <svg class="icon" aria-hidden="true">
                                                <use xlink:href="#icon-clock"></use>
                                            </svg>
                                            <span><?php echo date('g:i A', strtotime($group['meeting_time'])); ?></span>
                                        </div>
                                        <div class="group-theme">
                                            <p>Theme: <?php echo htmlspecialchars($group['theme']); ?> (<?php echo htmlspecialchars($group['mode']); ?>)</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="group-options">
                                    <svg class="icon" aria-hidden="true">
                                        <use xlink:href="#icon-menu"></use>
                                    </svg>
                                </div>
                            </div>
                        <?php endforeach; ?>
                        </div>
                        
                      

                        <div onclick="window.location.href = 'group.html'" class="group-see-all">See All →</div>
                      </div>
                  </div>
              </div>
            </div>
            </div>
        </div>
    </div>
    <script src="js/nav_php.js"></script>
    <script>
    function updatePatientCount(range) {
        // Fetch the patient data from the server
        fetch('requests/getPatient.php', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: 'range=' + encodeURIComponent(range)
        })
        .then(response => response.json())
        .then(data => {
            // Extract the day data and total count from the response
            const days = data.day_data.map(entry => entry.day);
            const counts = data.day_data.map(entry => entry.patient_count);

            console.log(days, counts)
            const totalCount = data.total_count;

            drawChart(days, counts);

            // Update the patient count in the UI
            document.getElementById('patient-count').textContent = totalCount;

            // Draw the line chart with the new data
            //drawLineChart(days, counts);

            // Highlight the selected time range
            document.querySelectorAll('.chart-bar div').forEach(el => el.classList.remove('active'));
            document.querySelector(`div[onclick="updatePatientCount('${range}')"]`).classList.add('active');
        })
        .catch(error => console.error('Error:', error));
    }

    function drawChart(days, counts) {
        const canvas = document.getElementById('lineChart');
        const ctx = canvas.getContext('2d');

        // Clear the canvas before each redraw
        ctx.clearRect(0, 0, canvas.width, canvas.height);

        const chartHeight = canvas.height - 50;
        const chartWidth = canvas.width - 50;
        const padding = 30;
        const yMax = 10; // Max value for Y-axis (assuming counts are between 1-10)
        const xMax = days.length; // Max value for X-axis based on days array length

        // Function to scale Y values to fit the canvas
        const scaleY = (val) => (chartHeight - padding * 2) * (val / yMax);

        // Function to scale X values to fit the canvas
        const scaleX = (index) => (chartWidth ) * (index / (xMax - 1)) + padding;

        // Draw the X and Y axes
        function drawAxes() {
            ctx.beginPath();
            ctx.moveTo(padding, padding); // Y-axis
            ctx.lineTo(padding, chartHeight);
            ctx.lineTo(chartWidth, chartHeight); // X-axis
            ctx.strokeStyle = '#000';
            ctx.stroke();
        }

        // Draw the X-axis labels
        // function drawXLabels() {
        //     ctx.font = "12px Arial";
        //     ctx.fillStyle = "rgba(75, 192, 192, 1)";
        //     ctx.textAlign = "center";

        //     days.forEach((day, index) => {
        //         const x = scaleX(index);
        //         const label = `Day ${day}`;
        //         ctx.fillText(label, x, chartHeight + 15); // Place label just below the X-axis
        //     });
        // }

        // Draw the line chart based on the data
        function drawLineChart() {
            ctx.beginPath();
            ctx.strokeStyle = '#00f'; // Line color

            counts.forEach((count, index) => {
                const x = scaleX(index);
                const y = chartHeight - scaleY(count);

                if (index === 0) {
                    ctx.moveTo(x, y);
                } else {
                    ctx.lineTo(x, y);
                }
            });

            ctx.stroke();
        }

        // Draw the points on the line
        function drawPoints() {
            counts.forEach((count, index) => {
                const x = scaleX(index);
                const y = chartHeight - scaleY(count);

                ctx.beginPath();
                ctx.arc(x, y, 5, 0, 2 * Math.PI); // Draw circle for the point
                ctx.fillStyle = 'rgba(75, 192, 192, 1)';
                ctx.fill();
                ctx.stroke();
            });
        }

        // Draw everything
        // drawAxes();
        drawLineChart();
        drawPoints();
        // drawXLabels(); // Add the labels for X-axis
    }

    // Function to draw the line chart using Chart.js
    function drawLineChart(labels, data) {
        const ctx = document.getElementById('patientLineChart').getContext('2d');

        // If the chart already exists, destroy it before creating a new one
        if (window.patientChart) {
            window.patientChart.destroy();
        }

        window.patientChart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: labels, // Days
                datasets: [{
                    label: 'Patient Registrations',
                    data: data, // Counts per day
                    borderColor: 'rgba(75, 192, 192, 1)',
                    backgroundColor: 'rgba(75, 192, 192, 0.2)',
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    x: {
                        title: {
                            display: true,
                            text: 'Date'
                        }
                    },
                    y: {
                        beginAtZero: true,
                        title: {
                            display: true,
                            text: 'Patient Count'
                        }
                    }
                }
            }
        });
    }

    // Initial load for '1 Day'
    updatePatientCount('1 Week');
</script>

</body>
</html>
