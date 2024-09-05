document.addEventListener('DOMContentLoaded', function() {
  const dropdowns = document.querySelectorAll('.dropdown');
  const resetFilter = document.querySelector('.reset-filter');
  const spinner = document.getElementById('loading-spinner');

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

// Reset all dropdowns to default when reset-filter is clicked and reload table
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

  const checkboxes = document.querySelectorAll('.therapist-info-patient-checkbox');

  checkboxes.forEach(checkbox => {
      checkbox.addEventListener('change', function() {
          const parent = this.closest('.therapist-info-patient-item');
          if (this.checked) {
              parent.classList.add('patient-item-selected');
          } else {
              parent.classList.remove('patient-item-selected');
          }
      });
  });

  const patientItems = document.querySelectorAll('.therapist-info-patient-item');

    patientItems.forEach(item => {
        item.addEventListener('click', function(event) {
            // Prevent the event from firing when clicking directly on the checkbox
            if (event.target.type !== 'checkbox') {
                const checkbox = this.querySelector('.therapist-info-patient-checkbox');
                checkbox.checked = !checkbox.checked; // Toggle the checkbox state
                
                // Toggle the 'selected' class based on the checkbox state
                if (checkbox.checked) {
                    this.classList.add('patient-item-selected');
                } else {
                    this.classList.remove('patient-item-selected');
                }
            }
        });
    });

  
  // Generate mock data with 150 entries
  const mockData = [];
  const groups = ['Group 1', 'Group 2', 'Group 3', 'Group 4'];
  const fields = ['Field 1', 'Field 2', 'Field 3', 'Field 4', 'Field 5', 'Field 6'];
  const statuses = ['Online', 'Rest', 'Quit'];

  for (let i = 1; i <= 150; i++) {
      mockData.push({
          id: `000${i.toString().padStart(2, '0')}`,
          name: `Person ${i}`,
          email: `person${i}@care.com`,
          group: groups[i % groups.length],
          field: fields[i % fields.length],
          status: statuses[i % statuses.length]
      });
  }

  const pagination = new Pagination({
    totalPages: 15,
    containerId: "pagination-container",
    currentPage: 1,
    
    maxVisibleButtons: 4,
    onPageChange: (page) => {
      reloadTable(page);
    }
  });

  

  // Function to show the loading spinner
  function showLoading() {
    spinner.style.display = 'block';
  }
      

  // Function to reload table content based on dropdown filters
  function reloadTable(page = 1, rowsPerPage = 8) {
      showLoading(); // Show loading spinner

      setTimeout(() => {
          const selectedGroup = document.querySelector('.dropdown-selected[data-default="Group"]').textContent;
          const selectedField = document.querySelector('.dropdown-selected[data-default="Field"]').textContent;
          const selectedStatus = document.querySelector('.dropdown-selected[data-default="Status"]').textContent;


          const startIndex = (page - 1) * rowsPerPage;
          const endIndex = startIndex + rowsPerPage;
          // Filter mock data based on selected values (ignore if defaults are selected)
          const filteredData = mockData.filter(item => {
              return (selectedGroup === 'Group' || item.group === selectedGroup) &&
                     (selectedField === 'Field' || item.field === selectedField) &&
                     (selectedStatus === 'Status' || item.status === selectedStatus);
          });

          const newTotalPages = Math.round(filteredData.length / 8);
          pagination.updateTotalPages(newTotalPages);

          const currentPageData = filteredData.slice(startIndex, endIndex);

          const tbody = document.querySelector('.styled-table tbody');
          tbody.innerHTML = ''; // Clear spinner
          spinner.style.display = 'none';

          // Update table rows with filtered data
          currentPageData.forEach(data => {
              const row = document.createElement('tr');
              row.innerHTML = `
                  <td>${data.id}</td>
                  <td>${data.name}</td>
                  <td>${data.email}</td>
                  <td>${data.group}</td>
                  <td>${data.field}</td>
                  <td><span class="status ${data.status.toLowerCase()}">${data.status}</span></td>
                  <td style="max-width: 12rem">
                    <button class="operation-btn" onClick="showModal(${data.id})">Edit</button>
                    <button class="operation-btn">Check</button>
                  </td>
              `;
              tbody.appendChild(row);
          });
      }, 1000); // Mock delay of 1 second
  }
  // Initial setup to set default values and load table
  reloadTable(); // Load table with default values
});

    const editor = document.getElementById('therapist-editor');
    function hideModal()
    {
        if (!editor)
        editor = document.getElementById('therapist-editor');
        editor.style.display = 'none';
    }

    function showModal(data)
    {
        console.log(data);
        if (!editor)
        editor = document.getElementById('therapist-editor');
        editor.style.display = 'block';
    }


    const therapistData = {
        id: '001',
        name: 'Olivia Turner, M.D.',
        email: 'oliviaturner@care.com',
        field: 'Early Intervention records',
        brief: 'Specializes in early intervention for children with developmental delays.',
        image: '/assets/doc2.jpeg',
        certificates: [
            {
                id: 0,
                image: '/assets/certification2.png',
                description: "The Psychiatrist's Guide to Population Management of Diabetes"
            },
            {
                id: 1,
                image: '/assets/certification1.png',
                description: 'DOCTORATE OF PSYCHIATRY'
            }
        ],
        assignedPatients: [
            { id: '101', name: 'John Doe', image: '/assets/head.jpeg', selected: true },
            { id: '102', name: 'Jane Smith', image: '/assets/head.jpeg', selected: true },
            // Add more assigned patients if needed
        ],
        unassignedPatients: [
            { id: '103', name: 'Alice Johnson', image: '/assets/head.jpeg', selected: false },
            { id: '104', name: 'Robert Brown', image: '/assets/head.jpeg', selected: false },
            { id: '105', name: 'Emily Davis', image: '/assets/head.jpeg', selected: false },
            { id: '106', name: 'Michael White', image: '/assets/head.jpeg', selected: false },
            { id: '107', name: 'Sarah Wilson', image: '/assets/head.jpeg', selected: false },
            { id: '108', name: 'David Lee', image: '/assets/head.jpeg', selected: false },
            { id: '109', name: 'Sophia Taylor', image: '/assets/head.jpeg', selected: false },
            { id: '110', name: 'Chris Harris', image: '/assets/head.jpeg', selected: false },
            { id: '111', name: 'Megan Clark', image: '/assets/head.jpeg', selected: false },
            { id: '112', name: 'James Hall', image: '/assets/head.jpeg', selected: false },
            { id: '113', name: 'Natalie Allen', image: '/assets/head.jpeg', selected: false },
            { id: '114', name: 'Ryan King', image: '/assets/head.jpeg', selected: false },
            { id: '115', name: 'Laura Scott', image: '/assets/head.jpeg', selected: false },
            { id: '116', name: 'Joshua Young', image: '/assets/head.jpeg', selected: false },
            { id: '117', name: 'Zoe Walker', image: '/assets/head.jpeg', selected: false },
            { id: '118', name: 'Anthony Green', image: '/assets/head.jpeg', selected: false },
            { id: '119', name: 'Jessica Adams', image: '/assets/head.jpeg', selected: false },
            { id: '120', name: 'Jacob Baker', image: '/assets/head.jpeg', selected: false },
            { id: '121', name: 'Abigail Turner', image: '/assets/head.jpeg', selected: false },
            { id: '122', name: 'Daniel Martinez', image: '/assets/head.jpeg', selected: false }
        ],
        groups: [
            {
                name: 'Expert group',
                numMembers: 18,
                authority: [
                    'View patient information',
                    'Edit patient data',
                    'Create a patient group'
                ]
            },
            {
                name: 'Expert group',
                numMembers: 18,
                authority: [
                    'View patient information',
                    'Edit patient data',
                    'Create a patient group'
                ]
            }
        ]
    };
    

    function populateTherapistForm(data) {
        // Update the Modal Title with Therapist's Name
        const modalTitle = document.querySelector('.modal-title');
        modalTitle.textContent = `Therapist Details - ${data.name}`;
    
        // Clear and Populate Therapist Info
        const therapistInfoContainer = document.querySelector('.therapist-info-content');
        therapistInfoContainer.innerHTML = ''; // Clear existing content

        const fieldOptions = [
            'Early Intervention records',
            'Pediatrics',
            'Psychiatry',
            'Neurology',
            'Counseling'
        ];
        

        const fieldOptionsHTML = fieldOptions.map(option => {
            const selected = option === data.field ? 'selected' : '';
            return `<option value="${option}" ${selected}>${option}</option>`;
        }).join('');
    
        const therapistInfoContent = `
            <h4 class="therapist-info-name">Therapist ID: ${data.id}<br>${data.name}</h4>
            <div class="info-row">
                <p class="info-title">Email:</p>
                <p class="info-value">
                    <a href="mailto:${data.email}" id="email-text">${data.email}</a>
                    <span class="edit-icon" onclick="toggleEdit('email')">✏️</span>
                </p>
            </div>
            <div class="info-row">
                <p class="info-title">Field:</p>
                <p class="info-value" id="field-text">
                    <select id="field-select" class="styled-select">
                        ${fieldOptionsHTML}
                    </select>
                </p>
            </div>
            <div class="info-row">
                <p class="info-title">Brief:</p>
                <div class="info-value">
                    <p id="brief-text" style="width: 100%">${data.brief}</p>
                    <span class="edit-icon" onclick="toggleEdit('brief')">✏️</span>
                </div>
            </div>
            <div class="therapist-info-buttons">
                <button class="therapist-info-delete-btn" onclick="deleteTherapist()">Delete</button>
            </div>
        `;

        therapistInfoContainer.innerHTML = therapistInfoContent;
        document.querySelector('.therapist-info-image img').src = data.image;
    
        // Clear and Populate Certificates
        const certificatesContainer = document.querySelector('.therapist-info-certificates');
        certificatesContainer.innerHTML = ''; // Clear existing content
        certificatesContainer.innerHTML = '<h4>Certificate (' + data.certificates.length + ')</h4>'; // Add header
        data.certificates.forEach(cert => {
            const certElement = `
                <div class="therapist-info-certificate-item" onclick="triggerFileUpload(${cert.id})">
                    <img src="${cert.image}" class="certificate-img" alt="Certificate Image" id="cert${cert.id}"  onmouseenter="showPreview(${cert.id})" onmouseleave="hidePreview()">
                    <p>${cert.description}</p>
                </div>
            `;
            certificatesContainer.innerHTML += (certElement + `<input type="file" id="file-upload" style="display:none;" accept="image/*" onchange="handleFileChange(event)"><div id="image-preview-popup" class="image-preview-popup">
            <img id="preview-image" src="" alt="Image Preview">
        </div>` );
        });
    
        // Clear and Populate Assigned and Unassigned Patients
        const patientListContainer = document.querySelector('.therapist-info-patient-list');
        patientListContainer.innerHTML = ''; // Clear existing content
    
        const allPatients = [...data.assignedPatients, ...data.unassignedPatients];
        allPatients.forEach(patient => {
            const isChecked = patient.selected ? 'checked' : '';
            const patientElement = `
                <div class="therapist-info-patient-item ${patient.selected ? 'patient-item-selected' : ''}">
                    <img src="${patient.image}" alt="Patient Picture">
                    <div class="therapist-info-patient-info">
                        <h4>Patient ID: ${patient.id}</h4>
                        <h4>${patient.name}</h4>
                    </div>
                    <input type="checkbox" class="therapist-info-patient-checkbox" ${isChecked}>
                </div>
            `;
            patientListContainer.innerHTML += patientElement;
        });
    
        // Clear and Populate Therapist Group
        const groupContainer = document.querySelector('.therapist-info-group');
        groupContainer.innerHTML = ''; // Clear existing content
        data.groups.forEach(group => {
            const groupElement = `
                <div class="therapist-info-group-item">
                    <div class="group-details">
                        <div>
                            <h4>${group.name}</h4>
                            <p>Num of Member: ${group.numMembers}</p>
                        </div>
                        <div class="group-icon">
                            <img src="/assets/patient_male.png" alt="Group Icon">
                        </div>
                    </div>
                    <div class="group-authority">
                        <h4>Authority:</h4>
                        ${group.authority.map(auth => `<p><a href="#">${auth}</a></p>`).join('')}
                    </div>
                </div>
            `;
            groupContainer.innerHTML += groupElement;
        });
    }
    
    // Call the function with the mock data
    populateTherapistForm(therapistData);

    let originalEmail = ""; // To store the original email
