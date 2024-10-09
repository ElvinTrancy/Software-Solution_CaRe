<?php
session_start(); // Start the session for user login

// Include the database connection file
require_once 'inc/dbconn.inc.php'; // Assuming this is the path to your dbconn.inc.php

// Initialize an empty error message
$error_message = "";

// When the form is submitted
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    if (isset($_POST['login_input']) && isset($_POST['password'])) {
        $login_input = $_POST['login_input']; // Could be either ID or Email
        $password = $_POST['password'];

        $hashed_password = hash('sha256', $password);

        // Check if the input is an ID (numeric) or an Email
        if (filter_var($login_input, FILTER_VALIDATE_EMAIL)) {
            // The input is an email
            $sql = "SELECT * FROM patients WHERE email = ? AND password = ?";
        } else {
            // The input is assumed to be an ID
            $sql = "SELECT * FROM patients WHERE id = ? AND password = ?";
        }

        $stmt = $conn->prepare($sql);
        $stmt->bind_param('ss', $login_input, $hashed_password);
        $stmt->execute();
        $result = $stmt->get_result();

        // Check if the patient exists
        if ($result->num_rows > 0) {
            // Login successful, redirect to dashboard
            $patient = $result->fetch_assoc(); // Fetch the patient record

            $_SESSION['patient_id'] = $patient['id']; // Store the patient ID in the session
            $_SESSION['patient_name'] = $patient['name']; // Store the patient's name for later use
            header("Location: home.php"); // Redirect to the dashboard page
            exit();
        } else {
            // Login failed
            $error_message = "Invalid ID/Email or password!";
        }

        $stmt->close();
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CaRe - Sign In</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/login.css">
</head>
<body>
    <div class="container">
        <!-- Form Section -->
        <div class="header">
            <img src="images/welcome-logo.png" alt="CaRe Logo">
        </div>

        <div class="form">
            <form method="POST" action="login.php">
                <label for="email"><strong>Email Address</strong></label>
                <div class="input-box">
                    <img src="images/email-icon.png" alt="Email Icon" class="icon">
                    <input type="text" id="login_input" name="login_input" placeholder="Enter your email address or ID..." required>
                </div>
                
                <label for="password"><strong>Password</strong></label>
                <div class="input-box">
                    <img src="images/lock-icon.png" alt="Lock Icon" class="icon">
                    <input type="password" id="password" name="password" placeholder="Enter your password" required>
                    <img src="images/eye-icon.png" alt="Eye Icon" class="icon-right">
                </div>

                <!-- Display error message if login fails and if the form was submitted -->
                <?php if ($_SERVER['REQUEST_METHOD'] == 'POST' && !empty($error_message)): ?>
                <div class="error-message">
                    <img src="images/error-icon.png" alt="Error Icon" class="error-icon">
                    <span><?php echo htmlspecialchars($error_message); ?></span>
                </div>
                <?php endif; ?>
                
                <button type="submit" class="sign-in">Sign In <span class="arrow">→</span></button>
            </form>
        </div>

        <!-- Social Media Links -->
        <div class="social-icons">
            <a href="#"><img src="images/facebook.jpg" alt="Facebook"></a>
            <a href="#"><img src="images/google.jpg" alt="Google"></a>
            <a href="#"><img src="images/instagram.jpg" alt="Instagram"></a>
        </div>
        
        <!-- Sign-up link -->
        <div class="extra-link">
            <p>Don't have an account? <a href="sign-up.php">Sign Up</a></p>
        </div>
    </div>
</body>
</html>
