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
    <link rel="stylesheet" href="/components/filter/index.css">
    <link href="/components/pagination/index.css" rel="stylesheet">
    <link href="/components/statusBar/index.css" rel="stylesheet">
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
        'field' => 'Psychologist'
      ],
      [
        'id' => '002',
        'name' => 'Dr. John Smith',
        'email' => 'john.smith@example.com',
        'field' => 'Psychiatrist'
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
            <li class="menu-item">
                <svg class="icon menu-icon" aria-hidden="true">
                    <use xlink:href="#icon-home"></use>
                </svg>
                <span class="menu-text">Home</span>
            </li>
            <span class="menu-group-title">Pages</span>
            <li class="menu-item">
                <svg class="icon menu-icon" aria-hidden="true">
                    <use xlink:href="#icon-game"></use>
                </svg>
                <span class="menu-text">Therapist</span>
                <svg class="icon" aria-hidden="true">
                    <use xlink:href="#icon-arrow"></use>
                </svg>
            </li>
            <li class="menu-item ">
                <svg class="icon menu-icon" aria-hidden="true">
                    <use xlink:href="#icon-patient"></use>
                </svg>
                <span class="menu-text">Patient</span>
                <svg class="icon" aria-hidden="true">
                    <use xlink:href="#icon-arrow"></use>
                </svg>
            </li>
            <li class="menu-item active">
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
            <hr class="menu-divider">
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
        </ul>
    </nav>
  </aside>

  <div class="content">
    <div class="bread-bar">
        <div class="link">
          Group management >
        </div>
        <div class="announcement">
            <svg class="icon arrow-icon" aria-hidden="true">
                <use xlink:href="#icon-announcement"></use>
            </svg>
            <span style="margin-left: 4px;">announcement</span>
        </div>
    </div>

    <div class="filter-section">
      <div class="search-container">
        <input type="text" class="search-input" placeholder="Search ID or Name">
      </div>
      <div class="filter-bar">
        <div class="filter-item">
            <div class="filter-icon"></div>
            <span style="font-weight: 600;">Filter By</span>
        </div>
        <div class="filter-item">
          <div class="dropdown">
            <div class="dropdown-selected" data-default="Leader">Leader</div>
            <div class="dropdown-options" id = 'leader-dropdown'>
            </div>
          </div>
        </div>
        <div class="filter-item">
          <div class="dropdown">
              <div class="dropdown-selected" data-default="Creation">Creation</div>
              <div class="dropdown-options">
                  <div class="dropdown-option" data-value="Last 7 days">Last 7 days</div>
                  <div class="dropdown-option" data-value="Last 30 days">Last 30 days</div>
                  <div class="dropdown-option" data-value="Last 365 days">Last 365 days</div>
              </div>
          </div>
        </div>
        <div class="filter-item">
          <div class="dropdown">
              <div class="dropdown-selected" data-default="Status">Status</div>
              <div class="dropdown-options">
                  <div class="dropdown-option" data-value="Active">Active</div>
                  <div class="dropdown-option" data-value="On hold">On hold</div>
                  <div class="dropdown-option" data-value="Discharged">Discharged</div>
              </div>
          </div>
        </div>
        <div class="filter-item reset-filter" style="justify-content: center; cursor: pointer;">
            <div class="reset-icon"></div>
            <span class="reset-text">Reset Filter</span>
        </div>
      </div>
    </div>

    <div class="group-table-container">
      <div class="loading-spinner" id="loading-spinner"></div>
      <table class="styled-table">
        <thead>
            <tr>
                <th>Group</th>
                <th>Number of Members</th>
                <th>Group Leader</th>
                <th>Assigned Patients</th>
                <th>Creation Date</th>
                <th>Status</th>
                <th>Operations</th>
            </tr>
        </thead>
        <tbody id="table-content"></tbody>
      </table>
      <div id="pagination-container" class="pagination"></div>
    </div>
  </div>

  <div class="bottom-info">
    <span>Privacy Policy</span>
    <span style="margin-left: 3rem;">Terms of Use</span>
  </div>

  <script src="/components/table/index.js"></script>
  <script src="/components/modal/index.js"></script>
  <script src="/components/pagination/index.js"></script>
  <script src="index.js"></script>
  <script>
    function showModal1() {
      document.getElementById('therapistModal').style.display = 'block';
    }

    function hideModal() {
      document.getElementById('therapistModal').style.display = 'none';
    }

    document.getElementById('openModalButton').addEventListener('click', () => {
      showModal1();
    });
  </script>
</body>
</html>