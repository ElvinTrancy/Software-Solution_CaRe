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
  
$therapistsSql = "SELECT id, name FROM Therapists";
$therapistsResult = $conn->query($therapistsSql);

// Fetch all patients from the database
$patientsSql = "SELECT id, name, photo FROM Patients"; // Adjust the table and column names if needed
$patientsResult = $conn->query($patientsSql);

$patients = [];
if ($patientsResult->num_rows > 0) {
    while ($row = $patientsResult->fetch_assoc()) {
        $patients[] = $row;
    }
}

$assignedPatients = [];
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Group Detail</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600&amp;display=swap">
    <link rel="stylesheet" href="css/index.css"> 
    <link rel="stylesheet" href="css/patients.css"> 
    <link rel="stylesheet" href="css/add-group.css">
    <script src="components/icon/index.js"></script>
</head>
<body>
    <div class="dashboard">

        <!-- Main content -->
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
            <div class="page-scrum" style="justify-content: flex-start;">
                        <h2 style="cursor: pointer;" onclick="window.location.href = 'group.php'" class="go-back">Patient Group List</h2>
                        <h2>></h2>
                        <h2>Create New Group</h2>
                    </div>
                <!-- Group detail section -->                    
                    <div class="add-group-container">
                        <div class="add-group-header">
                            <div class="add-group-id">Group ID: </div>
                            <div class="add-group-actions">
                                <button class="add-group-confirm-btn" id="assignPatient">Initiating Group Therapy →</button>
                            </div>
                        </div>
                        <div class="add-group-form-section">
                            <div class="add-group-input-group">
                                <label for="group-name">Group Name:</label>
                                <input type="text" id="group-name" name="group_name" required>
                            </div>
                            <div class="add-group-input-group">
                                <label for="group-leader">Group Leader:</label>
                                <select style="padding: 12px;
    font-size: 14px;
    border: 1px solid #ccc;
    border-radius: 4px;" id="group-leader" name="group_leader" required>
                <option value="">Select Group Leader</option>
                <?php
                // Display all therapists in the select option
                while ($therapist = $therapistsResult->fetch_assoc()) {
                    echo "<option value='" . htmlspecialchars($therapist['id']) . "'>" . htmlspecialchars($therapist['name']) . "</option>";
                }
                ?>
            </select>
                            </div>
                            <!-- Add more fields as needed -->
                        </div>
                        <!-- Group members list and other data -->
                        <div class="group-editor">
                  <div class="add-group-members-section">
                      <label for="group-member">Group Member:</label>
                      <div class="alphabet-pagination" id="alphabet-pagination"></div>
                      <div class="therapist-info-patient-list care-scroll">
                      <?php if (!empty($patients)): ?>
                        <?php foreach ($patients as $patient): ?>
                            <?php
                            // Check if this patient belongs to the group
                            $isSelected = in_array($patient['id'], $assignedPatients) ? 'patient-item-selected' : '';
                            ?>
                            <div onclick="toggleSelection(this)" data-patient-id="<?= htmlspecialchars($patient['id']) ?>" data-patient-name = "<?= htmlspecialchars($patient['name']) ?>" class="therapist-info-patient-item <?= $isSelected ?>">
                                <img src="<?= htmlspecialchars($patient['photo']) ?>" alt="Patient Picture" onerror="this.src='assets/head.jpeg'" loading="lazy" >
                                <div class="therapist-info-patient-info">
                                    <h4>Patient ID: <?= htmlspecialchars($patient['id']) ?></h4>
                                    <h4><?= htmlspecialchars($patient['name']) ?></h4>
                                </div>
                                <!-- <input type="checkbox" 
                                onclick="toggleCheckboxSelection(this)
                                "class="therapist-info-patient-checkbox" <?= $isSelected ? 'checked' : '' ?>> -->
                            </div>
                        <?php endforeach; ?>
                    <?php else: ?>
                        <p>No patients found.</p>
                    <?php endif; ?>
                    </div>
                  </div>
                </div>
                    </div>
            </div>
            </div>
        </div>
    </div>
    <script>

        function toggleSelection(element) {
            // Toggle the class 'patient-item-selected'
            element.classList.toggle('patient-item-selected');

            // Find the checkbox within the clicked item and toggle its 'checked' property
            var checkbox = element.querySelector('.therapist-info-patient-checkbox');
            checkbox.checked = !checkbox.checked;
        }

        function toggleCheckboxSelection(checkbox) {
            // Get the parent div of the checkbox (the 'therapist-info-patient-item')
            var parentElement = checkbox.closest('.therapist-info-patient-item');
            
            // Toggle the 'patient-item-selected' class based on the checkbox state
            if (checkbox.checked) {
                parentElement.classList.add('patient-item-selected');
            } else {
                parentElement.classList.remove('patient-item-selected');
            }
        }

        var btn = document.getElementById("assignPatient");
        btn.addEventListener('click', function(event) {
          event.preventDefault(); // Prevent the default action of redirecting immediately

          const groupName = document.querySelector('#group-name').value;
          const groupLeader = document.querySelector('#group-leader').value;



          // Collect the assigned patients
          let assignedPatients = [];
          document.querySelectorAll('.patient-item-selected').forEach(function(patientItem) {
            assignedPatients.push(patientItem.getAttribute('data-patient-id')); // Get the patient ID from the data-patient-id attribute
        });

        // Check for required fields
        if (!groupName || !groupLeader) {
            alert("Please fill in the group name and select a leader.");
            return;
        }

        // Send the data to the server via fetch
        fetch('requests/add-group.php', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                groupName: groupName,
                groupLeader: groupLeader,
                assignedPatients: assignedPatients
            })
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                // After successful group and patients insertion, redirect to initial meeting page
                const groupId = data.groupId; // Get the inserted group ID from the response
                window.location.href = `initial-group.php?group=${groupId}`;
            } else {
                alert("Failed to create group. Please try again.");
            }
        })
        .catch(error => {
            console.error('Error:', error);
        });



          // Group ID
        //   let groupId = ; // Embed the PHP groupId into JavaScript

        //   // Send the assigned patients data to the server to save
        //   fetch('requests/save_assigned_patients.php', {
        //       method: 'POST',
        //       headers: {
        //           'Content-Type': 'application/json'
        //       },
        //       body: JSON.stringify({
        //           group_id: groupId,
        //           assigned_patients: assignedPatients
        //       })
        //   })
        //   .then(response => response.json())
        //   .then(data => {
        //       if (data.success) {
        //           // Redirect to the new page after saving successfully
        //           window.location.href = 'initial-group.php?group=' + groupId;
        //       } else {
        //           alert('Failed to save the changes.');
        //       }
        //   })
        //   .catch(error => {
        //       console.error('Error:', error);
        //       alert('An error occurred while saving the changes.');
        //   });
      });

      const alphabetContainer = document.getElementById('alphabet-pagination');
      const alphabet = "All,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z".split(',');
      const maxDisplay = 5; // Max visible buttons on either side
      let activeLetter = 'All';

      function createAlphabetPagination(selectedLetter) {
          alphabetContainer.innerHTML = ''; // Clear the previous content

          alphabet.forEach((letter, index) => {
              if (shouldShowLetter(index, selectedLetter)) {
                  const button = document.createElement('button');
                  button.textContent = letter;
                  button.classList.toggle('active', letter === selectedLetter);
                  button.onclick = () => {
                      activeLetter = letter;
                      createAlphabetPagination(activeLetter);
                      const patientItems = document.querySelectorAll('.therapist-info-patient-item');
                      if (activeLetter !== 'All') {
                        patientItems.forEach(function(item) {
                            const patientName = item.getAttribute('data-patient-name').toLowerCase();
                            
                            // Check if the patient's name includes the filter value
                            if (patientName.startsWith(activeLetter.toLocaleLowerCase())) {
                                item.style.display = '';  // Show the item
                            } else {
                                item.style.display = 'none';  // Hide the item
                            }
                        });
                      } else {
                        patientItems.forEach(function(item) {
                            item.style.display = '';
                        });
                      }

                      
                  };
                  alphabetContainer.appendChild(button);
              } else if (index === 4 || index === alphabet.length - 5) {
                  const ellipsis = document.createElement('span');
                  ellipsis.textContent = '...';
                  ellipsis.classList.add('ellipsis');
                  alphabetContainer.appendChild(ellipsis);
              }
          });

          const searchIconContainer = document.createElement('div');
          searchIconContainer.innerHTML = `
              <svg class="icon" style='cursor: pointer;width: 18px;height: 18px' aria-hidden="true">
                  <use xlink:href="#icon-search"></use>
              </svg>`;
          alphabetContainer.appendChild(searchIconContainer);
      }

      function shouldShowLetter(index, selectedLetter) {
          const activeIndex = alphabet.indexOf(selectedLetter);
          return (
              index === 0 || // Always show A
              index === alphabet.length - 1 || // Always show Z
              index === activeIndex || // Always show the active letter
              index === activeIndex - 1 || // Show one before the active
              index === activeIndex + 1 || // Show one after the active
              (index > 0 && index < 4) || // Always show B and C
              (index > alphabet.length - 5 && index < alphabet.length - 1) // Always show Y and X
          );
      }

      // Initialize with 'A' as the active letter
      createAlphabetPagination(activeLetter);
    </script>
</body>
</html>
