<?php

session_start();


if (!isset($_SESSION['user_id'])) {
    header('Location: login.php');
    exit();
}


include 'inc/side.inc.php';
include 'inc/nav.inc.php';
include 'inc/dbconn.inc.php';


$therapistsSql = "
SELECT 
t.id AS therapist_id, 
t.name AS therapist_name, 
t.email, 
t.field, 
MIN(g.name) AS group_name
FROM 
therapists t
LEFT JOIN 
groups g ON t.id = g.therapist_id
GROUP BY 
t.id;
";
$result = $conn->query($therapistsSql);

$therapists = [];
$fields = [];

$statuses = ['Online', 'Rest', 'Quit'];

// Store each therapist and their group in the array
while ($row = $result->fetch_assoc()) {
  $therapistId = $row['therapist_id'];
  $randomKey = array_rand($statuses);
  // Add therapist to the list
  $therapists[$therapistId] = [
      'id' => $therapistId,
      'name' => $row['therapist_name'],
      'email' => $row['email'],
      'field' => $row['field'],
      'group' => $row['group_name'], // Comma-separated group names,
      'status' => $statuses[$randomKey]
  ];

  $fields[] = $row['field']; // Store fields for later use
}

// Remove duplicate fields to get a list of unique fields
$fields = array_unique($fields);

$groupSql = "SELECT name FROM groups";
$result = $conn->query($groupSql);

$groupNames = [];

if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $groupNames[] = $row['name'];
    }
}

$patientsSql = "SELECT * FROM patients";
$result = $conn->query($patientsSql);

// Initialize an empty array to hold patient data
$patientsData = [];

if ($result->num_rows > 0) {
    // Fetch each row of data and add it to the patientsData array
    while ($row = $result->fetch_assoc()) {
        $patientsData[] = $row;
    }
} else {
    echo "No patients found.";
}


?>




<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Therapist Management</title>
    <link rel="stylesheet" href="components/modal/index.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/index.css">
    <link rel="stylesheet" href="pages/therapist/index.css">
    <link rel="stylesheet" href="components/pagination/index.css">
    <link rel="stylesheet" href="components/filter/index.css">   
    <link href="components/loading/index.css" rel="stylesheet">
    <script src="components/icon/index.js"></script>
