// Function to add 'active' class to clicked menu item and navigate to 'data-href'
document.querySelectorAll('.menu-item').forEach(item => {
  item.addEventListener('click', function () {
      // Remove 'active' class from all items
      document.querySelectorAll('.menu-item').forEach(el => el.classList.remove('active'));

      // Add 'active' class to the clicked item
      this.classList.add('active');

      // Navigate to the URL specified in 'data-href'
      const href = this.getAttribute('data-href');
      if (href) {
          window.location.href = href;
      }
  });
});

// Function to maintain active state on page reload
window.addEventListener('DOMContentLoaded', () => {
  // Get the current file name from the URL (after the last '/')
  let currentFile = window.location.pathname.split('/').pop();

  // Handle the case where the URL is the root ("/"), which means index.html
  if (currentFile === '' || currentFile === '/') {
      currentFile = 'index.html';
  }

  currentFile = currentFile.replace('.html', '');

  // Find the menu item with the matching 'data-href'
  document.querySelectorAll('div.menu-item').forEach(item => {
      const href = item.getAttribute('data-href').replace('.html', '');
      if (href === currentFile || href.includes(currentFile) || currentFile.includes(href)) {
          // Add the 'active' class to the matching item
          item.classList.add('active');
      } else {
        item.classList.remove('active');
      }
  });
});
