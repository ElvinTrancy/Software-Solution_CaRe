<?php

session_start();

include 'inc/side.inc.php';
include 'inc/nav.inc.php';
include 'inc/dbconn.inc.php';

if (!isset($_SESSION['user_id'])) {
    header('Location: login.php');
    exit();
}


$user_name = $_SESSION['username'];
$user_role = "Administrator";
$user_head = $_SESSION['head'];

$sql = "SELECT id, name, photo, group_name FROM patients";
$result = $conn->query($sql);

$patientsData = $result->fetch_all(MYSQLI_ASSOC);


$diagnosedSql = "
SELECT 
d.name AS disease_name, 
COUNT(ptd.disease_id) AS case_count
FROM 
patienttherapistdisease ptd
JOIN 
mentaldiseases d ON ptd.disease_id = d.id
GROUP BY 
ptd.disease_id
ORDER BY 
case_count DESC
LIMIT 2;
";

$diagnosedResult = $conn->query($diagnosedSql);

$diagnosedData = $diagnosedResult->fetch_all(MYSQLI_ASSOC);


$todoSql = "SELECT * FROM `appointments`";

$todoResult = $conn->query($todoSql);

$todoData = $todoResult->fetch_all(MYSQLI_ASSOC);


// 1. Total Patients
$totalPatientsSql = "SELECT COUNT(*) AS total_patients FROM patients";

// 2. Total Therapists
$totalTherapistsSql = "SELECT COUNT(*) AS total_therapists FROM therapists";

// 3. New Patient Groups (assuming group table stores patient groups)
$newPatientGroupsSql = "SELECT COUNT(*) AS new_patient_groups FROM groups WHERE creation_date >= CURDATE() - INTERVAL 30 DAY";

// 4. New Appointments (assuming appointments table stores appointment data)
$newAppointmentsSql = "SELECT COUNT(*) AS new_appointments FROM appointments WHERE appointment_date >= CURDATE() - INTERVAL 30 DAY";

// Execute the queries
$totalPatientsResult = $conn->query($totalPatientsSql);
$totalTherapistsResult = $conn->query($totalTherapistsSql);
$newPatientGroupsResult = $conn->query($newPatientGroupsSql);
$newAppointmentsResult = $conn->query($newAppointmentsSql);

// Fetch the results
$totalPatients = $totalPatientsResult->fetch_assoc()['total_patients'];
$totalTherapists = $totalTherapistsResult->fetch_assoc()['total_therapists'];
$newPatientGroups = $newPatientGroupsResult->fetch_assoc()['new_patient_groups'];
$newAppointments = $newAppointmentsResult->fetch_assoc()['new_appointments'];

// Store the results in an array
$counts = [
    'total_patients' => $totalPatients,
    'total_therapists' => $totalTherapists,
    'new_patient_groups' => $newPatientGroups,
    'new_appointments' => $newAppointments
];

$therapistsSql = "
    SELECT 
        t.id AS therapist_id, 
        t.name AS therapist_name, 
        t.email AS therapist_email, 
        g.name AS group_name
    FROM 
        therapists t
    LEFT JOIN 
        groups g ON g.therapist_id = t.id
        group by
        t.id
";

// Execute the query
$therapistsResult = $conn->query($therapistsSql);

// Fetch the results
$therapistsData = $therapistsResult->fetch_all(MYSQLI_ASSOC);

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home-administrator</title>
    <link rel="stylesheet" href="css/index.css">
    <link rel="stylesheet" href="css/calendar.css">
    <link rel="stylesheet" href="components/modal/index.css">
    <script src="components/icon/index.js"></script>
