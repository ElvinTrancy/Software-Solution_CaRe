<?php
// Define the current path and filename from the request URI
$currentPath = strtolower($_SERVER['REQUEST_URI']);
$pathSegments = explode('/', trim($currentPath, '/'));

$currentFile = !empty($pathSegments) ? strtolower(end($pathSegments)) : 'index.php'; // Default to index.php if no file
$currentDir = count($pathSegments) > 1 ? strtolower($pathSegments[count($pathSegments) - 2]) : '';

// Helper function to check if the current page is the home page
function isHome($currentPath) {
    return $currentPath === '/' || strpos($currentPath, 'index.php') !== false || empty($currentPath);
}

// Function to check and set the active menu
function isActiveMenu($menuText, $currentPath, $currentDir, $currentFile) {
    $menuText = strtolower($menuText);

    if (isHome($currentPath) && $menuText === 'home') {
        return 'active'; // Set 'Home' as active if it's the home page
    } elseif (strpos($currentDir, $menuText) !== false || strpos($currentFile, $menuText) !== false) {
        return 'active'; // Set active if the current directory or file matches
    }

    return ''; // Return an empty string if not active
}
?>

<aside class="side-menu">
    <nav>
        <ul>
            <!-- Home Button -->
            <li class="menu-item <?php echo isActiveMenu('home', $currentPath, $currentDir, $currentFile); ?>" onclick="window.location.href='index.php'">
                <svg class="icon menu-icon" aria-hidden="true">
                    <use xlink:href="#icon-home"></use>
                </svg>
                <span class="menu-text">Home</span>
            </li>

            <!-- Group 1: Pages -->
            <span class="menu-group-title">Pages</span>
            
            <li class="menu-item <?php echo isActiveMenu('therapist', $currentPath, $currentDir, $currentFile); ?>" onclick="window.location.href='therapist.php'">
                <svg class="icon menu-icon" aria-hidden="true">
                    <use xlink:href="#icon-game"></use>
                </svg>
                <span class="menu-text">Therapist</span>
                <svg class="icon" aria-hidden="true">
                    <use xlink:href="#icon-arrow"></use>
                </svg>
            </li>
            
            <li class="menu-item <?php echo isActiveMenu('patient', $currentPath, $currentDir, $currentFile); ?>" onclick="window.location.href='patients.php'">
                <svg class="icon menu-icon" aria-hidden="true">
                    <use xlink:href="#icon-patient"></use>
                </svg>
                <span class="menu-text">Patient</span>
                <svg class="icon" aria-hidden="true">
                    <use xlink:href="#icon-arrow"></use>
                </svg>
            </li>
            
            <li class="menu-item <?php echo isActiveMenu('group', $currentPath, $currentDir, $currentFile); ?>" onclick="window.location.href='groups.php'">
                <svg class="icon menu-icon" aria-hidden="true">
                    <use xlink:href="#icon-group"></use>
                </svg>
                <span class="menu-text">Group</span>
                <svg class="icon" aria-hidden="true">
                    <use xlink:href="#icon-arrow"></use>
                </svg>
            </li>
            
            <li class="menu-item <?php echo isActiveMenu('appointment', $currentPath, $currentDir, $currentFile); ?>" onclick="window.location.href='appointment.php'">
                <svg class="icon menu-icon" aria-hidden="true">
                    <use xlink:href="#icon-schedule"></use>
                </svg>
                <span class="menu-text">Appointment</span>
                <svg class="icon" aria-hidden="true">
                    <use xlink:href="#icon-arrow"></use>
                </svg>
            </li>
            
            <li class="menu-item <?php echo isActiveMenu('authentication', $currentPath, $currentDir, $currentFile); ?>" onclick="window.location.href='authentication.php'">
                <svg class="icon menu-icon" aria-hidden="true">
                    <use xlink:href="#icon-authentication"></use>
                </svg>
                <span class="menu-text">Authentication</span>
                <svg class="icon" aria-hidden="true">
                    <use xlink:href="#icon-arrow"></use>
                </svg>
            </li>
            
            <li class="menu-item <?php echo isActiveMenu('setting', $currentPath, $currentDir, $currentFile); ?>" onclick="window.location.href='setting.php'">
                <svg class="icon menu-icon" aria-hidden="true">
                    <use xlink:href="#icon-setting"></use>
                </svg>
                <span class="menu-text">Setting</span>
                <svg class="icon" aria-hidden="true">
                    <use xlink:href="#icon-arrow"></use>
                </svg>
            </li>
        </ul>
    </nav>
</aside>
