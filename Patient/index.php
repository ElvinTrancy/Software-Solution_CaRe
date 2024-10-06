<?php
// Start session for user login tracking
session_start();

// Check if user is already logged in
if (isset($_SESSION['user_id'])) {
    // Redirect to the dashboard if logged in
    header('Location: dashboard.php');
    exit;
}

// You can include any additional logic here, such as checking cookies for "Remember Me"
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome to CaRe</title>
    <link rel="stylesheet" href="Styles/styles.css">
</head>

<body>
    <div class="container">
        <a href="sign.php" style="text-decoration: none;">
            <div class="logo">
                <img src="images/care-logo.png" alt="CaRe Logo">
            </div>

            <div class="welcome-message">
                <h1>Welcome to<br><span class="highlight">CaRe</span></h1>
            </div>

            <div class="illustration">
                <img src="images/illustration.png" alt="Illustration">
            </div>
        </a>
    </div>
</body>

</html>