</head>
<body>

  <div class="content">
    <div class="bread-bar">
        <div class="link">
          Therapist management >
        </div>
        <div class="announcement">
            <svg class="icon arrow-icon" aria-hidden="true">
                <use xlink:href="#icon-announcement"></use>
            </svg>
            <span style="margin-left: 4px;">announcement</span>
        </div>
    </div>

    <div class="category-section">
      <div class="category-container ownership">
        <svg class="icon menu-icon" aria-hidden="true">
          <use xlink:href="#icon-ownership"></use>
        </svg>
        <span>Ownership Group</span>
      </div>
      <div class="category-container professional">
        <svg class="icon menu-icon" aria-hidden="true">
          <use xlink:href="#icon-profession"></use>
        </svg>
        <span>Professional Field</span>
      </div>
      <div class="category-container certification">
        <svg class="icon menu-icon" aria-hidden="true">
          <use xlink:href="#icon-certification"></use>
        </svg>
        <span>Therapists certification</span>
      </div>
      <div class="category-container training">
        <svg class="icon menu-icon" aria-hidden="true">
          <use xlink:href="#icon-training"></use>
        </svg>
        <span>Therapist training</span>
      </div>
    </div>
    <div class="list-name">Therapists Lists</div>

    <div class="filter-section">
      <div class="search-container">
        <input type="text" class="search-input" placeholder="Search ID or Name">
        <button class="operation-btn add-bt" id="addPatient">Add +</button>
    </div>
      <div class="filter-bar">
        <div class="filter-item">
            <div class="filter-icon"></div>
            <span style="font-weight: 600;">Filter By</span>
        </div>
        <div class="filter-item">
          <div class="dropdown">
            <div class="dropdown-selected" data-default="Group">Group</div>
            <div class="dropdown-options">
                <?php foreach($groupNames as $group): ?>
                  <div class="dropdown-option" data-value="<?= htmlspecialchars($group) ?>"><?= htmlspecialchars($group) ?></div>
                <?php endforeach; ?>
            </div>
          </div>
        </div>
        <div class="filter-item">
          <div class="dropdown">
              <div class="dropdown-selected" data-default="Field">Field</div>
              <div class="dropdown-options">
                <?php foreach($fields as $field): ?>
                  <div class="dropdown-option" data-value="<?= htmlspecialchars($field) ?>"><?= htmlspecialchars($field) ?></div>
                <?php endforeach; ?>
              </div>
          </div>
        </div>
      
        <div class="filter-item">
          <div class="dropdown">
              <div class="dropdown-selected" data-default="Status">Status</div>
              <div class="dropdown-options">
                  <div class="dropdown-option" data-value="Online">Online</div>
                  <div class="dropdown-option" data-value="Rest">Rest</div>
                  <div class="dropdown-option" data-value="Quit">Quit</div>
              </div>
          </div>
        </div>
      
        <div class="filter-item reset-filter" style="justify-content: center; cursor: pointer;">
            <div class="reset-icon"></div>
            <span class="reset-text">Reset Filter</span>
        </div>
    </div>
    </div>

    <div class="therapist-table-container">
        <div class="loading-spinner" id="loading-spinner"></div>
        <table class="styled-table" >
            <thead>
                <tr>
                    <th>ID</th>
                    <th>NAME</th>
                    <th>E-mail ADDRESS</th>
                    <th>Group</th>
                    <th>Professional Field</th>
                    <th>STATUS</th>
                    <th>Operation</th>
                </tr>
            </thead>
            <tbody>
                
            </tbody>
        </table>
        <div id="pagination-container" class="pagination"></div>
    </div>
    
  </div>

  <div class="bottom-info">
    <span>Privacy Policy</span>
    <span style="margin-left: 3rem;">Terms of Use</span>
  </div>
  <div id="therapist-editor" class="modal-mask">
    <div class="modal-wrap">
        <div class="modal-content">
            <button class="modal-close" onclick="hideModal()">✖</button>
            <div class="modal-header">
                <h2 class="modal-title">Therapist Details</h2>
            </div>
            <div class="modal-body">
                <div class="therapist-info-container">
                    <!-- Left Section: Therapist Info -->
                    <div class="therapist-info-left-section">
                        <div class="therapist-info-card">
                            <div class="therapist-info-image">
                                <img src="assets/doc2.jpeg" alt="Therapist Picture">
                            </div>
                            <div class="therapist-info-content">
                                <div class="info-row">
                                    <p class="info-title">Email:</p>
                                    <p class="info-value">
                                        <a href="mailto:ademsmith123@care.com">ademsmith123@care.com</a>
                                        <span class="edit-icon" onclick="toggleEdit('email')">✏️</span>
                                    </p>
                                </div>
                                <div class="info-row">
                                    <p class="info-title">Field:</p>
                                    <p class="info-value">Early Intervention records</p>
                                </div>
                                <div class="info-row">
                                    <p class="info-title">Brief:</p>
                                    <p class="info-value" id="brief-text">
                                        Early intervention records Early intervention Early intervention records Early intervention Early
                                        <span class="edit-icon" onclick="toggleEdit('brief')">✏️</span>
                                    </p>
                                </div>
                            </div>
                            
                        </div>
            
                        <!-- Assigned Patient Section -->
                        <div class="therapist-info-assigned-patient">
                            <h4>Assigned Patient</h4>
                            <input type="text" class="search-input" placeholder="Search ID or Name">
                            <div class="therapist-info-patient-list care-scroll">
                                <!-- Example Patient Items -->
                                <div class="therapist-info-patient-item">
                                    <img src="assets/head.jpeg" alt="Patient Picture">
                                    <div class="therapist-info-patient-info">
                                        <h4>Patient ID: 001</h4>
                                        <h4>Olivia Turner, M.D.</h4>
                                    </div>
                                    <input type="checkbox" class="therapist-info-patient-checkbox">
                                </div>
                                <div class="therapist-info-patient-item">
                                    <img src="assets/head.jpeg" alt="Patient Picture">
                                    <div class="therapist-info-patient-info">
                                        <h4>Patient ID: 001</h4>
                                        <h4>Olivia Turner, M.D.</h4>
                                    </div>
                                    <input type="checkbox" class="therapist-info-patient-checkbox">
                                </div>
                                <div class="therapist-info-patient-item">
                                    <img src="assets/head.jpeg" alt="Patient Picture">
                                    <div class="therapist-info-patient-info">
                                        <h4>Patient ID: 001</h4>
                                        <h4>Olivia Turner, M.D.</h4>
                                    </div>
                                    <input type="checkbox" class="therapist-info-patient-checkbox">
                                </div>
                                <div class="therapist-info-patient-item">
                                    <img src="assets/head.jpeg" alt="Patient Picture">
                                    <div class="therapist-info-patient-info">
                                        <h4>Patient ID: 001</h4>
                                        <h4>Olivia Turner, M.D.</h4>
                                    </div>
                                    <input type="checkbox" class="therapist-info-patient-checkbox">
                                </div>
                                <div class="therapist-info-patient-item">
                                    <img src="assets/head.jpeg" alt="Patient Picture">
                                    <div class="therapist-info-patient-info">
                                        <h4>Patient ID: 001</h4>
                                        <h4>Olivia Turner, M.D.</h4>
                                    </div>
                                    <input type="checkbox" class="therapist-info-patient-checkbox">
                                </div>
                                <div class="therapist-info-patient-item">
                                    <img src="assets/head.jpeg" alt="Patient Picture">
                                    <div class="therapist-info-patient-info">
                                        <h4>Patient ID: 001</h4>
                                        <h4>Olivia Turner, M.D.</h4>
                                    </div>
                                    <input type="checkbox" class="therapist-info-patient-checkbox">
                                </div>
                                <!-- Repeat therapist-info-patient-item for each patient -->
                            </div>
                        </div>
                    </div>
            
                    <!-- Right Section: Certificates and Therapist Group -->
                    <div class="therapist-info-right-section">
                        <!-- Certificates Section -->
                        <div class="therapist-info-certificates">
                            <h4>Certificate (02)</h4>
                            <div class="therapist-info-certificate-item">
                                <img src="assets/certification2.png" alt="Certificate Image">
                                <p>The Psychiatrist's Guide to Population Management of Diabetes</p>
                            </div>
                            <div class="therapist-info-certificate-item">
                                <img src="assets/certification1.png" alt="Certificate Image">
                                <p>DOCTORATE OF PSYCHIATRY</p>
                            </div>
                        </div>
            
                        
                        <!-- Therapist Group Section -->

                        <div class="therapist-info-group-container">
                            <h4>Therapist Group</h4>
                            <div class="therapist-info-group">
                                <div class="therapist-info-group-item">
                                    <div class="group-details">
                                        <div>
                                            <h4>Expert group</h4>
                                            <p>Num of Member: 18</p>
                                        </div>
                                        <!-- Move group icon here -->
                                        <div class="group-icon">
                                            <img src="assets/patient_male.png" alt="Group Icon">
                                        </div>
                                    </div>
                                    <div class="group-authority">
                                        <h4>Authority:</h4>
                                        <p><a href="#">View patient information</a></p>
                                        <p><a href="#">Edit patient data</a></p>
                                        <p><a href="#">Create a patient group</a></p>
                                    </div>
                                </div>

                                <div class="therapist-info-group-item">
                                    <div class="group-details">
                                        <div>
                                            <h4>Expert group</h4>
                                            <p>Num of Member: 18</p>
                                        </div>
                                        <!-- Move group icon here -->
                                        <div class="group-icon">
                                            <img src="assets/patient_male.png" alt="Group Icon">
                                        </div>
                                    </div>
                                    <div class="group-authority">
                                        <h4>Authority:</h4>
                                        <p><a href="#">View patient information</a></p>
                                        <p><a href="#">Edit patient data</a></p>
                                        <p><a href="#">Create a patient group</a></p>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
  </div>
  <script>
    const mockData = Object.values(<?php echo json_encode($therapists); ?>);
    const groups = ['Group 1', 'Group 2', 'Group 3', 'Group 4'];
    const allPatients = Object.values(<?php echo json_encode($patientsData); ?>) ;
    const fields = Object.values(<?php echo json_encode($fields); ?>) ;
    const statuses = ['Online', 'Rest', 'Quit'];
  </script>

  
  <script src="components/modal/confirm.js"></script>
  <script src="components/pagination/index.js"></script>
  <script src="pages/therapist/index.js"></script>

  <script>
    document.getElementById('addPatient').addEventListener('click', () => {
      showModal();
    });

    document.querySelector('.therapist-info-delete-btn').addEventListener('click', function () {
    // Get the data from the form
    const name = document.querySelector('#name-input').value;
    const email = document.querySelector('#email-input').value;
    const field = document.querySelector('#field-select').value;
    const brief = document.querySelector('#brief-textarea').value;
    const certificates = []; // You can populate this array with file paths of the certificates.
    const patients = []; // Get the list of selected/unselected patients.
    
    const assignedPatients = document.querySelectorAll('.therapist-info-patient-item input[type="checkbox"]:checked');
    assignedPatients.forEach(patient => {
        patients.push({
            id: patient.closest('.therapist-info-patient-item').querySelector('h4').textContent.split(' ')[2],
            selected: true
        });
    });

    const groups = []; // Add logic to retrieve selected groups if necessary

    // Prepare data to be sent to the server
    const therapistData = {
        name: name,
        email: email,
        field: field,
        brief: brief,
        certificates: certificates,
        patients: patients,
        groups: groups
    };


    console.log(therapistData);
    // Send the data using fetch
    fetch('requests/saveTherapist.php', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(therapistData),
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            alert('Therapist saved successfully');
            // Optionally reload or navigate to another page
        } else {
            alert('Error saving therapist: ' + data.error);
        }
    })
    .catch(error => console.error('Error:', error));
});

  </script>
</body>
</html>
