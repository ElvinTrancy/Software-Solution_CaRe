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
    <script src="components/icon/index.js"></script>
    <style>
      /* Unique styles for the custom bar chart */
      .custom-bar-group {
          display: flex;
          flex-direction: column;
          align-items: center;
          margin: 0 10px;
      }

      .custom-bar {
          width: 10px;
          margin: 2px;
      }

      .custom-aerobics {
          background-color: #e57373;
      }

      .custom-yoga {
          background-color: #64b5f6;
      }

      .custom-meditation {
          background-color: #ffb74d;
      }

      .custom-label {
          margin-top: 5px;
          font-size: 12px;
          text-align: center;
      }
      
      .legend {
          display: flex;
          justify-content: center;
          margin-top: 10px;
      }
      .legend-item {
          margin-right: 15px;
          display: flex;
          align-items: center;
      }
      .legend-color {
          width: 20px;
          height: 20px;
          margin-right: 5px;
      }
    </style>
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
                    <div style="display: flex;">
                      <h2 style="cursor: pointer;" onclick="window.location.href = 'index.php'">DashBoard</h2><h2> > Summary of Patient Data</h2>
                    </div>
                        <button onclick="window.location.href='requests/export_patient_data.php'">Export Data</button>
                    </div>

                    <div class="summary-group data" style="margin-top: 1rem;">
                        <div class="patient-summary data">
                        <?php
                        function getPatientCount($range) {
                            global $conn;

                            // Prepare SQL query based on the time range
                            switch ($range) {
                                case '1 Day':
                                    $sql = "SELECT COUNT(*) AS patient_count FROM Patients WHERE created_at >= DATE_SUB(NOW(), INTERVAL 1 DAY)";
                                    break;
                                case '1 Week':
                                    $sql = "SELECT COUNT(*) AS patient_count FROM Patients WHERE created_at >= DATE_SUB(NOW(), INTERVAL 1 WEEK)";
                                    break;
                                case '1 Month':
                                    $sql = "SELECT COUNT(*) AS patient_count FROM Patients WHERE created_at >= DATE_SUB(NOW(), INTERVAL 1 MONTH)";
                                    break;
                                case '1 Year':
                                    $sql = "SELECT COUNT(*) AS patient_count FROM Patients WHERE created_at >= DATE_SUB(NOW(), INTERVAL 1 YEAR)";
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
                              SELECT p.name AS patient_name, p.email AS patient_email, p.photo AS patient_photo, r.mood, r.diet, r.notes
                              FROM Patients p
                              JOIN PatientDailyRecords r ON p.id = r.patient_id
                              LIMIT 4";
                              $result = $conn->query($sql);
                              $patientRecords = $result->fetch_all(MYSQLI_ASSOC);
                              ?>
                              <div class="patient-cards">
                                  <?php foreach ($patientRecords as $record): ?>
                                      <div class="patient-card">
                                          <img src="./<?php echo htmlspecialchars($record['patient_photo']); ?>" alt="<?php echo htmlspecialchars($record['patient_name']); ?>" class="patient-photo">
                                          <p class="patient-name"><?php echo htmlspecialchars($record['patient_name']); ?></p>
                                          <p class="patient-msg"><?php echo htmlspecialchars($record['notes']); ?></p>
                                          <?php
                                              // Prepare the email subject and body
                                              $subject = urlencode('Response to your message: ' . htmlspecialchars($record['notes']));
                                              $body = urlencode('Hello ' . htmlspecialchars($record['patient_name']) . ',\n\nThis is a response to your message: ' . htmlspecialchars($record['notes']));
                                              ?>
                                          <a href="mailto:<?php echo htmlspecialchars($record['patient_email']); ?>?subject=<?php echo $subject; ?>&body=<?php echo $body; ?>" class="contact-btn">Contact</a>
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
                                      
                                  </select>
                              </div>
                              <div class="act-chart">
                                <canvas id="chartCanvas" width="1000" height="350"></canvas>
                                <div class="legend">
                                    
                                </div>
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

      // Function to get the last three months in number format (1-12)
      function getLastThreeMonths() {
          const months = [];
          const currentDate = new Date();
          for (let i = 0; i < 3; i++) {
              const month = currentDate.getMonth() + 1; // getMonth() returns 0 for January, so add 1
              const year = currentDate.getFullYear();
              months.push({ month, year });
              currentDate.setMonth(currentDate.getMonth() - 1); // Move to the previous month
          }
          return months;
      }

      // Populate the select element
      const dateSelect = document.getElementById('date-range');
      const lastThreeMonths = getLastThreeMonths();

      lastThreeMonths.forEach(({ month, year }) => {
          const option = document.createElement('option');
          option.value = `${month}-${year}`; // Value format: 'MM-YYYY'
          option.textContent = `${month < 10 ? '0' + month : month} ${year}`; // Display with two digits month
          dateSelect.appendChild(option);
      });

      // Add event listener to call updateDiseaseCount when selection changes
      dateSelect.addEventListener('change', function() {
          const [month, year] = this.value.split('-'); // Split value into month and year
          updateDiseaseCount(month, year); // Call updateDiseaseCount with the selected month and year
      });


      function updateDiseaseCount(month, year) {
          fetch('requests/getdisease.php', {
              method: 'POST',
              headers: {
                  'Content-Type': 'application/x-www-form-urlencoded',
              },
              body: 'month=' + month + '&year=' + year
          })
          .then(response => {
              if (!response.ok) {
                  throw new Error('Network response was not ok');
              }
              return response.json(); // Make sure to return the parsed JSON here
          })
          .then(data => {
              console.log(data);
              if (data.error) {
                  console.error('Error:', data.error);
              } else {
                  const transData = transformData(data);
                  drawPercentageLines();
                  drawActivityChart(transData); // Pass the data to the chart drawing function
              }
          })
          .catch(error => console.error('Error:', error));
      }

      function transformData(data) {
          const transformed = {};
          data.forEach(entry => {
              if (!transformed[entry.day]) {
                  transformed[entry.day] = { day: entry.day, diseases: [] };
              }
              transformed[entry.day].diseases.push({
                  disease: entry.disease,
                  patient_count: entry.patient_count
              });
          });

          // Convert the transformed object back to an array
          return Object.values(transformed);
      }

      const canvas = document.getElementById('chartCanvas');
      const ctx = canvas.getContext('2d');

      const chartWidth = canvas.width;
        const chartHeight = canvas.height;

      const colors = {
            "ADHD": '#e57373',
            "Anxiety": '#64b5f6',
            "Bipolar Disorder": '#ffb74d',
            "Depression": '#81c784',
            "Eating Disorder": '#ba68c8',
            "Obsessive-Compulsive Disorder": '#f06292',
            // "Panic Disorder": '#ff8a65',
            // "Personality Disorder": '#4db6ac',
            // "Post-Traumatic Stress Disorder": '#7986cb',
            // "Schizophrenia": '#ffd54f'
        };

        const legendContainer = document.querySelector('.legend');

        Object.entries(colors).forEach(([key, value]) => {
          const legendItem = document.createElement('div');
          legendItem.classList.add('legend-item');

          // Create the color box
          const colorBox = document.createElement('div');
          colorBox.classList.add('legend-color');
          colorBox.style.backgroundColor = value;

          // Create the label
          const label = document.createTextNode(key);

          // Append the color box and label to the legend item
          legendItem.appendChild(colorBox);
          legendItem.appendChild(label);

          // Append the legend item to the legend container
          legendContainer.appendChild(legendItem);
        });


      function findMaxTotalPatientCount(data) {
          let maxTotalCount = 0;

          data.forEach(dayData => {
              const totalCount = dayData.diseases.reduce((sum, diseaseData) => sum + diseaseData.patient_count, 0);
              if (totalCount > maxTotalCount) {
                  maxTotalCount = totalCount;
              }
          });

          return maxTotalCount;
      }

      function drawPercentageLines() {
          const chartHeight = canvas.height;
          const padding = 50;
          const percentageLevels = [0, 0.2, 0.4, 0.6, 0.8]; // Represents 20%, 40%, 60%, 80%
          
          ctx.strokeStyle = '#ccc'; // Light grey for the percentage lines
          ctx.fillStyle = '#aaa'; // Grey for the text labels
          ctx.font = '12px Arial';

          percentageLevels.forEach(level => {
              const y = chartHeight - padding - (level * (chartHeight - padding * 2)); // Calculate Y position based on level
              
              // Draw horizontal line
              ctx.beginPath();
              ctx.moveTo(padding, y);
              ctx.lineTo(chartWidth - padding, y);
              ctx.stroke();

              // Draw percentage text
              ctx.fillText((level * 100) + '%', padding - 30, y + 5); // Adjust position for the text
          });
      }

      function drawActivityChart(diseaseData) {
        ctx.clearRect(0, 0, canvas.width, canvas.height);
        
        const padding = 50;
        const barWidth = 6; // Width of each bar

        const maxTotalPatientCount = findMaxTotalPatientCount(diseaseData); 

        // Calculate bar spacing
        const spacing = (chartWidth - padding * 2) / diseaseData.length;

        // Loop through data to draw bars for each day
        diseaseData.forEach((dayData, index) => {
            const x = padding + index * spacing;
            let currentY = chartHeight - padding;

            dayData.diseases.forEach(diseaseData => {
                const disease = diseaseData.disease;
                const patientCount = diseaseData.patient_count;
                const barHeight = (patientCount / maxTotalPatientCount) * (chartHeight - padding * 2);

                // Draw each part of the stacked bar
                drawStackedBar(x, currentY, barWidth, barHeight, colors[disease]);

                // Adjust the current Y position to stack the next part on top
                currentY -= barHeight;
            });

            // Draw the date label
            ctx.fillStyle = '#000';
            ctx.font = '12px Arial';
            ctx.textAlign = 'center';
            const dayOnly = dayData.day.split('-')[2]; 
            ctx.fillText(dayOnly, x + barWidth / 2, chartHeight - 10);
        });
      }

      function drawStackedBar(x, y, width, height, color, radius = 5) {
        ctx.fillStyle = color;
        ctx.beginPath();
        ctx.moveTo(x, y - height + radius); // Start point at top left with radius offset
        ctx.arcTo(x, y - height, x + radius, y - height, radius); // Top-left corner
        ctx.lineTo(x + width - radius, y - height); // Top horizontal line
        ctx.arcTo(x + width, y - height, x + width, y - height + radius, radius); // Top-right corner
        ctx.lineTo(x + width, y - radius); // Right vertical line
        ctx.arcTo(x + width, y, x + width - radius, y, radius); // Bottom-right corner
        ctx.lineTo(x + radius, y); // Bottom horizontal line
        ctx.arcTo(x, y, x, y - radius, radius); // Bottom-left corner
        ctx.closePath();
        ctx.fill(); // Fill the path with the color
      }


      function drawBar(x, count, color) {
          const canvas = document.getElementById('chartCanvas');
          const ctx = canvas.getContext('2d');
          const chartHeight = canvas.height;
          const padding = 50;
          const barWidth = 10;

          const barHeight = (count / 100) * (chartHeight - padding * 2); // Assuming count scaled for max 100
          const y = chartHeight - padding - barHeight;

          ctx.fillStyle = color;
          ctx.fillRect(x, y, barWidth, barHeight);
      }

      updateDiseaseCount(10, 2024);
    </script>
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
