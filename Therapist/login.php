<?php
session_start(); // Start the session for user login

// Include the database connection file
require_once 'inc/dbconn.inc.php'; // Assuming this is the path to your dbconn.inc.php

// When the form is submitted
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $login_input = $_POST['login_input']; // Could be either ID or Email
    $password = $_POST['password'];

    // Check if the input is an ID (numeric) or an Email
    if (filter_var($login_input, FILTER_VALIDATE_EMAIL)) {
        // The input is an email
        $sql = "SELECT * FROM Therapists WHERE email = ? AND password = ?";
    } else {
        // The input is assumed to be an ID
        $sql = "SELECT * FROM Therapists WHERE id = ? AND password = ?";
    }

    $stmt = $conn->prepare($sql);
    $stmt->bind_param('ss', $login_input, $password);
    $stmt->execute();
    $result = $stmt->get_result();

    // Check if the therapist exists
    if ($result->num_rows > 0) {
        // Login successful, redirect to dashboard
        $therapist = $result->fetch_assoc(); // Fetch the therapist record
        $_SESSION['therapist_id'] = $therapist['id']; // Store the therapist ID in the session
        $_SESSION['therapist_name'] = $therapist['name']; // Store the therapist's name for later use
        header("Location: index.php"); // Redirect to the dashboard page
        exit();
    } else {
        // Login failed
        $error_message = "Invalid ID/Email or password!";
    }

    $stmt->close();
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CaRe-Therapist Login</title>
    <style>
        body {
          font-family: 'Inter', sans-serif;
          background-color: #f2f4f7;
          margin: 0;
          display: flex;
          justify-content: center;
          align-items: center;
          height: 100vh;
          position: relative;
          margin: 0;
          overflow: hidden; /* Prevents scrollbars */
        }

        body::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-image: url('assets/login_bg.png'); /* Adjust the path as needed */
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center center;
            background-attachment: fixed;
            opacity: 0.2; /* Transparency level */
            z-index: -1; /* Background is behind the content */
        }

        
        .logo {
          border-radius: 10px;
        }
        .login-container {
            width: 300px;
            background-color: #ffffff;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        .login-container img {
            width: 80px;
        }
        .login-container h2 {
          font-size: 36px;
          font-weight: 500;
            margin-bottom: 5px;
        }
        .login-container p {
            font-size: 1rem;
            color: #5D6A85;
            font-weight: 600;
        }
        .login-container input[type="text"], .login-container input[type="password"] {
            width: 100%; /* Make the input fields fit the width of their parent */
            box-sizing: border-box; /* Include padding and border in the element's total width and height */
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .login-container input.error {
            border-color: red; /* Red border on error */
        }
        .login-container span.error-message {
            color: red;
            font-size: 12px;
            display: none; /* Hidden by default */
            text-align: left;
            margin-top: 5px;
        }

        .login-container input[type="text"]:focus, .login-container input[type="password"]:focus {
            border-color: #3399ff; /* Blue border on focus */
            box-shadow: 0 0 5px rgba(51, 153, 255, 0.5); /* Subtle shadow effect */
            outline: none; /* Remove the default outline */
        }
        .login-container button {
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            border: none;
            color: white;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 10px;
            font-size: 16px;
        }
        .login-container button:hover {
            background-color: #0056b3;
        }
        .footer-links {
            margin-top: 20px;
            font-size: 12px;
        }
        .footer-links a {
            color: #007bff;
            text-decoration: none;
        }

        .password-container {
            position: relative;
        }
        .toggle-password {
          height: 16px;
          color: #ccc;
          width: 16px;
          position: absolute;
          right: 10px;
          top: 50%;
          transform: translateY(-50%);
          cursor: pointer;
          user-select: none; /* Prevents text selection */
          -webkit-user-select: none; /* Safari */
          -moz-user-select: none;    /* Firefox */
          -ms-user-select: none;     /* Internet Explorer/Edge */
        }
    </style>
    <script src="/components/icon/index.js"></script>
</head>
<body>
<div class="login-container">
        <img src="assets/logo.png" class="logo" alt="CaRe Logo">
        <h2>CaRe-Therapist</h2>
        <p>Your Intelligent Health & Mood Companion.</p>
        
        <?php if (isset($error_message)): ?>
            <p style="color: red;"><?php echo $error_message; ?></p>
        <?php endif; ?>

        <form method="POST" action="login.php">
            <input type="text" name="login_input" placeholder="ID or Email" id="login_input" required>
            <div class="password-container">
                <input type="password" name="password" placeholder="Password" id="password" required>
            </div>
            <button type="submit">Sign In →</button>
        </form>

        <div class="footer-links">
            <a href="#">Forgot Password?</a> | <a href="#">Need Help?</a>
        </div>
    </div>
</body>
</html>
