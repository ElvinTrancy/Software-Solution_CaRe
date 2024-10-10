<?php
// Database connection settings
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "db";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Check if form is submitted
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Get form data
    $fullname = $_POST['fullname'];
    $email = $_POST['email'];
    $password = $_POST['password'];
    $confirm_password = $_POST['confirm_password'];

    // Basic validation
    if ($password != $confirm_password) {
        echo "<script>alert('Passwords do not match!');</script>";
    } else {
        // Hash the password
        $hashed_password = password_hash($password, PASSWORD_DEFAULT);

        // Insert data into database
        $sql = "INSERT INTO patients (fullname, email, password) VALUES (?, ?, ?)";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("sss", $fullname, $email, $hashed_password);

        if ($stmt->execute()) {
            echo "<script>alert('Sign up successful!'); window.location.href='sign-in.html';</script>";
        } else {
            echo "<script>alert('Error: " . $stmt->error . "');</script>";
        }

        $stmt->close();
    }
}

$conn->close();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CaRe - Sign Up</title>
    <link rel="stylesheet" href="Styles/styles3.css">
</head>
<body>
    <div class="container">
        <div class="header">
            <img src="images/welcome-logo.png" alt="CaRe Logo">
        </div>

        <form method="POST" action="">
            <div class="form">
                <label for="fullname"><strong>Full Name</strong></label>
                <div class="input-box">
                    <img src="images/user-icon.png" alt="User Icon" class="icon">
                    <input type="text" id="fullname" name="fullname" placeholder="John Doe" required>
                </div>

                <label for="email"><strong>Email Address</strong></label>
                <div class="input-box">
                    <img src="images/email-icon.png" alt="Email Icon" class="icon">
                    <input type="email" id="email" name="email" placeholder="xxx@gmail.com" required>
                </div>

                <label for="password"><strong>Password</strong></label>
                <div class="input-box">
                    <img src="images/lock-icon.png" alt="Lock Icon" class="icon">
                    <input type="password" id="password" name="password" placeholder="*************" required>
                    <img src="images/eye-icon.png" alt="Eye Icon" class="icon-right">
                </div>

                <label for="confirm-password"><strong>Confirm Password</strong></label>
                <div class="input-box">
                    <img src="images/lock-icon.png" alt="Lock Icon" class="icon">
                    <input type="password" id="confirm-password" name="confirm_password" placeholder="*************" required>
                    <img src="images/eye-icon.png" alt="Eye Icon" class="icon-right">
                </div>
            </div>

            <div class="buttons">
                <button type="submit" class="sign-up">Sign Up <span class="arrow">&rarr;</span></button>
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
            <p>Already have an account? <a href="sign-in.html">Sign In</a></p>
        </div>
    </div>
</body>
</html>