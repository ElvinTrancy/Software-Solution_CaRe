<?php
// Start session
session_start();

// Include the database connection
include 'inc/dbconn.inc.php';

// Check if the form was submitted
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = $_POST['email'] ?? '';
    $password = $_POST['password'] ?? '';

    // Validate input
    if (empty($email) || empty($password)) {
        $error_message = "Please enter both email and password.";
    } else {
        // Prepare SQL query to check if the user exists
        $sql = "SELECT id, password FROM patients WHERE email = ?";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param('s', $email);
        $stmt->execute();
        $result = $stmt->get_result();
        $user = $result->fetch_assoc();

        if ($user && $password == $user['password']) {
            // Password is correct, log in the user
            $_SESSION['user_id'] = $user['id'];
            header("Location: dashboard.php");
            exit;
        } else {
            $error_message = "Invalid email or password.";
        }
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
            <form method="POST" action="">
                <label for="email"><strong>Email Address</strong></label>
                <div class="input-box">
                    <img src="images/email-icon.png" alt="Email Icon" class="icon">
                    <input type="email" id="email" name="email" placeholder="Enter your email address..." required>
                </div>
                
                <label for="password"><strong>Password</strong></label>
                <div class="input-box">
                    <img src="images/lock-icon.png" alt="Lock Icon" class="icon">
                    <input type="password" id="password" name="password" placeholder="Enter your password" required>
                    <img src="images/eye-icon.png" alt="Eye Icon" class="icon-right">
                </div>

                <!-- Display error message if login fails -->
                <?php if (!empty($error_message)): ?>
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

    <script src="JS/login.js"></script>
</body>
</html>
