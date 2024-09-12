<?php
// Start session
session_start();

// Database connection
$host = "localhost";
$dbname = "care"; // Change this to your actual database name
$username = "dbadmin"; // Database username
$password = "adminpassword"; // Database password

$conn = new mysqli($host, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $inputUsername = $_POST['username'];
    $inputPassword = $_POST['password'];

    // Check if fields are not empty
    if (!empty($inputUsername) && !empty($inputPassword)) {

        // Prepare the SQL statement
        $stmt = $conn->prepare("SELECT * FROM Therapists WHERE email = ?");
        $stmt->bind_param("s", $inputUsername);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows > 0) {
            $user = $result->fetch_assoc();

            // Verify the password (password is hashed in DB)
            if (password_verify($inputPassword, $user['password'])) {
                // Set session variables
                $_SESSION['user_id'] = $user['id'];
                $_SESSION['username'] = $user['name'];

                // Redirect to the dashboard or another page
                header("Location: dashboard.php");
                exit();
            } else {
                $error = "Invalid password.";
            }
        } else {
            $error = "Invalid username.";
        }

        $stmt->close();
    } else {
        $error = "Please fill in both fields.";
    }

    $conn->close();
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CaRe-Therapist Login</title>
</head>
<body>
    <div class="login-container">
        <img src="assets/logo.png" class="logo" alt="CaRe Logo">
        <h2>CaRe-Administrator</h2>
        <p>Your Intelligent Health & Mood Companion.</p>
        
        <!-- Display error message if set -->
        <?php if (!empty($error)): ?>
            <p style="color: red;"><?= $error ?></p>
        <?php endif; ?>

        <form method="POST" action="">
            <input type="text" name="username" id="username" placeholder="ID" required>
            <span class="error-message" id="username-error">Please input your username!</span>

            <div class="password-container">
                <input type="password" name="password" id="password" placeholder="Password" required>
                <svg class="icon toggle-password" aria-hidden="true" onclick="togglePasswordVisibility()">
                    <use xlink:href="#icon-hide"></use>
                </svg>
            </div>
            <span class="error-message" id="password-error">Please input your password!</span>

            <button type="submit">Sign In →</button>
        </form>

        <div class="footer-links">
            <a href="#">Forgot Password?</a> | <a href="#">Need Help?</a>
        </div>
    </div>

    <script>
        // JavaScript to handle password visibility and form validation
    </script>
</body>
</html>
