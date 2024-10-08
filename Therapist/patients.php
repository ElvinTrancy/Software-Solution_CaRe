<?php
include 'inc/dbconn.inc.php'; // Include your database connection file
include 'inc/side.inc.php';   // Include any side components like sidebar


session_start();

// Check if therapist is logged in
if (!isset($_SESSION['therapist_id'])) {
  header('Location: login.php');
  exit;
}
// Fetch patients from the database
$patientsSql = "SELECT 
p.id AS id, 
p.name AS name, 
p.photo, 
MAX(g.name) AS group_name, 
MAX(d.name) AS disease_name
FROM Patients p
-- Join to get group information
LEFT JOIN grouppatient gp ON gp.patient_id = p.id
LEFT JOIN Groups g ON g.id = gp.group_id

-- Join to get disease information
LEFT JOIN patienttherapistdisease ptd ON ptd.patient_id = p.id
LEFT JOIN mentaldiseases d ON d.id = ptd.disease_id

GROUP BY p.id, p.name, p.photo;
"; // Modify this query according to your table structure
$result = $conn->query($patientsSql);
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
    
    <script src="components/icon/index.js"></script>
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
            <div class="main-section patient">
              <div class="patient-list">
                <h2>Patient list</h2>
                <div class="list-container">
                  <div class="alphabet-pagination" id="alphabet-pagination"></div>
                  <div class="list-content">
                    <div class="profile-list">
                    <?php
                      // Loop through patients and display them
                      if ($result->num_rows > 0) {
                          while($patient = $result->fetch_assoc()) {
                            echo '
                            <div class="profile-card" 
                                 onclick=\'showPatientDetails(' . json_encode($patient, JSON_HEX_TAG | JSON_HEX_APOS | JSON_HEX_QUOT | JSON_HEX_AMP) . ')\'>
                                <img loading="lazy" src="'  . htmlspecialchars($patient["photo"]) . '" alt="Patient" class="profile-avatar">
                                <div class="profile-details">
                                    <p class="profile-id">Patient ID: ' . htmlspecialchars($patient["id"]) . '</p>
                                    <p class="profile-name">' . htmlspecialchars($patient["name"]) . '</p>
                                    <p class="profile-group">Patient Group: ' . htmlspecialchars($patient["group_name"]) . '</p>
                                </div>
                                <button class="menu-button" onclick="showPatientMenu(event, ' . htmlspecialchars($patient["id"]) . ')">
                                    <i class="menu-icon" data-patient-id="'  . htmlspecialchars($patient["id"]) . '">&#x2630;</i> <!-- Unicode for the menu icon -->
                                </button>
                            </div>';
                          }
                      } else {
                          echo '<p>No patients found.</p>';
                      }
                      ?>
              
                  </div>
                  
                  </div>
                </div>
              </div>
              <div class="patient-detail" id="loading">
              </div>
              <div class="patient-detail" id="note" style="display: none;">
                <h2 class="note-header">Patient Note</h2>

                <!-- Text Area with character count -->
                <div class="note-input">
                    <textarea class="note-textarea" maxlength="250" placeholder="Type your note here..."></textarea>
                    <div class="character-count">
                        <span>0/250</span> <!-- Update dynamically as text is entered -->
                    </div>
                </div>
            
                <!-- Confirm Button -->
                <button class="confirm-btn" onclick="addNotes()">
                    Confirm <span class="btn-icon">➕</span>
                </button>
            
                <!-- Notes list -->
                <div class="note-list">
                    
                </div>
              </div>

              <div class="patient-detail" id="detail" style="display: none;">
                <h2 class="note-header">Patient Details</h2>
                <div class="profile-header">
                  <img src="assets/doc0.jpeg" alt="Patient" class="patient-photo">
                  <div class="profile-details">
                      <p class="profile-id pid">Patient ID: 001</p>
                      <p class="profile-name pna">Olivia Turner, M.D.</p>
                      <p class="profile-group png">Patient Group: Group1</p>
                      <p class="diagnostic">
                          Diagnostic:
                          <select>
                              <option value="somnipathy">Somnipathy</option>
                              <!-- Add more options if needed -->
                          </select>
                      </p>
                  </div>
              </div>
          
              <button class="treatment-record-btn" id="navigate-record">
                  Treatment Record <span class="btn-icon">➕</span>
              </button>
          
              <div class="block-wrapper">
                <div class="block">
                    <h3 class="section-header">Mood Distribution</h3>
                    <div class="mood-distribution">
                        <div class="mood-block optimism">
                            <svg class="icon" aria-hidden="true">
                                <use xlink:href="#icon-positive"></use>
                            </svg>
                            <div class="mood-desc">
                                <span>Optimism</span>
                                <span class="mood-op">90%</span>
                            </div>
                        </div>
                        <div class="mood-block pessimism">
                            <svg class="icon" aria-hidden="true">
                                <use xlink:href="#icon-negative"></use>
                            </svg>
                            <div class="mood-desc">
                                <span>Pessimism</span>
                                <span class="mood-pe">10%</span>
                            </div>
                        </div>
                    </div>
                </div>
            
                <div class="block">
                    <h3 class="section-header">Diet Status</h3>
                    <div class="diet-status">
                        <div class="diet-icon abalone"></div>
                        <div class="diet-icon apple"></div>
                        <div class="diet-icon apple"></div>
                    </div>
                </div>
            </div>
            
          
              <h3 class="section-header">Sleep Mode</h3>
              <div class="sleep-mode">
                <div class="sleep-chart">
                </div>
                  <div class="sleep-info">
                      <span id="sleep_hours">8 hour/Day</span>
                  </div>
              </div>
          
              <h3 class="section-header">Exercise Record</h3>
              <div class="exercise-record">
                <div class="exercise-chart"></div>
                  <div class="exercise-info">
                      <span class="fitness-level">0 hour/Day</span>
                  </div>
              </div>
              
            </div>
          </div>
      </div>
    </div>
    <script>
      let patientId = -1;
      function errLoad() {
        this.src='assets/head.jpeg';
      }

      function showPatientDetails(patient) {

        patientId = patient.id;
        // Populate the patient details div with selected patient data
        document.querySelector('.patient-photo').src = patient.photo || 'default_image.png'; // Use default if no photo
        document.querySelector('.pid').textContent = 'Patient ID: ' + patient.id;
        document.querySelector('.pna').textContent = patient.name;
        document.querySelector('.png').textContent = 'Patient Group: ' + (patient.group_name || 'No Group');
        
        // Update diagnostic dropdown
        const diagnosticSelect = document.querySelector('.diagnostic');
        diagnosticSelect.innerHTML = 'Diagnostic:' + (patient.disease_name || 'No Diagnosis'); 

        fetch('requests/getPatientDetails.php?patient_id=' + patientId)
        .then(response => response.json())
        .then(record => {
            if (record.error) {
                alert('Error: no record yet');

                document.querySelector('.mood-op').textContent = 'N/A';

              document.querySelector('.mood-pe').textContent = 'N/A';
              document.querySelector('.fitness-level').textContent = 'N/A';
              document.getElementById('sleep-hours').textContent = 'N/A';
              document.querySelector('.diet-status').textContent = 'Diet: ' + ('N/A');
                return;
            }
            // Update the DOM elements with the average data
            document.querySelector('.mood-op').textContent = record.mood != 0 ? (100 *record.optimism / record.mood).toFixed(0) + '%' : 'N/A';
            document.querySelector('.mood-pe').textContent = record.mood != 0 ? (100*record.pessimism / record.mood).toFixed(0) + '%' : 'N/A';
            document.querySelector('.fitness-level').textContent = record.fitness_level ? record.fitness_level.toFixed(1) + ' hour/Day' : 'N/A';
            document.getElementById('sleep-hours').textContent = record.sleep_hours ? record.sleep_hours + ' hours/day' : 'N/A';
            document.querySelector('.diet-status').textContent = 'Diet: ' + (record.diet || 'N/A');
        })
        .catch(error => console.error('Error fetching patient data:', error));

        // // Optionally update other daily records like mood, fitness level, etc.
        // document.querySelector('.mood-val').textContent = patient.mood;
        // document.querySelector('.fitness-level').textContent = patient.fitness_level;
        // document.querySelector('.sleep-hours').textContent =  patient.sleep_hours;
        // document.querySelector('.diet-status').textContent = 'Diet: ' + patient.diet;
    }

      function addNotes () {
        const noteText = document.querySelector('.note-textarea').value.trim();
        if (noteText === '') {
          alert('Please enter a note.');
          return;
        }

        if (noteText.length > 250) {
            alert('Note exceeds the character limit.');
            return;
        }

        fetch('requests/insert-note.php', {
          method: 'POST',
          headers: {
              'Content-Type': 'application/json'
          },
          body: JSON.stringify({ patient_id: patientId, note_text: noteText })
      })
      .then(response => response.json())
      .then(data => {
          if (data.success) {
            document.querySelector('.note-textarea').value = '';
            getNotes(patientId);
          } else {
              alert('Error adding note: ' + data.error);
          }
      })
      .catch(error => console.error('Error:', error));
      }

      function getNotes(patientId) {
        fetch(`requests/getPatientNotes.php?patient_id=${patientId}`)
            .then(response => response.json())
            .then(data => {
                const noteList = document.querySelector('.note-list');
                noteList.innerHTML = ''; // Clear existing notes

                data.notes.forEach(note => {
                    const noteItem = document.createElement('div');
                    noteItem.classList.add('note-item');

                    const noteDate = document.createElement('div');
                    noteDate.classList.add('note-date');
                    noteDate.innerHTML = `<span class="quote-icon">❝</span> ${note.date}`;

                    const noteText = document.createElement('div');
                    noteText.classList.add('note-text');
                    noteText.textContent = note.text;

                    noteItem.appendChild(noteDate);
                    noteItem.appendChild(noteText);
                    noteList.appendChild(noteItem);
                });
            })
            .catch(error => console.error('Error fetching notes:', error));
      }
      document.addEventListener('DOMContentLoaded', function() {



        const treatmentRecordBtn = document.getElementById('navigate-record');

        treatmentRecordBtn.addEventListener('click', function() {
            // Navigate to the 'record.html' page
            window.location.href = 'patients-record.php?patient_id=' + patientId;
        });


        const profileCards = document.querySelectorAll('.profile-card');

        const note = document.getElementById('note');
        const loading = document.getElementById('loading');
        const detail = document.getElementById('detail');
        // Add click event listener to each profile card
        profileCards.forEach(card => {
            card.addEventListener('click', function() {
                // Remove 'selected' class from all profile cards
                profileCards.forEach(c => c.classList.remove('selected'));
                menuIcons.forEach(i => i.classList.remove('selected'));
                // Add 'selected' class to the clicked card
                this.classList.add('selected');
                detail.style.display = 'flex';
                note.style.display = 'none';
                loading.style.display = 'none';
            });
        });
      const menuIcons = document.querySelectorAll('.menu-icon');

      

      

      menuIcons.forEach(icon => {
          icon.addEventListener('click', function(event) {
              event.stopPropagation();
              // Remove 'selected' class from all other icons
              menuIcons.forEach(i => i.classList.remove('selected'));

              patientId = this.getAttribute("data-patient-id");
              getNotes(patientId);

              // Toggle 'selected' class for the clicked icon
              this.classList.toggle('selected');
              detail.style.display = 'none';
              note.style.display = 'flex';
              loading.style.display = 'none';
          });
        });
      });

        const textarea = document.querySelector('.note-textarea');
        const characterCount = document.querySelector('.character-count span');

        textarea.addEventListener('input', () => {
            const currentLength = textarea.value.length;
            characterCount.textContent = `${currentLength}/250`;
        });

      // Get all menu-item elements
      const menuItems = document.querySelectorAll('.menu-item');
    
      // Add click event listener to each menu-item
      menuItems.forEach(item => {
        item.addEventListener('click', function() {
          // Remove 'active' class from all menu items
          menuItems.forEach(el => el.classList.remove('active'));
          
          // Add 'active' class to the clicked menu-item
          this.classList.add('active');
        });
      });
    </script>
    <script>
      const alphabetContainer = document.getElementById('alphabet-pagination');
      const alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('');
      const maxDisplay = 5; // Max visible buttons on either side
      let activeLetter = 'A';

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
          // const svg =  document.createElement('svg');
          
          // const use = document.createElement('use');
          // use.setAttribute('xlink:href', '#icon-search');
          // svg.appendChild(use);
          // svg.classList.add('icon');
          // svg.setAttribute('aria-hidden', 'true');
          // alphabetContainer.appendChild(svg);

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
    <script src="js/nav.js"></script>
</body>
</html>
