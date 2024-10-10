<?php
header('Content-Type: application/json'); // Set the response header for JSON

// Define the upload directory (you can change this path as needed)
$uploadDir = '../uploads/';

// Ensure the upload directory exists
if (!is_dir($uploadDir)) {
    mkdir($uploadDir, 0755, true);
}

// Initialize response data
$response = ['success' => false];

// Check if an audio file is uploaded
if (isset($_FILES['voice']) && $_FILES['voice']['error'] === UPLOAD_ERR_OK) {
    $voiceFile = $_FILES['voice'];
    $voiceFileName = basename($voiceFile['name']);
    $voiceFilePath = $uploadDir . $voiceFileName;

    // Move the uploaded file to the specified directory
    if (move_uploaded_file($voiceFile['tmp_name'], $voiceFilePath)) {
        $response['success'] = true;
        $response['filePath'] = $voiceFilePath; // Return the file path
    } else {
        $response['error'] = 'Error uploading audio file.';
    }
}

// Check if an image file is uploaded
if (isset($_FILES['camera']) && $_FILES['camera']['error'] === UPLOAD_ERR_OK) {
    $imageFile = $_FILES['camera'];
    $imageFileName = basename($imageFile['name']);
    $imageFilePath = $uploadDir . $imageFileName;

    // Move the uploaded file to the specified directory
    if (move_uploaded_file($imageFile['tmp_name'], $imageFilePath)) {
        $response['success'] = true;
        $response['filePath'] = str_replace("../", "", $imageFilePath); // Return the file path
    } else {
        $response['error'] = 'Error uploading image file.';
    }
}

// Output the response as JSON
echo json_encode($response);
?>
