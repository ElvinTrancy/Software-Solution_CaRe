class Pagination {
    constructor(config) {
        // Default configuration options
        this.config = {
            containerId: 'pagination-container',
            totalPages: 1,
            currentPage: 1,
            onPageChange: () => {},
            maxVisibleButtons: 9, // Maximum number of page buttons to display
            ...config // Override defaults with user-provided config
        };
        
        this.container = document.getElementById(this.config.containerId);
        this.init();
    }

    // Initialize the pagination component
    init() {
        this.render();
        this.addEventListeners();
    }

    // Render pagination HTML
    render() {
        const { totalPages, currentPage, maxVisibleButtons } = this.config;
        let html = '';

        html += `<button class="pagination-prev" ${currentPage === 1 ? 'disabled' : ''}>Prev</button>`;

        if (totalPages <= maxVisibleButtons) {
            // If total pages are less than or equal to max visible buttons, show all
            for (let i = 1; i <= totalPages; i++) {
                html += `<button class="pagination-item ${i === currentPage ? 'active' : ''}" data-page="${i}">${i}</button>`;
            }
        } else {
            // Show the first page
            // calculate display range
            let half = Math.floor(maxVisibleButtons / 2);
            let startPage = Math.max(1, currentPage - half);
            let endPage = Math.min(totalPages, currentPage + half);

            // adjust start page and current page 
            if (currentPage <= half) {
                endPage = Math.min(totalPages, maxVisibleButtons);
            } else if (currentPage > totalPages - half) {
                startPage = Math.max(1, totalPages - maxVisibleButtons + 1);
            }

            // first page
            html += `<button class="pagination-item ${1 === currentPage ? 'active' : ''}" data-page="1">1</button>`;

            // display ...
            if (startPage > 2) {
                html += `<span class="pagination-ellipsis">...</span>`;
            }

            // show the pages in range
            for (let i = startPage; i <= endPage; i++) {
                if (i > 1 && i < totalPages) { // ignore the first and last page
                    html += `<button class="pagination-item ${i === currentPage ? 'active' : ''}" data-page="${i}">${i}</button>`;
                }
            }

            // display ...
            if (endPage < totalPages - 1) {
                html += `<span class="pagination-ellipsis">...</span>`;
            }

            // show last page
            if (totalPages > 1) {
                html += `<button class="pagination-item ${totalPages === currentPage ? 'active' : ''}" data-page="${totalPages}">${totalPages}</button>`;
            }
        }

        html += `<button class="pagination-next" ${currentPage === totalPages ? 'disabled' : ''}>Next</button>`;

        this.container.innerHTML = html;
    }

    // Add event listeners for pagination buttons
    addEventListeners() {
        this.container.addEventListener('click', (e) => {
            if (e.target.classList.contains('pagination-item')) {
                const page = parseInt(e.target.getAttribute('data-page'));
                this.update(page);
            } else if (e.target.classList.contains('pagination-prev')) {
                if (this.config.currentPage > 1) {
                    this.update(this.config.currentPage - 1);
                }
            } else if (e.target.classList.contains('pagination-next')) {
                if (this.config.currentPage < this.config.totalPages) {
                    this.update(this.config.currentPage + 1);
                }
            }
        });
    }

    // Update pagination when a new page is selected
    update(newPage) {
        if (newPage < 1 || newPage > this.config.totalPages) return;

        this.config.currentPage = newPage;
        this.render();
        this.config.onPageChange(newPage);
    }

    updateTotalPages(newTotalPages) {
        this.config.totalPages = newTotalPages;
        if (this.config.currentPage > newTotalPages) {
            this.config.currentPage = newTotalPages; // Adjust current page if out of range
        }
        this.render();
    }
}