</head>
<body>

  <div class="content">
    <div class="bread-bar">
        <div class="link">
            Welcome!  <?= htmlspecialchars($user_name) ?> !
        </div>
        <div class="announcement">
            <svg class="icon arrow-icon" aria-hidden="true">
                <use xlink:href="#icon-announcement"></use>
            </svg>
            <span style="margin-left: 4px;">announcement</span>
        </div>
    </div>

    <!-- Statistic Area -->
    <div class="statistic-area">
        <div class="statistic-item">
            <div class="progress">
                <div class="progress-circle" id="total-patients-progress" style="--percentage: 80">
                    <div class="progress-mask">
                        <svg class="icon arrow-icon" aria-hidden="true">
                            <use xlink:href="#icon-arrow-up"></use>
                        </svg>
                    </div>
                </div>
            </div>
            <div class="status-container">
                <div class="title">Total Patients</div>
                <div class="number" id="total-patients-amount"><?php echo htmlspecialchars($counts['total_patients']); ?></div>
                <div class="rate">
                    <span id="total-patients-percentage">14.25%</span>
                    <div class="arrow" id="total-patients-arrow"></div>
                </div>
            </div>
        </div>
        <div class="statistic-item">
            <div class="progress">
                <div class="progress-circle" id="total-therapists-progress" style="--percentage: 60">
                    <div class="progress-mask">
                        <svg class="icon arrow-icon" aria-hidden="true">
                            <use xlink:href="#icon-arrow-up"></use>
                        </svg>
                    </div>
                </div>
            </div>
            <div class="status-container">
                <div class="title">Total Therapists</div>
                <div class="number" id="total-therapists-amount"><?php echo htmlspecialchars($counts['total_therapists']); ?></div>
                <div class="rate">
                    <span id="total-therapists-percentage">21.65%</span>
                    <div class="arrow" id="total-therapists-arrow"></div>
                </div>
            </div>
        </div>
        <div class="statistic-item">
            <div class="progress">
                <div class="progress-circle" id="new-patient-group-progress" style="--percentage: 70">
                    <div class="progress-mask">
                        <svg class="icon arrow-icon" aria-hidden="true">
                            <use xlink:href="#icon-arrow-up"></use>
                        </svg>
                    </div>
                </div>
            </div>
            <div class="status-container">
                <div class="title">New Patient Group</div>
                <div class="number" id="new-patient-group-amount"><?php echo htmlspecialchars($counts['new_patient_groups']); ?></div>
                <div class="rate">
                    <span id="new-patient-group-percentage">10.36%</span>
                    <div class="arrow" id="new-patient-group-arrow"></div>
                </div>
            </div>
        </div>
        <div class="statistic-item">
            <div class="progress">
                <div class="progress-circle" id="new-appointment-progress" style="--percentage: 90">
                    <div class="progress-mask">
                        <svg class="icon arrow-icon" aria-hidden="true">
                            <use xlink:href="#icon-arrow-up"></use>
                        </svg>
                    </div>
                </div>
            </div>
            <div class="status-container">
                <div class="title">New Appointment</div>
                <div class="number" id="new-appointment-amount"><?php echo htmlspecialchars($counts['new_appointments']); ?></div>
                <div class="rate">
                    <span id="new-appointment-percentage">13.95%</span>
                    <div class="arrow" id="new-appointment-arrow"></div>
                </div>
            </div>
        </div>
    </div>
