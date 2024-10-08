<?php
session_start();
require_once '../inc/dbconn.inc.php';

if (isset($_GET['group_id'])) {
  $groupId = intval($_GET['group_id']);

  // Fetch notes from the database for the given group
  $sql = "SELECT note_text, DATE_FORMAT(note_date, '%d–%b–%Y') AS note_date FROM GroupNotes WHERE group_id = ? ORDER BY note_id desc";
  $stmt = $conn->prepare($sql);
  $stmt->bind_param("i", $groupId);
  $stmt->execute();
  $result = $stmt->get_result();

  $notes = [];
  while ($row = $result->fetch_assoc()) {
      $notes[] = [
          'text' => $row['note_text'],
          'date' => $row['note_date']
      ];
  }

  // Return the notes as JSON
  echo json_encode(['notes' => $notes]);
  exit;
} else {
  echo json_encode(['error' => 'Group ID is required']);
  exit;
}
?>