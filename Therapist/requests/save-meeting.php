<?php
include '../inc/dbconn.inc.php'; // Include the database connection

// Get the POST data
$data = json_decode(file_get_contents("php://input"), true);

$groupId = $data['group_id'];
$meetingDate = $data['meeting_date'];
$meetingTime = $data['meeting_time'];
$theme = $data['theme'];
$mode = $data['mode'];
$notification = $data['notification'];

// Prepare SQL to insert the new group meeting
$sql = "
    INSERT INTO GroupMeetings (group_id, meeting_date, meeting_time, theme, mode, notification) 
    VALUES (?, ?, ?, ?, ?, ?)
";

$stmt = $conn->prepare($sql);
$stmt->bind_param('isssss', $groupId, $meetingDate, $meetingTime, $theme, $mode, $notification);

if ($stmt->execute()) {
    // If successful, return a JSON response
    echo json_encode(['success' => true]);
} else {
    // Return an error response
    echo json_encode(['success' => false, 'error' => $conn->error]);
}

$stmt->close();
$conn->close();
?>
