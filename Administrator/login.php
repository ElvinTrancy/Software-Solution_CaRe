<?php
// Start session
session_start();

require_once 'inc/dbconn.inc.php';

// Sample password (this would typically come from a form or another input)
// $password = 'yourPassword123';

// // Hash the password using SHA-256
// $hashed_password = hash('sha256', $password);

// // Display the hashed password on the page
// echo "Hashed Password: " . htmlspecialchars($hashed_password);

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $inputUsername = $_POST['username'];
    $inputPassword = $_POST['password'];

    // Check if fields are not empty
    if (!empty($inputUsername) && !empty($inputPassword)) {

        // Prepare the SQL statement
        $stmt = $conn->prepare("SELECT * FROM auditors WHERE email = ?");
        $stmt->bind_param("s", $inputUsername);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows > 0) {
            $user = $result->fetch_assoc();
            $hashed_password = hash('sha256', $inputPassword);
            // Verify the password (password is hashed in DB)
            if ($hashed_password == $user['password']) {
                // Set session variables
                $_SESSION['user_id'] = $user['id'];
                $_SESSION['username'] = $user['name'];
                $_SESSION['email'] = $user['email'];
                $_SESSION['head'] = $user['photo'];

                // Redirect to the dashboard or another page
                header("Location: index.php");
                exit();
            } else {
                $error = "Invalid password.";
            }
        } else {
            $error = "Invalid username.";
        }

        $stmt->close();
    } else {
        $error = "Please fill in both fields.11";
    }

    $conn->close();
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CaRe-Administrator Login</title>
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
    <script src="components/icon/index.js"></script>
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

        <form method="POST" action="login.php">
            <input type="text" name="username" id="username" placeholder="Email" required>
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
        function togglePasswordVisibility() {
        const passwordInput = document.getElementById('password');
        const toggleIcon = document.querySelector('.toggle-password use');
        
        if (passwordInput.type === 'password') {
            passwordInput.type = 'text';
            toggleIcon.setAttribute('xlink:href', '#icon-show'); // Switch to show icon
        } else {
            passwordInput.type = 'password';
            toggleIcon.setAttribute('xlink:href', '#icon-hide'); // Switch to hide icon
        }
    }
    </script>
</body>
</html>
