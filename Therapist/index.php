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
                        $range = $_GET['range'] ?? '1 Day';
                        $patientCount = getPatientCount($range);
                        ?>
                      <div class="patient-data">
                        <div class="new-patients">
                            <p class="patient-count" id="patient-count"><?php echo $patientCount; ?></p>
                            <p class="card-name">New Patients</p>
                            <span class="patient-flag">NORMAL</span>
                        </div>

                        <div class="chart">
                            <div class="chart-content">
                            </div>
                            <div class="chart-bar">
                                <div class="active" onclick="updatePatientCount('1 Day')">1 Day</div>
                                <div onclick="updatePatientCount('1 Week')">1 Week</div>
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
                          <div class="group-card">
                            <div class="group-info">
                                <h3>Group ID: 001<br><span>Anxiety Management Group</span></h3>
                                <p>Group Study: Anxiety Management<br>Group Member: 20</p>
                                <div class="group-details">
                                    <div class="group-date">
                                        <svg class="icon" aria-hidden="true">
                                            <use xlink:href="#icon-calendar"></use>
                                        </svg>
                                        <span>31st March '22</span>
                                    </div>
                                    <div class="group-time">
                                        <svg class="icon" aria-hidden="true">
                                            <use xlink:href="#icon-clock"></use>
                                        </svg>
                                        <span>7:30 PM - 8:30 PM</span>
                                    </div>
                                </div>
                            </div>
                            <div class="group-options">
                                <svg class="icon" aria-hidden="true">
                                    <use xlink:href="#icon-menu"></use>
                                </svg>
                            </div>
                          </div>
                          <div class="group-card">
                            <div class="group-info">
                                <h3>Group ID: 001<br><span>Anxiety Management Group</span></h3>
                                <p>Group Study: Anxiety Management<br>Group Member: 20</p>
                                <div class="group-details">
                                    <div class="group-date">
                                        <svg class="icon" aria-hidden="true">
                                            <use xlink:href="#icon-calendar"></use>
                                        </svg>
                                        <span>31st March '22</span>
                                    </div>
                                    <div class="group-time">
                                        <svg class="icon" aria-hidden="true">
                                            <use xlink:href="#icon-clock"></use>
                                        </svg>
                                        <span>7:30 PM - 8:30 PM</span>
                                    </div>
                                </div>
                            </div>
                            <div class="group-options">
                                <svg class="icon" aria-hidden="true">
                                    <use xlink:href="#icon-menu"></use>
                                </svg>
                            </div>
                          </div>
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
          // Replace the current patient data section with the updated HTML
          document.querySelector('.patient-data').innerHTML = html;

          // Highlight the selected time range
          document.querySelectorAll('.chart-bar div').forEach(el => el.classList.remove('active'));
          document.querySelector(`div[onclick="updatePatientCount('${range}')"]`).classList.add('active');
      }
    </script>
</body>
</html>
