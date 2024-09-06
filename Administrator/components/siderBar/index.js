// 选择所有菜单项
const menuItems = document.querySelectorAll('.menu-item');

// 获取当前 URL 的路径和文件名
const currentPath = window.location.pathname;
const pathSegments = currentPath.split('/');

// 获取文件名或空字符串（如果是目录）
let currentFile = pathSegments[pathSegments.length - 1].toLowerCase();
let currentDir = pathSegments.length > 2 ? pathSegments[pathSegments.length - 2].toLowerCase() : '';

// 检查当前路径是否是主页
function isHome() {
  return currentPath === '/' || currentFile === 'index.html';
}

// 设置活动菜单项的函数
function setActiveMenu() {
  menuItems.forEach(item => {
    const menuText = item.querySelector('.menu-text').innerText.toLowerCase();

    // 仅当是主页时激活 'Home' 菜单项
    if (isHome() && menuText === 'home') {
      item.classList.add('active');
    } else if (!isHome() && (menuText === currentDir || menuText === currentFile.replace('.html', ''))) {
      // 根据当前目录或文件名匹配其他菜单项
      item.classList.add('active');
    } else {
      item.classList.remove('active'); // 移除未匹配的菜单项的 'active' 类
    }
  });
}

// 页面加载时调用函数，设置正确的活动菜单项
setActiveMenu();

// 处理点击事件，基于菜单文本进行导航
menuItems.forEach(item => {
  item.addEventListener('click', function() {
    const menuText = this.querySelector('.menu-text').innerText.toLowerCase();

    // 根据菜单文本映射到相应的页面
    let pageName = '';
    switch (menuText) {
      case 'home':
        pageName = '/'; // 主页 URL
        break;
      case 'therapist':
        pageName = '/pages/therapist/index.html';
        break;
      case 'patient':
        pageName = '/pages/patients/index.html';
        break;
      case 'group':
        pageName = '/pages/groups/index.html';
        break;
      case 'appointment':
        pageName = '/pages/appointment/index.html';
        break;
      default:
        break;
    }

    // 导航到对应的页面
    if (pageName) {
      window.location.href = pageName;
    }
  });
});
