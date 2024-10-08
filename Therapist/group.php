<?php
// Include database connection and session check
include 'inc/dbconn.inc.php';
include 'inc/side.inc.php';

session_start();
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
    <style>
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
            <div class="main-section patient">
              <div class="patient-group">
                <h2>Patient Group List</h2>
                <div class="group-container">
                  <div class="group-search">
                    <div class="alphabet-pagination" id="alphabet-pagination"></div>
                    <button class="confirm-btn add" onclick="window.location.href = 'add-group.php'">
                      Add Group →
                    </button>

                    <div>
                    <?php
                               
                                $sql = "
                                  SELECT 
                                  g.id AS id, 
                                  g.name AS group_name, 
                                  g.leader AS group_leader, 
                                  g.number_of_members, 
                                  g.assigned_patients, 
                                  g.creation_date, 
                                  g.status, 
                                  g.head_img, 
                                  gm.meeting_date, 
                                  gm.meeting_time, 
                                  gm.theme, 
                                  gm.mode
                              FROM Groups g
                              LEFT JOIN (
                                  SELECT gm1.*
                                  FROM GroupMeetings gm1
                                  INNER JOIN (
                                      -- Subquery to get the latest meeting date for each group
                                      SELECT group_id, MAX(meeting_date) AS latest_meeting_date
                                      FROM GroupMeetings
                                      GROUP BY group_id
                                  ) gm2 ON gm1.group_id = gm2.group_id AND gm1.meeting_date = gm2.latest_meeting_date
                              ) gm ON g.id = gm.group_id
                              WHERE g.status = 'Active'
                              ;
                                ";

                                $result = $conn->query($sql);
                                $groupRecords = $result->fetch_all(MYSQLI_ASSOC);
                            ?>
                        <?php foreach ($groupRecords as $group): ?>
                            <div class="group-card" data-group-id="<?php echo htmlspecialchars($group['id']); ?>">
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
                                <div class="group-options" >
                                    <svg class="icon selectable-icon" aria-hidden="true" data-group-id="<?php echo htmlspecialchars($group['id']); ?>">
                                        <use xlink:href="#icon-menu"></use>
                                    </svg>
                                </div>
                            </div>
                        <?php endforeach; ?>

                    </div>
                    <!-- Additional group cards -->
                  </div>
                </div>
            </div>
            
            <div class="patient-detail" id="loading" style="display: flex;">
            </div>
              <div class="patient-detail" id="detail" style="display: none;">
                <h2 class="note-header">Group Note</h2>

                <!-- Text Area with character count -->
                <div class="note-input">
                    <input type="hidden" id="group-id" value="" />
                    <textarea class="note-textarea" maxlength="250" placeholder="Type your note here..."></textarea>
                    <div class="character-count">
                        <span>0/250</span> <!-- Update dynamically as text is entered -->
                    </div>
                </div>
            
                <!-- Confirm Button -->
                <button onclick="addNote()" class="confirm-btn">
                    Confirm <span class="btn-icon"> + </span>
                </button>
            
                <!-- Notes list -->
                <div class="note-list">
                    <div class="note-item">
                        <div class="note-date">
                            <span class="quote-icon">❝</span> 09–Sep–2024
                        </div>
                        <div class="note-text">
                            The therapists need to have the ability to record notes and observations of each patient they oversee, however, these notes should not be visible to the patient.
                        </div>
                    </div>
                    <!-- Additional notes -->
                </div>
              </div>
          </div>
      </div>
    </div>
    <script>


      function addNote() {
          const noteTextarea = document.querySelector('.note-textarea');
          const note = noteTextarea.value.trim();
          const groupId = document.getElementById('group-id').value;

          if (note === "") {
              alert("Please enter a note.");
              return;
          }

          // Make an AJAX request to add the note
          fetch('requests/addNote.php', {
              method: 'POST',
              headers: {
                  'Content-Type': 'application/x-www-form-urlencoded',
              },
              body: 'group_id=' + encodeURIComponent(groupId) + '&note=' + encodeURIComponent(note)
          })
          .then(response => response.json())
          .then(data => {
              if (data.success) {
                getNotes(groupId);
                  noteTextarea.value = ""; // Clear the textarea after successful addition
              } else {
                  alert("Failed to add note.");
              }
          })
          .catch(error => {
              console.error("Error adding note:", error);
              alert("An error occurred.");
          });
      }

      function getNotes(groupId) {
        fetch(`requests/getGroupNotes.php?group_id=${groupId}`)
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

                // Show the #detail div
                document.getElementById('detail').style.display = 'block';
            })
            .catch(error => console.error('Error fetching notes:', error));
      }

      document.addEventListener('DOMContentLoaded', function() {
        const groups = document.querySelectorAll('.group-card');
        groups.forEach(card => {
          card.addEventListener('click', function(e) {
            const groupId = e.currentTarget.getAttribute('data-group-id');
            window.location.href = `detailed-group.php?group=${groupId}`;
          });
        });

        var loading1 = document.getElementById('loading');
        var detail = document.getElementById('detail');
        document.querySelectorAll('.selectable-icon').forEach(icon => {
          icon.addEventListener('click', function(e) {
            e.stopPropagation();
            const groupId = e.currentTarget.getAttribute('data-group-id');
            document.getElementById('group-id').value = groupId;
            document.querySelectorAll('.selectable-icon').forEach(item => {
              item.classList.remove('selected');
            });
            this.classList.add('selected');
            loading1.style.display = 'none';
            detail.style.display = 'flex';
            getNotes(groupId);
          });
        });

        const menuIcons = document.querySelectorAll('.menu-icon');
        menuIcons.forEach(icon => {
          icon.addEventListener('click', function(event) {
              event.stopPropagation();
              menuIcons.forEach(i => i.classList.remove('selected'));
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

      const menuItems = document.querySelectorAll('.menu-item');
      menuItems.forEach(item => {
        item.addEventListener('click', function() {
          menuItems.forEach(el => el.classList.remove('active'));
          this.classList.add('active');
        });
      });
    </script>
    <script>
      const alphabetContainer = document.getElementById('alphabet-pagination');
      const alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('');
      const maxDisplay = 5;
      let activeLetter = 'A';

      function createAlphabetPagination(selectedLetter) {
          alphabetContainer.innerHTML = ''; 
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
      }

      function shouldShowLetter(index, selectedLetter) {
          const activeIndex = alphabet.indexOf(selectedLetter);
          return (
              index === 0 ||
              index === alphabet.length - 1 ||
              index === activeIndex ||
              index === activeIndex - 1 ||
              index === activeIndex + 1 ||
              (index > 0 && index < 4) ||
              (index > alphabet.length - 5 && index < alphabet.length - 1)
          );
      }

      createAlphabetPagination(activeLetter);
    </script>
    <script src="js/nav.js"></script>
</body>
</html>