let originalBriefText = ""; // To store the original brief text

function toggleEdit(field) {
    if (field === 'email') {
        const emailValue = document.getElementById('email-text');
        const emailContainer = emailValue.parentNode;

        if (emailValue.tagName === 'A') {
            // Save the original email
            originalEmail = emailValue.textContent.trim();
            
            // Switch to input mode for email
            emailContainer.innerHTML = `<input type="email" id="email-input" value="${originalEmail}" onblur="confirmChanges('email')" class="editable-input">`;
        } else {
            // Switch back to text mode for email
            emailContainer.innerHTML = `<a href="mailto:${originalEmail}" id="email-text">${originalEmail}</a> <span class="edit-icon" onclick="toggleEdit('email')">✏️</span>`;
        }
    } else if (field === 'brief') {
        const briefText = document.getElementById('brief-text');
        const briefValue = briefText.textContent.trim();

        if (!briefText.querySelector('textarea')) {
            // Save the original brief text
            originalBriefText = briefValue;
            
            // Switch to textarea mode for brief
            briefText.innerHTML = `<textarea id="brief-textarea" class="editable-textarea" onblur="confirmChanges('brief')">${originalBriefText}</textarea>`;
        } else {
            // Switch back to text mode for brief
            briefText.innerHTML = `${originalBriefText}`;
        }
    }
}


