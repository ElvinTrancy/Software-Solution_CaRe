// Select all elements with the class 'nav-item'
const navItems = document.querySelectorAll('.nav-item');

// Get the current page name from the URL (e.g., 'index.html')
const currentPage = window.location.pathname.split('/').pop(); // Extract just the filename

// Loop through each nav-item and add a click event listener
navItems.forEach(item => {
    // Get the data-href attribute and remove the leading slash if it exists
    const href = item.getAttribute('data-href').replace(/^\//, '');

    // Check if the href matches the current page and set it as active
    if (href === currentPage) {
        item.classList.add('active');
    } else {
        item.classList.remove('active');
    }

    // Add a click event listener for each nav-item
    item.addEventListener('click', function() {
        // If the clicked nav-item is already active, don't navigate
        if (this.classList.contains('active')) {
            return;
        }

        // Remove the 'active' class from all nav-items
        navItems.forEach(nav => nav.classList.remove('active'));

        // Add the 'active' class to the clicked nav-item
        this.classList.add('active');

        // Navigate to the href location
        const href = this.getAttribute('data-href').replace(/^\//, ''); // Remove the leading slash if present
        if (href) {
            window.location.href = href;
        }
    });
});
