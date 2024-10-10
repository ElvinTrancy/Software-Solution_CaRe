function initializeVisitsChart(chartData) {
  // Initialize the chart
  var visitsChart = echarts.init(document.getElementById('visitsChart'));

  // Configure the chart options
  var visitsOption = {
      title: {
          text: 'Visits',
          show: false,
          left: 'center',
          textStyle: {
              color: '#666',
              fontSize: 12
          }
      },
      tooltip: {
          trigger: 'axis',
          backgroundColor: 'rgba(255, 255, 255, 0.9)',
          textStyle: {
              color: '#333'
          },
          extraCssText: 'z-index: 9999; box-shadow: 0 0 10px rgba(0,0,0,0.2);',
          axisPointer: {
              type: 'line',
              lineStyle: {
                  color: '#888',
                  type: 'dashed'
              }
          }
      },
      xAxis: {
          type: 'category',
          boundaryGap: false,
          show: false,
          data: chartData.dates, // Use provided dates
          axisLine: {
              show: false
          },
          axisTick: {
              show: false
          },
          axisLabel: {
              show: false
          }
      },
      grid: {
          left: '0%',    // Remove left padding
          right: '0%',   // Remove right padding
          top: '0%',     // Remove top padding
          bottom: '0%'   // Remove bottom padding
      },
      yAxis: {
          type: 'value',
          show: false,
          axisLine: {
              show: false
          },
          axisTick: {
              show: false
          },
          axisLabel: {
              show: false
          },
          splitLine: {
              show: false
          }
      },
      series: [{
          name: 'Daily Visits',
          type: 'line',
          data: chartData.values, // Use provided values
          areaStyle: { color: 'rgba(54, 162, 235, 0.6)' }, // Blue area fill
          lineStyle: { color: '#36A2EB', width: 2 }, // Line color and width
          smooth: true, // Smooth the line
          symbol: 'none'
      }]
  };

  // Set the option for the chart
  visitsChart.setOption(visitsOption);

  // Make the chart responsive
  window.addEventListener('resize', function () {
      visitsChart.resize();
  });

  return visitsChart; // Return the chart instance for further use if needed
}


function initializeTherapistsChart(chartData) {
  // Initialize the chart
  var therapistsChart = echarts.init(document.getElementById('therapistsChart'));

  // Configure the chart options
  var therapistsOption = {
      xAxis: {
          type: 'category',
          show: false,
          boundaryGap: false,
          data: chartData.dates, // Use provided dates
      },
      yAxis: {
          type: 'value',
          show: false
      },
      series: [{
          name: 'Total Therapists',
          type: 'line',
          data: chartData.values, // Use provided values
          areaStyle: { color: 'rgba(46, 204, 113, 0.6)' }, // Light green for the area fill
          lineStyle: { color: '#2ecc71', width: 2 }, // Green line color for downward trend
          smooth: true,
          symbol: 'none'
      }],
      tooltip: {
          trigger: 'axis',
          backgroundColor: 'rgba(255, 255, 255, 0.9)',
          textStyle: {
              color: '#333'
          },
          extraCssText: 'z-index: 9999; box-shadow: 0 0 10px rgba(0,0,0,0.2);', // Custom CSS for z-index
          axisPointer: {
              type: 'line',
              lineStyle: {
                  color: '#888',
                  type: 'dashed'
              }
          }
      },
      grid: {
          left: '0%',
          right: '0%',
          top: '0%',
          bottom: '0%',
          containLabel: false
      }
  };

  // Set the option for the chart
  therapistsChart.setOption(therapistsOption);

  // Make the chart responsive
  window.addEventListener('resize', function () {
      therapistsChart.resize();
  });

  return therapistsChart; // Return the chart instance for further use if needed
}

function initializeGroupChart(chartData) {
  // Initialize the chart
  var groupChart = echarts.init(document.getElementById('groupChart'));

  // Configure the chart options
  var groupChartOption = {
      xAxis: {
          type: 'category',
          show: false,
          boundaryGap: false,
          data: chartData.days, // Use provided days
      },
      yAxis: {
          type: 'value',
          show: false
      },
      series: [{
          name: 'Patient Group',
          type: 'bar',
          barWidth: '20%',
          data: chartData.values, // Use provided values
          symbol: 'none'
      }],
      tooltip: {
          trigger: 'axis',
          backgroundColor: 'rgba(255, 255, 255, 0.9)',
          textStyle: {
              color: '#333'
          },
          extraCssText: 'z-index: 9999; box-shadow: 0 0 10px rgba(0,0,0,0.2);', // Custom CSS for z-index
          axisPointer: {
              type: 'line',
              lineStyle: {
                  color: '#888',
                  type: 'dashed'
              }
          }
      },
      grid: {
          left: '1%',
          right: '1%',
          top: '0%',
          bottom: '0%',
          containLabel: false
      }
  };

  // Set the option for the chart
  groupChart.setOption(groupChartOption);

  // Make the chart responsive
  window.addEventListener('resize', function () {
      groupChart.resize();
  });

  return groupChart; // Return the chart instance for further use if needed
}

