<?php
// Database connection settings
require_once 'inc/dbconn.inc.php'; 

$name = $email  = $password = "";
$errorMessage = "";

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // Retrieve and sanitize form inputs
    $name = trim($_POST['name']);
    $email = filter_var(trim($_POST['email']), FILTER_SANITIZE_EMAIL);
   
    $password = trim($_POST['password']);
    $confirm_password = trim($_POST['confirm-password']);

    if (empty($confirm_password) || $confirm_password!= $password) {
        $errorMessage = "Repeat your password correctly";
    }
    if (empty($confirm_password) || $confirm_password!= $password) {
        $errorMessage = "Repeat your password correctly";
    } else if (empty($name) || empty($email) || empty($password)) {
        $errorMessage = "Please fill in all fields.";
    } elseif (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $errorMessage = "Invalid email format.";
    } else {
        // Hash the password using SHA256
        $hashed_password = hash('sha256', $password);

        // Check if the user already exists
        $checkUserSql = "SELECT * FROM patients WHERE email = ?";
        $stmt = $conn->prepare($checkUserSql);
        $stmt->bind_param('s', $email);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows > 0) {
            $errorMessage = "Email is already registered.";
        } else {
            // Insert the new patient into the database
            $signupSql = "INSERT INTO patients (name, email, password) VALUES (?, ?, ?)";
            $stmt = $conn->prepare($signupSql);
            $stmt->bind_param('sss', $name, $email, $hashed_password);

            if ($stmt->execute()) {
               
                header("Location: login.php");
                exit();
            } else {
                $errorMessage = "Error signing up. Please try again later.";
            }
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
    <title>CaRe - Sign Up</title>
    <link rel="stylesheet" href="Styles/styles3.css">
    <style>
        .error-message {
            display: flex;
            align-items: center;
            background-color: #fff1f0;
            border: 1px solid #ff4d4f;
            border-radius: 1vh;
            padding: 1.5vh 2vw;
            margin-top: 1vh;
            color: #ff4d4f;
            }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <img src="images/welcome-logo.png" alt="CaRe Logo">
        </div>

        <?php if (!empty($errorMessage)): ?>
            <div class="error-message">
                <p><?php echo $errorMessage; ?></p>
            </div>
        <?php endif; ?>

        <form method="POST" action="">
            <div class="form">
                <label for="fullname"><strong>Full Name</strong></label>
                <div class="input-box">
                    <img src="images/user-icon.png" alt="User Icon" class="icon">
                    <input type="text" id="name" name="name" value="<?php echo htmlspecialchars($name); ?>" required>
                </div>

                <label for="email"><strong>Email Address</strong></label>
                <div class="input-box">
                    <img src="images/email-icon.png" alt="Email Icon" class="icon">
                    <input type="email" id="email" name="email" value="<?php echo htmlspecialchars($email); ?>" required>
                </div>

                <label for="password"><strong>Password</strong></label>
                <div class="input-box">
                    <img src="images/lock-icon.png" alt="Lock Icon" class="icon">
                    <input type="password" id="password" name="password" required>
                    <img src="images/eye-icon.png" alt="Eye Icon" class="icon-right">
                </div>

                <label for="confirm-password"><strong>Confirm Password</strong></label>
                <div class="input-box">
                    <img src="images/lock-icon.png" alt="Lock Icon" class="icon">
                    <input type="password" id="confirm-password" name="confirm-password" required>
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