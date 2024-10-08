<?php
require_once '../inc/dbconn.inc.php'; // Include your database connection file

if (isset($_POST['group_id']) && isset($_POST['note'])) {
    $group_id = intval($_POST['group_id']);
    $note = trim($_POST['note']);

    // Prepare the SQL query to insert the note
    $sql = "INSERT INTO groupnotes (group_id, note_text, note_date) VALUES (?, ?, NOW())";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param('is', $group_id, $note);

    if ($stmt->execute()) {
        echo json_encode(['success' => true]);
    } else {
        echo json_encode(['success' => false, 'error' => 'Failed to insert note.']);
    }

    $stmt->close();
} else {
    echo json_encode(['success' => false, 'error' => 'Missing group ID or note.']);
}
?>
