<?php
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Therapist Management</title>
    <link rel="stylesheet" href="/components/modal/index.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="/css/index.css">
    <link rel="stylesheet" href="index.css">
    <link rel="stylesheet" href="/components/pagination/index.css">
    <link rel="stylesheet" href="/components/filter/index.css">
    <link href="/components/loading/index.css" rel="stylesheet">
    <script src="/components/icon/index.js"></script>
</head>
<body>
  <?php
    // PHP variables or database queries to replace static data
    $therapists = [
      [
        'id' => '001',
        'name' => 'Dr. Olivia Turner',
        'email' => 'olivia.turner@example.com',
        'group' => 'Group 1',
        'field' => 'Psychologist',
        'status' => 'Online'
      ],
      [
        'id' => '002',
        'name' => 'Dr. John Smith',
        'email' => 'john.smith@example.com',
        'group' => 'Group 2',
        'field' => 'Psychiatrist',
        'status' => 'Rest'
      ]
    ];
  ?>

  <header class="nav-bar">
    <div class="nav-logo">
        <img src="/assets/Component 2.png" alt="Website Logo" class="logo">
    </div>
    <div class="nav-items">
        <span class="icon notification-icon"><img src="/assets/Notification.png" alt="Notifications"></span>
        <span class="icon message-icon"><img src="/assets/Message.png" alt="Messages"></span>
        <div class="user-info">
            <img src="/assets/doc0.jpeg" alt="User Avatar" class="user-avatar">
            <div class="user-details">
                <span class="user-name">Austin Robertson</span>
                <span class="user-role">Marketing Administrator</span>
            </div>
        </div>
    </div>
  </header>

  <aside class="side-menu">
    <nav>
        <ul>
            <!-- Home Button -->
            <li class="menu-item">
                <svg class="icon menu-icon" aria-hidden="true">
                    <use xlink:href="#icon-home"></use>
                </svg>
                <span class="menu-text">Home</span>
            </li>
            <!-- Group 1: Pages -->
            <span class="menu-group-title">Pages</span>
            <li class="menu-item active">
                <svg class="icon menu-icon" aria-hidden="true">
                    <use xlink:href="#icon-game"></use>
                </svg>
                <span class="menu-text">Therapist</span>
                <svg class="icon" aria-hidden="true">
                    <use xlink:href="#icon-arrow"></use>
                </svg>
            </li>
            <li class="menu-item">
                <svg class="icon menu-icon" aria-hidden="true">
                    <use xlink:href="#icon-patient"></use>
                </svg>
                <span class="menu-text">Patient</span>
                <svg class="icon" aria-hidden="true">
                    <use xlink:href="#icon-arrow"></use>
                </svg>
            </li>
            <li class="menu-item">
                <svg class="icon menu-icon" aria-hidden="true">
                    <use xlink:href="#icon-group"></use>
                </svg>
                <span class="menu-text">Group</span>
                <svg class="icon" aria-hidden="true">
                    <use xlink:href="#icon-arrow"></use>
                </svg>
            </li>
            <li class="menu-item">
                <svg class="icon menu-icon" aria-hidden="true">
                    <use xlink:href="#icon-schedule"></use>
                </svg>
                <span class="menu-text">Appointment</span>
                <svg class="icon" aria-hidden="true">
                    <use xlink:href="#icon-arrow"></use>
                </svg>
            </li>
            <li class="menu-item">
                <svg class="icon menu-icon" aria-hidden="true">
                    <use xlink:href="#icon-authentication"></use>
                </svg>
                <span class="menu-text">Authentication</span>
                <svg class="icon" aria-hidden="true">
                    <use xlink:href="#icon-arrow"></use>
                </svg>
            </li>
            <li class="menu-item">
                <svg class="icon menu-icon" aria-hidden="true">
                    <use xlink:href="#icon-setting"></use>
                </svg>
                <span class="menu-text">Setting</span>
                <svg class="icon" aria-hidden="true">
                    <use xlink:href="#icon-arrow"></use>
                </svg>
            </li>
            <!-- Other items... -->
            <hr class="menu-divider">
            <!-- Group 2: Elements -->
            <span class="menu-group-title">Elements</span>
            <li class="menu-item">
                <img src="/assets/components-icon.svg" alt="Components Icon" class="menu-icon">
                <span class="menu-text">Components</span>
                <svg class="icon" aria-hidden="true">
                    <use xlink:href="#icon-arrow"></use>
                </svg>
            </li>
            <li class="menu-item">
                <img src="/assets/form-icon.svg" alt="Form Icon" class="menu-icon">
                <span class="menu-text">Form</span>
                <svg class="icon" aria-hidden="true">
                    <use xlink:href="#icon-arrow"></use>
                </svg>
            </li>
            <!-- Other items... -->
        </ul>
    </nav>
  </aside>

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
        <button class="operation-btn add-bt">Add +</button>
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
                <div class="dropdown-option" data-value="Group 1">Group 1</div>
                <div class="dropdown-option" data-value="Group 2">Group 2</div>
                <div class="dropdown-option" data-value="Group 3">Group 3</div>
                <div class="dropdown-option" data-value="Group 4">Group 4</div>
            </div>
          </div>
        </div>
        <div class="filter-item">
          <div class="dropdown">
              <div class="dropdown-selected" data-default="Field">Field</div>
              <div class="dropdown-options">
                  <div class="dropdown-option" data-value="Field 1">Field 1</div>
                  <div class="dropdown-option" data-value="Field 2">Field 2</div>
                  <div class="dropdown-option" data-value="Field 3">Field 3</div>
                  <div class="dropdown-option" data-value="Field 4">Field 4</div>
                  <div class="dropdown-option" data-value="Field 5">Field 5</div>
                  <div class="dropdown-option" data-value="Field 6">Field 6</div>
                  <!-- Other options -->
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
                <?php foreach ($therapists as $therapist): ?>
                  <tr>
                      <td><?php echo htmlspecialchars($therapist['id']); ?></td>
                      <td><?php echo htmlspecialchars($therapist['name']); ?></td>
                      <td><?php echo htmlspecialchars($therapist['email']); ?></td>
                      <td><?php echo htmlspecialchars($therapist['group']); ?></td>
                      <td><?php echo htmlspecialchars($therapist['field']); ?></td>
                      <td><?php echo htmlspecialchars($therapist['status']); ?></td>
                      <td><button class="btn btn-primary">View</button></td>
                  </tr>
                <?php endforeach; ?>
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
                                <img src="/assets/doc2.jpeg" alt="Therapist Picture">
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
                                    <img src="/assets/head.jpeg" alt="Patient Picture">
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
                                <img src="/assets/certification2.png" alt="Certificate Image">
                                <p>The Psychiatrist's Guide to Population Management of Diabetes</p>
                            </div>
                            <div class="therapist-info-certificate-item">
                                <img src="/assets/certification1.png" alt="Certificate Image">
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
                                            <img src="/assets/patient_male.png" alt="Group Icon">
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
                                            <img src="/assets/patient_male.png" alt="Group Icon">
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
  <script src="https://cdn.jsdelivr.net/npm/echarts/dist/echarts.min.js"></script>
  <script src="/components/modal/confirm.js"></script>
  <script src="/components/pagination/index.js"></script>
  <script src="index.js"></script>  
  
  <script src="/components/siderBar/index.js"></script>
</body>
</html>