function confirmChanges(field) {
    if (field === 'email') {
        const emailInput = document.getElementById('email-input');
        const newEmail = emailInput.value.trim();

        if (newEmail !== originalEmail) {
            confirmModal.show(
                "Save the changes?",
                "After saving the brief would be changed permenantly.",
                () => {
                    originalEmail = newEmail;
                    
                    confirmModal.hide();
                },
                () => {
                   
                },
                "Ok",
                "Cancel"
            );
        }

        document.getElementById('email-input').parentNode.innerHTML = `<a href="mailto:${originalEmail}" id="email-text">${originalEmail}</a> <span class="edit-icon" onclick="toggleEdit('email')">✏️</span>`;

        // Revert to text mode for email
        
    } else if (field === 'brief') {
        const briefInput = document.getElementById('brief-textarea');
        const newBrief = briefInput.value.trim();

        if (newBrief !== originalBriefText) {
            confirmModal.show(
                "Save the changes?",
                "After saving the brief would be changed permenantly.",
                () => {
                    originalBriefText = newBrief;
                    confirmModal.hide();
                },
                () => {
                   
                },
                "Ok",
                "Cancel"
            );
        }

        document.getElementById('brief-text').innerHTML = `${originalBriefText}`;
        

        // // Revert to text mode for brief
        // document.getElementById('brief-text').innerHTML = `${originalBriefText}`;
    }
}

