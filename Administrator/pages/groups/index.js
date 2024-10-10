document.addEventListener('DOMContentLoaded', function() {
  const dropdowns = document.querySelectorAll('.dropdown');
  const resetFilter = document.querySelector('.reset-filter');
  const spinner = document.getElementById('loading-spinner');
  const paginationBar = document.getElementById('pagination-container');

  
  
  function createLeaderDropdownOptions() {
    const dropdownContainer = document.getElementById('leader-dropdown');
    dropdownContainer.innerHTML = ''; // Clear any existing options
  
    doctorNames.forEach(leader => {
        const optionDiv = document.createElement('div');
        optionDiv.className = 'dropdown-option'; // Apply the class for styling
        optionDiv.setAttribute('data-value', `Doc ${leader}`); // Set the data-value attribute
        optionDiv.textContent = `Doc ${leader}`; // Set the displayed text
        dropdownContainer.appendChild(optionDiv); // Append the option to the container
    });
  }

  createLeaderDropdownOptions();

  dropdowns.forEach(dropdown => {
    const selected = dropdown.querySelector('.dropdown-selected');
    const options = dropdown.querySelector('.dropdown-options');
    const items = dropdown.querySelectorAll('.dropdown-option');

    // Toggle dropdown open/close
    selected.addEventListener('click', function(event) {
        event.stopPropagation(); // Prevent triggering the document click listener
        // Close other dropdowns
        document.querySelectorAll('.dropdown-options').forEach(opt => {
            if (opt !== options) {
                opt.style.display = 'none';
            }
        });

        options.style.display = options.style.display === 'block' ? 'none' : 'block';
    });

    // Set selected option, make reset-filter active, and reload table
    items.forEach(item => {
        item.addEventListener('click', function() {
            selected.textContent = this.textContent;
            options.style.display = 'none';
            resetFilter.classList.add('active');
            reloadGroupTable(); // Reload the table with new filter
        });
    });
});

// Close dropdown when clicking outside
document.addEventListener('click', function(event) {
    if (!event.target.closest('.dropdown')) {
        document.querySelectorAll('.dropdown-options').forEach(opt => {
            opt.style.display = 'none';
        });
    }
});

resetFilter.addEventListener('click', function() {
  if (resetFilter.classList.contains('active')) {
      dropdowns.forEach(dropdown => {
          const selected = dropdown.querySelector('.dropdown-selected');
          const defaultValue = selected.getAttribute('data-default');
          selected.textContent = defaultValue;
      });
      resetFilter.classList.remove('active');
      reloadGroupTable(); // Reload the table with default filter
  }
});


const groupImages = [
  'assets/group00.jpg',
  'assets/group01.jpg',
  'assets/group02.jpg',
  'assets/group03.jpg',
  'assets/group04.jpg'
];

// Mock Group Data Generation
function generateGroups(numberOfGroups) {
    const oneDay = 24 * 60 * 60 * 1000; // Milliseconds in a day
    const today = new Date();

    // Divide groups equally among the three ranges
    const group1Count = Math.floor(numberOfGroups / 3); // Last 7 days
    const group2Count = Math.floor(numberOfGroups / 3); // Last 30 days
    const group3Count = numberOfGroups - group1Count - group2Count; // Last 365 days

    for (let i = 1; i <= numberOfGroups; i++) {
        const randomLeaderIndex = Math.floor(Math.random() * doctorNames.length);
        const randomImageIndex = Math.floor(Math.random() * groupImages.length);
        
        let creationDate;

        if (i <= group1Count) {
            // Generate a date in the last 7 days
            const daysAgo = Math.floor(Math.random() * 7);
            creationDate = new Date(today - (daysAgo * oneDay));
        } else if (i <= group1Count + group2Count) {
            // Generate a date in the last 30 days
            const daysAgo = Math.floor(Math.random() * 30);
            creationDate = new Date(today - (daysAgo * oneDay));
        } else {
            // Generate a date in the last 365 days
            const daysAgo = Math.floor(Math.random() * 365);
            creationDate = new Date(today - (daysAgo * oneDay));
        }

        const formattedDate = `${creationDate.getFullYear()}-${(creationDate.getMonth() + 1).toString().padStart(2, '0')}-${creationDate.getDate().toString().padStart(2, '0')}`;
        
        const group = {
            id: i.toString().padStart(3, '0'), // Generate ID like '001', '002', etc.
            groupName: `Group ${i}`,
            numberOfMembers: Math.floor(Math.random() * 20) + 5, // Random members between 5 and 25
            leader: `Doc ${doctorNames[randomLeaderIndex]}`, // Leader is 'Doc' + random name
            assignedPatients: Math.floor(Math.random() * 50) + 10, // Random patients between 10 and 60
            creationDate: formattedDate,
            status: ['Active', 'Inactive', 'Disbanded', 'Recruiting'][Math.floor(Math.random() * 4)], // New group statuses
            headImg: groupImages[randomImageIndex]
        };
        mockGroupData.push(group);
    }
}

// Function to filter data by creation date range
function isWithinCreationPeriod(creationDate, selectedPeriod) {
  const creationDateObj = new Date(creationDate);
  const today = new Date();
  let daysDifference = 0;

  switch (selectedPeriod) {
      case 'Last 7 days':
          daysDifference = 7;
          break;
      case 'Last 30 days':
          daysDifference = 30;
          break;
      case 'Last 365 days':
          daysDifference = 365;
          break;
      default:
          return true; // If the default is selected, ignore filtering
  }

  const dateDifference = Math.floor((today - creationDateObj) / (1000 * 60 * 60 * 24));
  return dateDifference <= daysDifference;
}

paginationBar.style.display = 'none';
function showLoading() {
  spinner.style.display = 'block';  
}

// Pagination for Groups
function reloadGroupTable(page = 1, rowsPerPage = 10) {
  showLoading(); // Show loading spinner

  setTimeout(() => {
      const tbody = document.querySelector('.styled-table tbody');
      tbody.innerHTML = ''; // Clear table content
      spinner.style.display = 'none'; // Hide spinner

      // Calculate start and end indices for the current page
      const startIndex = (page - 1) * rowsPerPage;
      const endIndex = startIndex + rowsPerPage;

      const selectedLeader = document.querySelector('.dropdown-selected[data-default="Leader"]').textContent;
      const selectedCreation = document.querySelector('.dropdown-selected[data-default="Creation"]').textContent;
      const selectedStatus = document.querySelector('.dropdown-selected[data-default="Status"]').textContent;

      // Filter mock data based on selected values (ignore if defaults are selected)
      const filteredData = mockGroupData.filter(item => {
          return (selectedLeader === 'Leader' || item.leader === selectedLeader) &&
                (selectedCreation === 'Creation' || isWithinCreationPeriod(item.creationDate, selectedCreation)) &&
                (selectedStatus === 'Status' || item.status === selectedStatus);
      });

      const newTotalPages = Math.round(filteredData.length / 10);
      pagination.updateTotalPages(newTotalPages);
      // Slice the data for the current page
      const currentPageData = filteredData.slice(startIndex, endIndex);

      // Use the currentPageData array to populate the table
      currentPageData.forEach(data => {
          const row = document.createElement('tr');
          let statusClass = '';

          // Determine the CSS class based on status
          if (data.status === 'Active') {
              statusClass = 'status-active';
          } else if (data.status === 'Inactive') {
              statusClass = 'status-inactive';
          } else if (data.status === 'Disbanded') {
              statusClass = 'status-disbanded';
          } else if (data.status === 'Recruiting') {
              statusClass = 'status-recruiting';
          }

          const randomLeaderIndex = Math.floor(Math.random() * doctorNames.length);
          const randomImageIndex = Math.floor(Math.random() * groupImages.length);

          row.innerHTML = `
              <td>
                  <div class="group-info">
                      <img onerror='this.src="${groupImages[randomImageIndex]}"'  src="${data.headImg}" alt="Group Image" class="group-img" />
                      <div class="group-details">
                          <span class="group-name">${data.name}</span>
                          <span class="group-id">ID: ${data.id}</span>
                      </div>
                  </div>
              </td>
              <td>${data.number_of_members}</td>
              <td>${data.therapist_id}</td>
              <td>${data.assigned_patients}</td>
              <td>${data.created_at}</td>
              <td><span class="status ${statusClass}">${data.status}</span></td>
              <td>
                  <button class="operation-btn" onClick="showModal(${data.id})">Edit</button>
                  <button class="operation-btn">Delete</button>
              </td>
          `;
          tbody.appendChild(row);
          paginationBar.style.display = 'flex';
      });
  }, 1000); // Mock delay of 1 second
}

// Generate approximately 100 groups

reloadGroupTable(1);

// Initialize Pagination
const pagination = new Pagination({
  totalPages: Math.ceil(mockGroupData.length / 10),
  containerId: "pagination-container",
  currentPage: 1,
  maxVisibleButtons: 4,
  onPageChange: (page) => {
    reloadGroupTable(page);
  }
});

});
