<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Home</title>
  <link href="index.css" rel="stylesheet">
  <link href="/components/card/index.css" rel="stylesheet">
</head>
<body>
  <?php
    // Replace these values with dynamic PHP variables or fetch from a database
    $totalPatients = 8846;
    $patientsChange = 14.25;
    $totalTherapists = 55;
    $therapistChange = -8.01;
    $activeGroups = 170;
    $groupChange = 5.67;
    $activeGroupsToday = 10;
    $userAlerts = [
      'notifications' => 77,
      'messages' => 55
    ];

    // To Do List Data
    $todoList = [
      ['task' => 'Assign new patients to therapists', 'due' => '1 hour', 'assigned_to' => 'John Doe', 'color' => 'red'],
      ['task' => 'Meeting Preparation', 'due' => '3 hours', 'assigned_to' => 'Jane Smith', 'color' => 'yellow'],
      ['task' => 'Update Website', 'due' => '5 hours', 'assigned_to' => 'Tom Brown', 'color' => 'green']
    ];
  ?>

  <div class="home-page">   

    <!-- Dashboard Cards -->
    <div class="dashboard-cards">
        <div class="card-container">
            <div class="info-card w-4">
              <div class="card-header">
                  <span class="card-title">Total Patients</span>
                 