<!-- Statistic Area End -->

    <div class="charts-area">
        <div class="left-content">
            <div class="calendar-section">
                <div class="calendar">
                    <div class="calendar-header">
                        <div class="current-month" id="calendar-month-year">February 2019</div>
                        <div class="calendar-btn">
                            <div class="prev-month">
                                <svg class="icon" aria-hidden="true">
                                    <use xlink:href="#icon-left"></use>
                                </svg>
                            </div>
                            <div class="next-month" style="margin-left: 10px;">
                                <svg class="icon"  aria-hidden="true">
                                    <use xlink:href="#icon-left"></use>
                                </svg>
                            </div>
                        </div>
                    </div>
                    <div class="calendar-body" >
                        <div class="calendar-weekdays">
                            <div>S</div>
                            <div>M</div>
                            <div>T</div>
                            <div>W</div>
                            <div>T</div>
                            <div>F</div>
                            <div>S</div>
                        </div>
                        <div class="calendar-dates" id="calendar-body">
                            <!-- Dates will be generated by JavaScript -->
                        </div>
                    </div>
                </div>
                <div class="todo">
                    <div class="todo-list">
                        <h2>Todo</h2>
                        <div class="care-scroll">
                            <?php foreach($todoData as $todo): ?>
                                <div class="todo-item">
                                <div class="circle"></div>
                                <div class="task-content">
                                    <p class="task-title"><?php echo htmlspecialchars($todo['notes']); ?></p>
                                    <p class="task-time"><?php echo htmlspecialchars($todo['appointment_date']); ?></p>
                                </div>
                            </div>
                            <?php endforeach?>
                        </div>
                    </div>
                </div>
            </div>
            <div class="chart-section" id="patient-chart">
                
            </div>
            <div class="chart-section care-scroll" style="overflow-y: auto;">
                <table class="styled-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>NAME</th>
                            <th>E-mail ADDRESS</th>
                            <th>Group</th>
                            <th>Professional Field</th>
                            <th>STATUS</th>
                        </tr>
                    </thead>
                    <tbody>

                    <?php foreach($therapistsData as $therapist): ?>
                        <tr>
                            <td><?php echo htmlspecialchars($therapist['therapist_id']); ?></td>
                            <td><?php echo htmlspecialchars($therapist['therapist_name']); ?></td>
                            <td><?php echo htmlspecialchars($therapist['therapist_email']); ?></td>
                            <td><?php echo htmlspecialchars($therapist['group_name']); ?></td>
                            <td>Early intervention</td>
                            <td><span class="status online">Online</span></td>
                        </tr>
                        <?php endforeach ?>
                    </tbody>
                </table>
            </div>

        </div>

        <div class="right-content">
            <div class="diagnostic">
                <div class="diagnostic-chart">
                    <div class="section-title">Top Diagnostic</div>
                    <div class="section-period">This Week <span class="dropdown-icon">▼</span></div>
                    <div class="circular-chart">
                        <div class="circle-segment segment-blue" style="--percentage: 90;" id="segment-blue"></div>
                        <div class="circle-segment segment-cyan inner-circle" style="--percentage: 10;" id="segment-cyan"></div>
                        <div class="chart-inner-circle"></div>
                    </div>
                    <div class="diagnostic-legend">
                        <?php foreach ($diagnosedData as $index => $disease): ?>
                            <div class="legend-item">
                            <span class="legend-color <?php echo($index == 0 ? 'blue' : 'cyan'); ?>"></span> <?php echo htmlspecialchars($disease['disease_name']); ?>
                            <span class="legend-value" id="insomnia-value"><?php echo htmlspecialchars($disease['case_count']); ?></span>
                        </div>
                        <?php endforeach; ?>
                    </div>
                </div>
            </div>
            <div class="new-patient">
                <div class="new-patients-section" style="position: relative;">
                    <div class="section-title">
                        New Patients
                    </div>
                    <div class="section-period">
                        This Week
                        <span class="dropdown-icon">▼</span>
                        <div class="dropdown-menu">
                            <div class="dropdown-item">Today</div>
                            <div class="dropdown-item">This Week</div>
                            <div class="dropdown-item">This Month</div>
                            <div class="dropdown-item">This Year</div>
                        </div>
                    </div>
                    <div class="care-scroll patient-list">
                        <?php foreach ($patientsData as $patient): ?>
                            <div class="patient-item">
                                <img src="<?php echo htmlspecialchars($patient['photo']); ?>" onerror="this.src = 'assets/head.jpeg'" alt="Patient Avatar" class="patient-avatar">
                                <div class="patient-info">
                                    <div class="patient-id">
                                        <a href="#">ID: <?php echo htmlspecialchars($patient['id']); ?></a> <?php echo htmlspecialchars($patient['name']); ?>
                                    </div>
                                    <div class="patient-group">Group: <?php echo htmlspecialchars($patient['group_name']); ?></div>
                                </div>
                                <div class="patient-menu">
                                    <svg class="icon copy" aria-hidden="true">
                                        <use xlink:href="#icon-menu"></use>
                                    </svg>
                                </div>
                            </div>
                        <?php endforeach; ?>
                    </div>
                    <div class="view-more">
                        More
                        <span class="dropdown-icon">▼</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
  </div>

  <div class="bottom-info">
    <span>Privacy Policy</span>
    <span style="margin-left: 3rem;">Terms of Use</span>
  </div>
  <script src="js/calendar--.js"></script>
  <!-- <script src="js/index.js"></script> -->
  <!-- <script src="js/data.js"></script>   -->
  <!-- <script src="components/siderBar/index.js"></script> -->
  <script>


  </script>
</body>
</html>
