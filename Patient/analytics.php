<?php
// Start session
session_start();

// Include the database connection
include 'inc/dbconn.inc.php';

// Initialize default date range to 'last 7 days'
$date_range = '7';

// Handle the dropdown selection for different date ranges
if (isset($_GET['range'])) {
    $date_range = $_GET['range'] === '30' ? '30' : ($_GET['range'] === '60' ? '60' : '7');
}

// Fetch mood distribution data from the database based on the date range
$sql = "SELECT mood, COUNT(*) as count FROM mood_tracker 
        WHERE user_id = ? AND created_at >= DATE_SUB(CURDATE(), INTERVAL ? DAY) 
        GROUP BY mood";
$stmt = $conn->prepare($sql);
$stmt->bind_param('ii', $_SESSION['user_id'], $date_range);
$stmt->execute();
$mood_data = $stmt->get_result()->fetch_all(MYSQLI_ASSOC);

// Calculate mood percentages
$total_moods = array_sum(array_column($mood_data, 'count'));
$mood_percentages = [];
foreach ($mood_data as $data) {
    $mood_percentages[$data['mood']] = ($data['count'] / $total_moods) * 100;
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <link rel="stylesheet" href="Styles/Basical.css">
    <link rel="stylesheet" href="Styles/DataVis.css">
    <link rel="stylesheet" href="Styles/NagBar.css">
    <link rel="stylesheet" href="Styles/Select.css">
</head>
<body>
    <div class="container">
        <!-- Select time -->
        <div class="card">
            <form method="GET" action="">
                <select name="range" onchange="this.form.submit()">
                    <option value="7" <?php if ($date_range == '7') echo 'selected'; ?>>LAST 7 DAYS</option>
                    <option value="30" <?php if ($date_range == '30') echo 'selected'; ?>>LAST 30 DAYS</option>
                    <option value="60" <?php if ($date_range == '60') echo 'selected'; ?>>LAST 60 DAYS</option>
                </select>
            </form>
        </div>

        <!-- Mood Distribution -->
        <div class="container">
            <div class="card mood">
                <h2>Mood Distribution</h2>
                <div class="icons">
                    <?php if (isset($mood_percentages['happy'])): ?>
                    <div class="icon-item">
                        <div class="icon-content">
                            <img src="images/emotion-happy.png" alt="Happy face">
                            <div class="text-content">
                                <p>Optimism</p>
                                <p><?php echo round($mood_percentages['happy'], 2); ?>%</p>
                            </div>
                        </div>
                    </div>
                    <?php endif; ?>
                    <?php if (isset($mood_percentages['neutral'])): ?>
                    <div class="icon-item">
                        <div class="icon-content">
                            <img src="images/emotion-neutral.png" alt="Neutral face">
                            <div class="text-content">
                                <p>Pessimism</p>
                                <p><?php echo round($mood_percentages['neutral'], 2); ?>%</p>
                            </div>
                        </div>
                    </div>
                    <?php endif; ?>
                </div>
            </div>

            <!-- Daily Mood Distribution -->
            <div class="card mood">
                <h2>Daily Mood Distribution</h2>
                <div class="card-content">
                    <img src="images/mood-weekly-distribution.png" alt="Sleep Mode">
                </div>
            </div>
        </div>

        <!-- Navigation Bar -->
        <div class="nav-bar">
            <button>
                <a href="home.php">
                    <img src="images/home-icon.png" alt="Home">
                </a>
            </button>
            <button>
                <a href="analytics.php">
                    <img src="images/analytics-icon.png" alt="Analytics">
                </a>
            </button>
            <div class="center-btn">
                <button>
                    <a href="add.php">
                        <img src="images/add-icon.png" alt="Add">
                    </a>
                </button>
            </div>
            <button>
                <a href="services.php">
                    <img src="images/services-icon.png" alt="Services">
                </a>
            </button>
            <button>
                <a href="profile.php">
                    <img src="images/profile-icon.png" alt="Profile">
                </a>
            </button>
        </div>
    </div>
</body>
</html>
