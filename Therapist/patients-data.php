<?php
// Include database connection and session check
include 'inc/dbconn.inc.php';
include 'inc/side.inc.php';

session_start();

// Check if therapist is logged in
if (!isset($_SESSION['therapist_id'])) {
  header('Location: login.php');
  exit;
}

$therapist_id = $_SESSION['therapist_id'];

// Fetch patients' data based on the logged-in therapist's groups
$sql = "
    SELECT p.id, p.name, p.photo, r.notes
    FROM Patients p
    JOIN PatientDailyRecords r ON p.id = r.patient_id
    JOIN GroupPatient gp ON gp.patient_id = p.id
    JOIN Groups g ON g.id = gp.group_id
    WHERE g.therapist_id = ? 
    ORDER BY r.record_date DESC
    LIMIT 3"; // Limiting to 3 records for simplicity
$stmt = $conn->prepare($sql);
$stmt->bind_param('i', $therapist_id); // Bind the therapist ID
$stmt->execute();
$patients = $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Therapist Dashboard</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600&display=swap">
    <link rel="stylesheet" href="css/index.css"> 
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="components/icon/index.js"></script>
</head>
<body>
    <div class="dashboard">
        <div class="main-content" style="padding-left: 1rem;">
            <div class="doc-main">
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
                        <h2>DashBoard > Summary of Patient Data</h2>
                        <button>Export Data</button>
                    </div>

                    <div class="summary-group data" style="margin-top: 1rem;">
                        <div class="patient-summary data">
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
                      <div class="patient-data data">
                        <div class="chart-bar data">
                            <div class="active" onclick="updatePatientCount('1 Week')">1 Week</div>
                            <div onclick="updatePatientCount('1 Month')">1 Month</div>
                            <div onclick="updatePatientCount('1 Year')">1 Year</div>
                            <div onclick="updatePatientCount('All')">All</div>
                        </div>
                      
                        <div class="new-patients">
                            <p class="patient-count" id="patient-count"><?php echo $patientCount; ?></p>
                            <p class="card-name">New Patients</p>
                            <span class="patient-flag">NORMAL</span>
                        </div>

                        <div class="chart">
                            <canvas class="chart-content" style="display: block;" id="lineChart">
                            </canvas>
                            
                        </div>
                        </div>

                            <div class="risk-patient-warning data" style="width: 95%;">
                                <?php
                                  // Fetch daily records for patients
                                  $sql = "
                                  SELECT p.name AS patient_name, p.photo AS patient_photo, r.mood, r.diet, r.notes
                                  FROM Patients p
                                  JOIN PatientDailyRecords r ON p.id = r.patient_id
                                  limit 4
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

                        <div class="patient-group" style="padding-bottom: 1rem; padding-right: 1rem;padding-top: 1rem;">
                        <?php

                          // Query to get average caloric intake, sleep hours, and exercise time from the `PatientDailyRecords` table
                          $sql = "
                              SELECT 
                                  AVG(caloric_intake) AS avg_caloric_intake,
                                  AVG(sleep_hours) AS avg_sleep_hours,
                                  AVG(exercise_time) AS avg_exercise_time
                              FROM PatientDailyRecords;
                          ";

                          // Execute query and fetch results
                          $result = $conn->query($sql);
                          $stats = $result->fetch_assoc();

                          // Round averages to 2 decimal places for better display
                          $avg_caloric_intake = round($stats['avg_caloric_intake'], 2);
                          $avg_sleep_hours = round($stats['avg_sleep_hours'], 2);
                          $avg_exercise_time = round($stats['avg_exercise_time'], 2);
                          ?>

                          <div class="stats-container">
                            <!-- Average Caloric Intake -->
                            <div class="stats-card">
                              <div class="stats-title">
                                <div class="icon-holder lower">
                                  <svg class="icon" aria-hidden="true">
                                    <use xlink:href="#icon-calory1"></use>
                                  </svg>
                                </div>
                                <h3>Avg Caloric Intake</h3>
                              </div>
                              <div class="stats-data">
                                <div class="stats-num"><?php echo htmlspecialchars($avg_caloric_intake); ?> cal</div>
                                <div class="stats-unit">/ Day</div>
                              </div>
                              <div class="stats-evaluation lower">
                                <?php echo ($avg_caloric_intake < 2000) ? 'Lower' : 'Normal'; ?>
                              </div>
                              <div class="chart-placeholder chart-orange"></div>
                            </div>

                            <!-- Average Sleep Mode -->
                            <div class="stats-card">
                              <div class="stats-title">
                                <div class="icon-holder medium">
                                  <svg class="icon" aria-hidden="true">
                                    <use xlink:href="#icon-calory1"></use>
                                  </svg>
                                </div>
                                <h3>Avg Sleep Mode</h3>
                              </div>
                              <div class="stats-data">
                                <div class="stats-num"><?php echo htmlspecialchars($avg_sleep_hours); ?> hour</div>
                                <div class="stats-unit">/ Day</div>
                              </div>
                              <div class="stats-evaluation medium">
                                <?php echo ($avg_sleep_hours >= 6 && $avg_sleep_hours <= 8) ? 'Normal' : 'Abnormal'; ?>
                              </div>
                              <div class="chart-placeholder chart-normal"></div>
                            </div>

                            <!-- Average Exercise Record -->
                            <div class="stats-card">
                              <div class="stats-title">
                                <div class="icon-holder high">
                                  <svg class="icon" aria-hidden="true">
                                    <use xlink:href="#icon-calory1"></use>
                                  </svg>
                                </div>
                                <h3>Avg Exercise Record</h3>
                              </div>
                              <div class="stats-data">
                                <div class="stats-num"><?php echo htmlspecialchars($avg_exercise_time); ?> min</div>
                                <div class="stats-unit">/ Day</div>
                              </div>
                              <div class="stats-evaluation high">
                                <?php echo ($avg_exercise_time > 30) ? 'High' : 'Low'; ?>
                              </div>
                              <div class="chart-placeholder chart-high"></div>
                            </div>
                          </div>
                      
                          <!-- Activity Growth Chart -->
                          <div class="chart-container">
                              <div class="chart-header">
                                  <h3>Activity Growth</h3>
                                  <select id="date-range">
                                      <option value="Jan 2021">Jan 2021</option>
                                      <option value="Feb 2021">Feb 2021</option>
                                  </select>
                              </div>
                              <div class="act-chart">
                              </div>
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

      updatePatientCount('1 Week');
    </script>
</body>
</html>
