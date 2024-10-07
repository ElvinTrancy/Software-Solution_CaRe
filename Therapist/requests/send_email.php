<?php
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // Get the POST data
    $email = $_POST['email'];
    $name = $_POST['name'];
    $subject = $_POST['subject'];
    $message = $_POST['message'];

    // Sanitize inputs
    $email = filter_var($email, FILTER_SANITIZE_EMAIL);
    $name = htmlspecialchars($name);
    $subject = htmlspecialchars($subject);
    $message = htmlspecialchars($message);

    // Prepare the email content
    $headers = "From: your-email@example.com\r\n";
    $headers .= "Reply-To: your-email@example.com\r\n";
    $headers .= "Content-Type: text/html; charset=UTF-8\r\n";

    // Send the email (You can also use PHPMailer or similar services)
    if (mail($email, $subject, $message, $headers)) {
        echo json_encode(['success' => true]);
    } else {
        echo json_encode(['success' => false, 'error' => 'Email sending failed.']);
    }
} else {
    echo json_encode(['success' => false, 'error' => 'Invalid request method.']);
}
?>
