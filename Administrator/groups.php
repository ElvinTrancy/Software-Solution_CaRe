
<?php

session_start();

include 'inc/side.inc.php';
include 'inc/nav.inc.php';
include 'inc/dbconn.inc.php';

if (!isset($_SESSION['user_id'])) {
    header('Location: login.php');
    exit();
}

$sql = "SELECT * FROM groups";
    
$result = $conn->query($sql);
$groups = $result->fetch_all(MYSQLI_ASSOC);

$sql = "SELECT id, name, email, field, brief FROM therapists";
$result = $conn->query($sql);

// Initialize an array to hold therapist data
$therapistsData = array();

if ($result->num_rows > 0) {
    // Fetch each row and store it in the array
    while($row = $result->fetch_assoc()) {
        $therapistsData[] = $row;
    }
}

// Close the database connection
$conn->close();

// Encode the therapist data as JSON to pass it to JavaScript
$therapistsDataJson = json_encode($therapistsData);


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
    <link rel="stylesheet" href="pages/groups/index.css">   
    <link rel="stylesheet" href="components//filter/index.css">
    <link href="components/pagination/index.css" rel="stylesheet">
    <link href="components/statusBar/index.css" rel="stylesheet">
    <link href="components/loading/index.css" rel="stylesheet">
    <script src="components/icon/index.js"></script>
</head>
<body>

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

    <!-- <div class="list-name">Patients Lists</div> -->

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
 
  <script>
    const doctors = Object.values(<?php echo json_encode($therapistsData); ?>);
    const doctorNames = doctors.map(t => `${t.name}`);
    const mockGroupData = Object.values(<?php echo json_encode($groups); ?>);
  </script>
  <script src="https://cdn.jsdelivr.net/npm/echarts/dist/echarts.min.js"></script>
  <script src="components/modal/confirm.js"></script>
  <script src="components/pagination/index.js"></script>
  <script src="pages/groups/index.js"></script>
  
</body>
</html>