function initializeTopDiagnosticChart(chartData) {
  // Initialize the chart
  var topDiagnosticChart = echarts.init(document.getElementById('topDiagnosticChart'));

  // Configure the chart options
  var topDiagnosticOption = {
      tooltip: {
          trigger: 'item',
          formatter: '{b}: {c} ({d}%)',
          backgroundColor: 'rgba(255, 255, 255, 0.9)',
          textStyle: {
              color: '#333'
          },
          extraCssText: 'z-index: 9999; box-shadow: 0 0 10px rgba(0,0,0,0.2);'
      },
      legend: {
          show: false
      },
      series: [
          {
              name: 'Top Diagnostic',
              type: 'pie',
              avoidLabelOverlap: false,
              itemStyle: {
                  borderRadius: 8,
                  borderColor: '#fff',
                  borderWidth: 2
              },
              label: {
                  show: false,
                  position: 'center'
              },
              emphasis: {
                  label: {
                      show: false,
                      fontSize: '1rem',
                      fontWeight: 'bold'
                  }
              },
              labelLine: {
                  show: false
              },
              data: chartData, // Use provided data
          }
      ],
      grid: {
          containLabel: false,
          left: '0%',
          right: '0%',
          top: '0%',
          bottom: '0%'
      }
  };

  // Set the option for the chart
  topDiagnosticChart.setOption(topDiagnosticOption);

  // Make the chart responsive
  window.addEventListener('resize', function () {
      topDiagnosticChart.resize();
  });

  return topDiagnosticChart; // Return the chart instance for further use if needed
}

const tasks = [
        "Assign new patients to therapists",
        "Create identity information for new therapists",
        "Monitoring statistics",
        "Update patient records",
        "Schedule meetings with staff",
        "Prepare weekly reports"
    ];

    const staff = [
        "John Doe",
        "Jane Smith",
        "Alex Johnson",
        "Chris Lee",
        "Patricia Brown",
        "Michael Davis",
        "Linda Williams",
        "Robert Martinez",
        "Maria Garcia",
        "David Wilson"
    ];




 // Function to initialize the activity chart with dynamic data
 function initializeActivityChart(data) {
  // Set the current date in the header
  document.getElementById('current-date').innerText = `Today ${new Date().toISOString().slice(0, 10)}`;

  // Initialize the chart
  var activityChart = echarts.init(document.getElementById('activity-chart'));

  // Configure the chart options
  var activityChartOption = {
      title: {
          text: '',
      },
      tooltip: {
          trigger: 'axis',
          backgroundColor: 'rgba(255, 255, 255, 0.9)',
          textStyle: {
              color: '#333'
          },
          extraCssText: 'z-index: 9999; box-shadow: 0 0 10px rgba(0,0,0,0.2);', // Custom CSS for z-index
          axisPointer: {
              type: 'line',
              lineStyle: {
                  color: '#888',
                  type: 'dashed'
              }
          }
      },
      legend: {
          data: ['Visitor', 'Register', 'Appointment'],
          left: '0%',
          top: '0%',
          icon: 'rect',  // Use a rectangular shape
          itemWidth: 14,  // Width of the legend item
          itemHeight: 14,  // Height of the legend item
          textStyle: {
              fontSize: 14
          },
          selectedMode: 'multiple', // Enable multiple selection (checkbox behavior)
          selected: {
              'Visitor': true,      // Set initial state (checked)
              'Register': true,     // Set initial state (checked)
              'Appointment': true   // Set initial state (checked)
          }
      },
      grid: {
          left: '3%',
          right: '4%',
          bottom: '0%',
          containLabel: true
      },
      xAxis: {
          type: 'category',
          boundaryGap: false,
          data: data.dates, // Use provided dates
      },
      yAxis: {
          type: 'value',
          show: false,
      },
      series: [
          {
              name: 'Visitor',
              type: 'line',
              data: data.visitorData, // Use provided visitor data
              smooth: false,
              lineStyle: {
                  width: 2,
              },
              itemStyle: {
                  color: '#5470c6'
              }
          },
          {
              name: 'Register',
              type: 'line',
              data: data.registerData, // Use provided register data
              smooth: false,
              lineStyle: {
                  width: 2,
              },
              itemStyle: {
                  color: '#91cc75'
              }
          },
          {
              name: 'Appointment',
              type: 'line',
              data: data.appointmentData, // Use provided appointment data
              smooth: false,
              lineStyle: {
                  width: 2,
              },
              itemStyle: {
                  color: '#fac858'
              }
          }
      ]
  };

  // Set the option for the chart
  activityChart.setOption(activityChartOption);

  // Make the chart responsive
  window.addEventListener('resize', function () {
      activityChart.resize();
  });

  return activityChart; // Return the chart instance for further use if needed
}


