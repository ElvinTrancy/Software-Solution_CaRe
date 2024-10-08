<?php
// 启动会话（如果需要）
session_start();

// 检查用户是否已登录，未登录则重定向到登录页面
if (!isset($_SESSION['logged_in'])) {
    header('Location: login.php');
    exit();
}

// 定义页面的变量
$user_name = "Austin Robertson";
$user_role = "Marketing Administrator";
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home-administrator</title>
    <link rel="stylesheet" href="css/index.css">
    <link rel="stylesheet" href="/components/modal/index.css">
    <script src="components/icon/index.js"></script>
</head>
<body>
  <header class="nav-bar">
    <div class="nav-logo">
        <img src="assets/Component 2.png" alt="Website Logo" class="logo">
    </div>
    <div class="nav-items">
        <span class="icon notification-icon"><img src="assets/Notification.png" alt="Notifications"></span>
        <span class="icon message-icon"><img src="assets/Message.png" alt="Messages"></span>
        <div class="user-info">
            <img src="assets/doc0.jpeg" alt="User Avatar" class="user-avatar">
            <div class="user-details">
                <span class="user-name"><?php echo $user_name; ?></span>
                <span class="user-role"><?php echo $user_role; ?></span>
            </div>
        </div>
    </div>
  </header>

  <aside class="side-menu">
    <nav>
        <ul>
            <!-- 动态生成菜单项 -->
            <li class="menu-item">
                <svg class="icon menu-icon" aria-hidden="true">
                    <use xlink:href="#icon-home"></use>
                </svg>
                <span class="menu-text">Home</span>
            </li>
            <span class="menu-group-title">Pages</span>
            <li class="menu-item">
                <svg class="icon menu-icon" aria-hidden="true">
                    <use xlink:href="#icon-game"></use>
                </svg>
                <span class="menu-text">Therapist</span>
                <svg class="icon" aria-hidden="true">
                    <use xlink:href="#icon-arrow"></use>
                </svg>
            </li>
            <!-- 继续动态生成其他菜单项... -->
        </ul>
    </nav>
  </aside>

  <div class="content">
    <div class="bread-bar">
        <div class="link">
            Welcome! <?php echo $user_name; ?>!
        </div>
        <div class="announcement">
            <svg class="icon arrow-icon" aria-hidden="true">
                <use xlink:href="#icon-announcement"></use>
            </svg>
            <span style="margin-left: 4px;">announcement</span>
        </div>
    </div>

    <!-- 统计区域 动态显示统计数据 -->
    <div class="statistic-area">
        <div class="statistic-item">
            <div class="progress">
                <div class="progress-circle" id="total-patients-progress">
                    <div class="progress-mask">
                        <svg class="icon arrow-icon" aria-hidden="true">
                            <use xlink:href="#icon-arrow-up"></use>
                        </svg>
                    </div>
                </div>
            </div>
            <div class="status-container">
                <div class="title">Total Patients</div>
                <div class="number">560K</div>
                <div class="rate">
                    <span>14.25%</span>
                    <div class="arrow"></div>
                </div>
            </div>
        </div>
        <!-- 继续添加其他统计项... -->
    </div>

    <div class="bottom-info">
        <span>Privacy Policy</span>
        <span style="margin-left: 3rem;">Terms of Use</span>
    </div>
  </div>

  <script src="js/calendar.js"></script>
  <script src="js/index.js"></script>
  <script src="js/data.js"></script>  
  <script src="/components/siderBar/index.js"></script>
</body>
</html>
