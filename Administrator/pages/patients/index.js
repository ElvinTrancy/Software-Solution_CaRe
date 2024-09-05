document.addEventListener('DOMContentLoaded', function() {
  const dropdowns = document.querySelectorAll('.dropdown');
  const resetFilter = document.querySelector('.reset-filter');
  const spinner = document.getElementById('loading-spinner');
  const paginationBar = document.getElementById('pagination-container');

  const doctorNames = [
    'Dr. Smith',
    'Dr. Johnson',
    'Dr. Lee',
    'Dr. Martinez',
    'Dr. Brown',
    'Dr. Garcia',
    'Dr. Miller',
    'Dr. Davis',
    'Dr. Wilson',
    'Dr. Taylor'
  ];
  
  function createDoctorDropdownOptions() {
    const dropdownContainer = document.getElementById('doctor-dropdown');
    dropdownContainer.innerHTML = ''; // Clear any existing options
  
    doctorNames.forEach(doctor => {
        const optionDiv = document.createElement('div');
        optionDiv.className = 'dropdown-option'; // Apply the class for styling
        optionDiv.setAttribute('data-value', doctor); // Set the data-value attribute
        optionDiv.textContent = doctor; // Set the displayed text
        dropdownContainer.appendChild(optionDiv); // Append the option to the container
    });
  }

  createDoctorDropdownOptions();

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
            reloadTable(); // Reload the table with new filter
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

const mockData = [];



// Call the function to create the dropdown options


const patientImages = [
    '/assets/patient0.jpeg',
    '/assets/patient1.jpeg',
    '/assets/patient2.jpeg',
    '/assets/patient3.jpeg',
    '/assets/patient4.jpeg'
];


paginationBar.style.display = 'none';
function showLoading() {
  spinner.style.display = 'block';  
}

// Function to generate random patients
function generatePatients(numberOfPatients) {
    const oneDay = 24 * 60 * 60 * 1000; // Milliseconds in a day
    const today = new Date();

    // Divide patients equally among the three ranges
    const group1Count = Math.floor(numberOfPatients / 3); // Last 7 days
    const group2Count = Math.floor(numberOfPatients / 3); // Last 30 days
    const group3Count = numberOfPatients - group1Count - group2Count; // Last 365 days

    for (let i = 1; i <= numberOfPatients; i++) {
        const randomDoctorIndex = Math.floor(Math.random() * doctorNames.length);
        const randomImageIndex = Math.floor(Math.random() * patientImages.length);
        
        let registrationDate;

        if (i <= group1Count) {
            // Generate a date in the last 7 days
            const daysAgo = Math.floor(Math.random() * 7);
            registrationDate = new Date(today - (daysAgo * oneDay));
        } else if (i <= group1Count + group2Count) {
            // Generate a date in the last 30 days
            const daysAgo = Math.floor(Math.random() * 30);
            registrationDate = new Date(today - (daysAgo * oneDay));
        } else {
            // Generate a date in the last 365 days
            const daysAgo = Math.floor(Math.random() * 365);
            registrationDate = new Date(today - (daysAgo * oneDay));
        }

        const formattedDate = `${registrationDate.getFullYear()}-${(registrationDate.getMonth() + 1).toString().padStart(2, '0')}-${registrationDate.getDate().toString().padStart(2, '0')}`;
        
        const patient = {
            id: i.toString().padStart(3, '0'), // Generate ID like '001', '002', etc.
            name: `Patient ${i}`,
            registrationDate: formattedDate,
            therapist: doctorNames[randomDoctorIndex],
            status: ['Active', 'On hold', 'Discharged'][Math.floor(Math.random() * 3)],
            notes: 'Random notes here...',
            headImg: patientImages[randomImageIndex]
        };
        mockData.push(patient);
    }
}


resetFilter.addEventListener('click', function() {
  if (resetFilter.classList.contains('active')) {
      dropdowns.forEach(dropdown => {
          const selected = dropdown.querySelector('.dropdown-selected');
          const defaultValue = selected.getAttribute('data-default');
          selected.textContent = defaultValue;
      });
      resetFilter.classList.remove('active');
      reloadTable(); // Reload the table with default filter
  }
});

// Generate approximately 150 patients
generatePatients(150);

function isWithinRegistrationPeriod(registrationDate, selectedPeriod) {
  const registrationDateObj = new Date(registrationDate);
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

  const dateDifference = Math.floor((today - registrationDateObj) / (1000 * 60 * 60 * 24));
  return dateDifference <= daysDifference;
}


function reloadTable(page = 1, rowsPerPage = 10) {
  showLoading(); // Show loading spinner

  setTimeout(() => {
      const tbody = document.querySelector('.styled-table tbody');
      tbody.innerHTML = ''; // Clear table content
      spinner.style.display = 'none'; // Hide spinner

      // Calculate start and end indices for the current page
      const startIndex = (page - 1) * rowsPerPage;
      const endIndex = startIndex + rowsPerPage;

      const selectedTherapist = document.querySelector('.dropdown-selected[data-default="Therapist"]').textContent;
      const selectedRegistration = document.querySelector('.dropdown-selected[data-default="Registration"]').textContent;
      const selectedStatus = document.querySelector('.dropdown-selected[data-default="Status"]').textContent;

      // Filter mock data based on selected values (ignore if defaults are selected)
      const filteredData = mockData.filter(item => {
          return (selectedTherapist === 'Therapist' || item.therapist === selectedTherapist) &&
                (selectedRegistration === 'Registration' || isWithinRegistrationPeriod(item.registrationDate, selectedRegistration)) &&
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
          } else if (data.status === 'On hold') {
              statusClass = 'status-onhold';
          } else if (data.status === 'Discharged') {
              statusClass = 'status-discharged';
          }

          row.innerHTML = `
              <td>
                  <div class="patient-info">
                      <img src="${data.headImg}" alt="Head Image" class="patient-img" />
                      <div class="patient-details">
                          <span class="patient-name">${data.name}</span>
                          <span class="patient-id">ID: ${data.id}</span>
                      </div>
                  </div>
              </td>
              <td>${data.registrationDate}</td>
              <td>${data.therapist}</td>
              <td><span class="status ${statusClass}">${data.status}</span></td>
              <td style="min-width: 250px">${data.notes}</td>
              <td>
                  <button class="operation-btn" onClick="showModal(${data.id})">Edit</button>
                  <button class="operation-btn">Check</button>
              </td>
          `;
          tbody.appendChild(row);
          paginationBar.style.display = 'flex';
      });
  }, 1000); // Mock delay of 1 second
}


reloadTable(1);

const pagination = new Pagination({
  totalPages: mockData.length / 10,
  containerId: "pagination-container",
  currentPage: 1,
  maxVisibleButtons: 4,
  onPageChange: (page) => {
    reloadTable(page);
  }
});



});