function createPatientCard(patient) {
  // Create the main card container
  const card = document.createElement('div');
  card.className = 'patient-card';

  // Create the patient photo container
  const photoContainer = document.createElement('div');
  photoContainer.className = 'patient-photo';
  const photo = document.createElement('img');
  photo.src = '/assets/head.jpeg'; // Replace with actual path or URL
  photo.alt = 'Patient Photo';
  photoContainer.appendChild(photo);

  // Create the patient details container
  const detailsContainer = document.createElement('div');
  detailsContainer.className = 'patient-details';

  // Create and append patient info groups
  const infoGroup1 = document.createElement('div');
  infoGroup1.className = 'patient-info-group';
  infoGroup1.innerHTML = `
      <div class="patient-info"><strong>Patient ID:</strong> ${patient.id}</div>
      <div class="patient-info"><strong>Patient Name:</strong> ${patient.name}</div>
  `;

  const infoGroup2 = document.createElement('div');
  infoGroup2.className = 'patient-info-group';
  infoGroup2.innerHTML = `
      <div class="patient-info"><strong>Registered:</strong> ${patient.registered}</div>
      <div class="patient-info"><strong>In Charge:</strong> ${patient.inCharge}</div>
  `;

  detailsContainer.appendChild(infoGroup1);
  detailsContainer.appendChild(infoGroup2);

  // Append photo and details to the main card container
  card.appendChild(photoContainer);
  card.appendChild(detailsContainer);

  return card;
}

// Function to inject patients into the DOM
function injectPatients(patients) {
  const patientList = document.getElementById('patient-list');
  patients.forEach(patient => {
      const patientCard = createPatientCard(patient);
      patientList.appendChild(patientCard);
  });
}





const fetchedData = {
  dates: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
  values: [820, 932, 901, 934, 1290, 1330, 1320]
};

// Initialize the chart with fetched data
initializeVisitsChart(fetchedData);

// Mock data fetching from the server
const therapistsData = {
  dates: ['Sep', 'Oct', 'Nov', 'Dec', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug'],
  values: [80, 78, 76, 75, 85, 80, 70, 80, 68, 66, 64, 75, 62, 60, 59, 58, 57, 56, 55]
};

// Initialize the chart with fetched data
initializeTherapistsChart(therapistsData);

// Mock data fetching from the server
const groupData = {
  days: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
  values: [109, 130, 157, 145, 144, 159, 170] // Example data
};

// Initialize the chart with fetched data
initializeGroupChart(groupData);

// Mock data fetching from the server
const diagnosticData = [
  { value: 45, name: 'Insomnia', itemStyle: { color: '#FFCD56' } },
  { value: 30, name: 'Paranoea', itemStyle: { color: '#36A2EB' } },
  { value: 25, name: 'BD', itemStyle: { color: '#4BC0C0' } }
];

// Initialize the chart with fetched data
initializeTopDiagnosticChart(diagnosticData);

// Example usage with mock data
const mockData = {
  dates: ['2024-08-17', '2024-08-18', '2024-08-19', '2024-08-20', '2024-08-21', '2024-08-22', '2024-08-23'],
  visitorData: [120, 132, 101, 134, 90, 230, 210],
  registerData: [220, 182, 191, 234, 290, 330, 310],
  appointmentData: [150, 232, 201, 154, 190, 330, 410]
};

// Initialize the chart with mock data
initializeActivityChart(mockData);


const patients = [
  { id: '001', name: 'Alice Smith', registered: '2024-08-20', inCharge: 'Dr. John Doe' },
  { id: '002', name: 'Bob Johnson', registered: '2024-08-18', inCharge: 'Dr. Jane Roe' },
  { id: '003', name: 'Charlie Brown', registered: '2024-08-15', inCharge: 'Dr. Emily White' },
  { id: '004', name: 'David Wilson', registered: '2024-08-14', inCharge: 'Dr. Michael Green' },
  { id: '005', name: 'Eve Davis', registered: '2024-08-12', inCharge: 'Dr. Rachel Blue' },
  { id: '006', name: 'Frank Miller', registered: '2024-08-10', inCharge: 'Dr. Olivia Yellow' },
  { id: '007', name: 'Grace Lee', registered: '2024-08-08', inCharge: 'Dr. George Red' },
  { id: '008', name: 'Hank Lewis', registered: '2024-08-05', inCharge: 'Dr. Sophia Brown' },
  { id: '009', name: 'Isabel Clark', registered: '2024-08-03', inCharge: 'Dr. David White' },
  { id: '010', name: 'Jack Robinson', registered: '2024-08-01', inCharge: 'Dr. Linda Black' }
];

injectPatients(patients);
