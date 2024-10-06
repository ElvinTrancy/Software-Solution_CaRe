<?php
// Include database connection and session check
include 'inc/dbconn.inc.php';
session_start();

// Check if therapist is logged in
if (!isset($_SESSION['therapist_id'])) {
    header('Location: login.php');
    exit;
}

// Check if the form was submitted
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Capture form data
    $group_name = $_POST['group-name'] ?? '';
    $group_study = $_POST['group-study'] ?? '';
    $selected_members = $_POST['selected_members'] ?? [];

    // Validate form data
    if (empty($group_name) || empty($group_study) || empty($selected_members)) {
        echo "Please fill in all required fields and select at least one group member.";
    } else {
        // Insert new group into the database
        $therapist_id = $_SESSION['therapist_id'];
        $sql = "INSERT INTO Groups (name, study, therapist_id, status) VALUES (?, ?, ?, 'Active')";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param('ssi', $group_name, $group_study, $therapist_id);
        $stmt->execute();
        $group_id = $conn->insert_id;

        // Insert selected members into GroupPatient table
        foreach ($selected_members as $member_id) {
            $sql = "INSERT INTO GroupPatient (group_id, patient_id) VALUES (?, ?)";
            $stmt = $conn->prepare($sql);
            $stmt->bind_param('ii', $group_id, $member_id);
            $stmt->execute();
        }

        // Redirect to the detailed group page
        header("Location: detailed-group.php?group_id=" . $group_id);
        exit;
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Group</title>
</head>
<body>
    <h2>Add New Group</h2>
    <form method="POST" action="">
        <label for="group-name">Group Name:</label>
        <input type="text" id="group-name" name="group-name" required>

        <label for="group-study">Group Study:</label>
        <input type="text" id="group-study" name="group-study" required>

        <label for="selected_members">Select Group Members:</label>
        <!-- Assume checkboxes for patients are dynamically generated from the database -->
        <div>
            <!-- Example checkbox structure -->
            <input type="checkbox" name="selected_members[]" value="101"> John Doe<br>
            <input type="checkbox" name="selected_members[]" value="102"> Jane Smith<br>
            <!-- More members go here -->
        </div>

        <button type="submit">Create Group</button>
    </form>
</body>
</html>
