<?php
// 启动会话（如果需要身份验证）
session_start();

// 检查用户是否已登录
if (!isset($_SESSION['logged_in'])) {
    header('Location: login.php');
    exit();
}

// 设置页面的一些动态变量
$user_name = "Administrator 1107";
$user_group = "Professional Staff";

?>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Home</title>
  <link href="components/siderBar/index.css" rel="stylesheet">
  <link href="components/nav/index.css" rel="stylesheet">
	<link href="components/dropdown/index.css" rel="stylesheet">
  <link href="css/index.css" rel="stylesheet">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body class="light-theme">
	<div class="page-container">
		<div class="parent-container">
			<div class="menu-container">
				<a class="menu-item">
					<img src="https://instructure-uploads-apse2.s3.ap-southeast-2.amazonaws.com/account_230630000000000001/attachments/643/flinders-logo.jpeg" alt="User" class="circle-image">
					<span class="menu-text">The CaRe</span>
				</a>
				<div class="menu-group">
					<a class="menu-item selected" href="#home" data-href="pages/admin/index/index.html">
						<span class="menu-icon" data-icon="dashboard"></span>
						<span class="menu-text">Home</span>
					</a>
					<a class="menu-item" href="#therapist-management" data-href="pages/admin/therapist/index.html">
						<span class="menu-icon" data-icon="search"></span>
						<span class="menu-text">Therapist</span>
					</a>
					<a class="menu-item" href="#patient-management">
						<span class="menu-icon" data-icon="insights"></span>
						<span class="menu-text">Patient</span>
					</a>
					<!-- 继续其他菜单项 -->
				</div>
				<a class="menu-item menu-bottom-button" href="#none">
					<span class="menu-icon" data-icon="settings"></span>
					<span class="menu-text">Settings</span>
				</a>
			</div>
		</div>

		<div class="right-container">
			<nav class="nav-bar">
				<span>Welcome!</span>
				<span class="nav-item user-info"><?php echo $user_name; ?></span>
				<span>Group: <?php echo $user_group; ?></span>
			</nav>

			<div class="content-display">
				<div id="loading-mask" class="loading-mask">
					<div class="spinner"></div>
				</div>
				<iframe name="content-frame" frameborder="0"></iframe>				
			</div>
		</div>
	</div>

	<script src="components/icon/index.js"></script>
	<script src="components/dropdown/index.js"></script>
	<script src="components/siderBar/index.js"></script>

	<script>
		document.addEventListener("DOMContentLoaded", function() {
			// JavaScript 逻辑，保持原有功能
		});
	</script>
</body>
</html>