let currentImgId = '';

function triggerFileUpload(imgId) {
    // Save the ID of the image being replaced
    currentImgId = imgId;

    // Trigger the hidden file input click
    document.getElementById('file-upload').click();
}

function handleFileChange(event) {
    const file = event.target.files[0];
    if (file) {
        const reader = new FileReader();

        reader.onload = function(e) {
            // Update the image src with the new file content
            document.getElementById(`cert${currentImgId}`).src = e.target.result;
        };

        reader.readAsDataURL(file);
    }
}


function showPreview(imgId) {
    const imgElement = document.getElementById(`cert${imgId}`);
    const previewPopup = document.getElementById('image-preview-popup');
    const previewImage = document.getElementById('preview-image');

    // Set the source of the preview image to the source of the hovered image
    previewImage.src = imgElement.src;

    // Get the position of the hovered image and set the position of the preview popup
    const rect = imgElement.getBoundingClientRect();
    previewPopup.style.top = (0) + 'px'; // Align top with the image
    previewPopup.style.left = (0) + 'px'; // Position to the right with a small offsetleft with the image

    // Show the preview popup
    previewPopup.style.display = 'block';
}

function hidePreview() {
    // Hide the preview popup
    const previewPopup = document.getElementById('image-preview-popup');
    previewPopup.style.display = 'none';
}




    
    


