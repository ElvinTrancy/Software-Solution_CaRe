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
        // Check user credentials in the database
        $sql = "SELECT id, password FROM users WHERE email = ?";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param('s', $email);
        $stmt->execute();
        $result = $stmt->get_result();
        $user = $result->fetch_assoc();

        if ($user && password_verify($password, $user['password'])) {
            // Set session variables and redirect to home
            $_SESSION['user_id'] = $user['id'];
            header("Location: home.php");
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
    <link rel="stylesheet" href="Styles/styles4.css">
</head>
<body>
    <div class="container">
        <div class="header">
            <img src="images/welcome-logo.png" alt="CaRe Logo">
        </div>

        <!-- Input form -->
        <form method="POST" action="">
            <div class="form">
                <label for="email"><strong>Email Address</strong></label>
                <div class="input-box">
                    <img src="images/email-icon.png" alt="Email Icon" class="icon">
                    <input type="email" id="email" name="email" placeholder="Enter your email address..." required>
                </div>
                <div class="password-section">
                    <label for="password"><strong>Password</strong></label>
                    <a href="#" class="forget-password">Forget Password</a>
                </div>
                <div class="input-box">
                    <img src="images/lock-icon.png" alt="Lock Icon" class="icon">
                    <input type="password" id="password" name="password" placeholder="*************" required>
                    <img src="images/eye-icon.png" alt="Eye Icon" class="icon-right">
                </div>

                <!-- Error message -->
                <?php if (!empty($error_message)): ?>
                <div class="error-message">
                    <img src="images/error-icon.png" alt="Error Icon" class="error-icon">
                    <span><?php echo htmlspecialchars($error_message); ?></span>
                </div>
                <?php endif; ?>

                <div class="buttons">
                    <button type="submit" class="sign-in">Sign In <span class="arrow">→</span></button>
                </div>
            </div>
        </form>

        <div class="divider">
            <span>or</span>
        </div>

        <div class="social-icons">
            <a href="#"><img src="images/facebook.jpg" alt="Facebook"></a>
            <a href="#"><img src="images/google.jpg" alt="Google"></a>
            <a href="#"><img src="images/instagram.jpg" alt="Instagram"></a>
        </div>

        <div class="extra-link">
            <p>Don't have an account? <a href="signup.php">Sign Up</a></p>
        </div>
    </div>
</body>
</html>
