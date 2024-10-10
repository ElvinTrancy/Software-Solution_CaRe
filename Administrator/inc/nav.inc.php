
<?php

$user_name = $_SESSION['username'];
$user_role = "Administrator";
$user_head = $_SESSION['head'];
?>



<header class="nav-bar">
    <div class="nav-logo">
        <img src="assets/Component 2.png" alt="Website Logo" class="logo">
    </div>
    <div class="nav-items">
        <span class="icon notification-icon"><img src="assets/Notification.png" alt="Notifications"></span>
        <span class="icon message-icon"><img src="assets/Message.png" alt="Messages"></span>
        <div class="user-info">
            <img onerror="this.src = 'assets/doc0.jpeg'" src="<?= htmlspecialchars($user_head) ?>" alt="User Avatar" class="user-avatar">
            <div class="user-details">
                <span class="user-name"><?= htmlspecialchars($user_name) ?></span>
                <span class="user-role"><?= htmlspecialchars($user_role) ?></span>
            </div>
        </div>
    </div>
  </header>