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
    <link rel="stylesheet" href="/css/calendar.css">
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
            <li class="menu-item ">
                <svg class="icon menu-icon" aria-hidden="true">
                    <use xlink:href="#icon-group"></use>
                </svg>
                <span class="menu-text">Group</span>
                <svg class="icon" aria-hidden="true">
                    <use xlink:href="#icon-arrow"></use>
                </svg>
            </li>
            <li class="menu-item active">
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
    <div class="therapist-page">
      <div style="display: flex; gap: 1rem;">
        <div class="input-search input-affix-wrapper">
          <input type="text" class="input" placeholder="Search therapist...">
          <span class="input-suffix">
            <i aria-label="icon: search" tabindex="-1" class="icon input-search-icon">
              <svg viewBox="64 64 896 896" data-icon="search" width="1em" height="1em" fill="currentColor" aria-hidden="true" focusable="false" class="">
                <path d="M909.6 854.5L649.9 594.8C690.2 542.7 712 479 712 412c0-80.2-31.3-155.4-87.9-212.1-56.6-56.7-132-87.9-212.1-87.9s-155.5 31.3-212.1 87.9C143.2 256.5 112 331.8 112 412c0 80.1 31.3 155.5 87.9 212.1C256.5 680.8 331.8 712 412 712c67 0 130.6-21.8 182.7-62l259.7 259.6a8.2 8.2 0 0 0 11.6 0l43.6-43.5a8.2 8.2 0 0 0 0-11.6zM570.4 570.4C528 612.7 471.8 636 412 636s-116-23.3-158.4-65.6C211.3 528 188 471.8 188 412s23.3-116.1 65.6-158.4C296 211.3 352.2 188 412 188s116.1 23.2 158.4 65.6S636 352.2 636 412s-23.3 116.1-65.6 158.4z"></path>
              </svg>
            </i>
          </span>
        </div>
        <button id="openModalButton" class="btn btn-primary btn-small" data-icon="left" data-loading="false">
          <span class="btn-text">New</span>
          <span class="loading-spinner"></span>
        </button>
      </div>

      <!-- Therapist Table -->
      <div id="table-container" style="margin-top: 1rem;background-color: #fff;">
        <table class="therapist-table">
          <thead>
            <tr>
              <th>ID</th>
              <th>Name</th>
              <th>Email</th>
              <th>Professional Field</th>
            </tr>
          </thead>
          <tbody>
            <?php foreach ($therapists as $therapist): ?>
              <tr>
                <td><?php echo htmlspecialchars($therapist['id']); ?></td>
                <td><?php echo htmlspecialchars($therapist['name']); ?></td>
                <td><?php echo htmlspecialchars($therapist['email']); ?></td>
                <td><?php echo htmlspecialchars($therapist['field']); ?></td>
              </tr>
            <?php endforeach; ?>
          </tbody>
        </table>
      </div>
    </div>
    <div id="pagination-container" class="pagination"></div>

    <!-- Modal Container -->
    <div id="therapistModal" class="custom-modal" style="width: 700px;">
      <div class="modal-header">
        <h2 class="modal-title">Therapist Details</h2>
        <button class="modal-close-btn" onclick="hideModal()">✖</button>
      </div>
      <div class="modal-body">
        <form id="therapistForm" class="therapist-form" autocomplete="off">
          <div class="left-column">
            <div class="form-group">
              <label for="photo">Photo:</label>
              <div style="display: flex; flex-direction: row; gap: 1rem;">
                <div class="file-upload-container" id="file-upload-container" style="flex: 1; position: relative; background-color: #f5f5f5;">
                  <input type="file" id="file-upload" accept="image/*" style="display: none;">
                  <div id="image-preview" class="image-preview" style="width: 100%; height: 100%; cursor: pointer; display: flex; align-items: center; justify-content: center;">
                    <span class="upload-placeholder">📤 Click to Upload</span>
                  </div>
                </div>
                <div style="display: flex; flex: 1; flex-direction: column; gap: 1rem;justify-content: flex-end;">
                  <button type="button" class="btn btn-small" id="add-pic-btn">Add pic</button>
                  <button type="button" class="btn btn-small" id="delete-pic-btn">Delete pic</button>
                </div>
              </div>
            </div>
            <div class="form-group">
              <label for="id">ID:</label>
              <input type="text" id="id" name="id" class="form-input" value="001" readonly>
            </div>
            <div class="form-group">
              <label for="name">Name:</label>
              <input type="text" id="name" name="name" class="form-input" placeholder="Enter name">
            </div>
            <div class="form-group">
              <label for="email">Email:</label>
              <input type="email" id="email" name="email" class="form-input" placeholder="Enter email">
            </div>
            <div class="form-group">
              <label for="field">Professional Field:</label>
              <select id="field" name="field" class="form-input dropdown">
                <option value="">Select a professional field</option>
                <option value="Psychiatrist">Psychiatrist</option>
                <option value="Psychologist">Psychologist</option>
              </select>
            </div>
            <div class="form-group">
              <label for="brief">Brief:</label>
              <input type="text" id="brief" name="brief" class="form-input" placeholder="Enter brief">
            </div>
          </div>
          <div class="right-column">
            <div class="certificate-container" style="height: 6rem;">
              <label for="certificate">Certificate:</label>
              <div class="certificate-upload" style="display: flex; flex-direction: row; height: 90%; gap: .25rem;">
                <div class="certificate-preview" style="flex: 6; position: relative; cursor: pointer;">
                  <img src="/assets/doc0.jpeg" style="width: 100%; height: 100%; object-fit: cover;" alt="Certificate Preview" class="certificate-image" id="certificate-image">
                  <input type="file" id="file-input" accept="image/*" style="display: none;">
                </div>
                <button style="flex: 1; height: 2.5rem;" type="button" class="btn btn-small">Add</button>
              </div>
            </div>
            <div class="ownership-container">
              <label>Ownership</label>
              <div class="ownership-details">
                <div class="group">
                  <span class="group-name">Expert Group</span>
                  <span class="group-info">: 18</span>
                  <button type="button" class="btn btn-small">Delete</button>
                  <div class="group-authority">
                    <a href="#">View patient information</a>
                    <a href="#">Edit patient data</a>
                    <a href="#">Create a patient group</a>
                  </div>
                </div>
                <div class="group">
                  <span class="group-name">Manager Group</span>
                  <span class="group-info">: 18</span>
                  <button type="button" class="btn btn-small">Delete</button>
                  <div class="group-authority">
                    <a href="#">View patient information</a>
                    <a href="#">Edit patient data</a>
                    <a href="#">Create a patient group</a>
                    <a href="#">Management system Settings</a>
                  </div>
                </div>
                <button type="button" class="btn btn-small">Add</button>
              </div>
            </div>
            <div class="form-group buttons" style="display: flex; flex-direction: row;gap: 1rem;">
              <button type="button" class="btn btn-default">Cancel</button>
              <button type="button" class="btn btn-primary">Save</button>
            </div>
          </div>
        </form>
      </div>
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