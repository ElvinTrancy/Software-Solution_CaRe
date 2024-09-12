// statistics.js

// Mock data for statistics
const statistics = [
  { progressId: "total-patients-progress", arrowId: "total-patients-arrow", amountId: "total-patients-amount", percentageId: "total-patients-percentage", progressValue: 81, amount: "560K", percentage: "14.25%", upOrDown: "up" },
  { progressId: "total-therapists-progress", arrowId: "total-therapists-arrow", amountId: "total-therapists-amount", percentageId: "total-therapists-percentage", progressValue: 68, amount: "68", percentage: "21.65%", upOrDown: "down" },
  { progressId: "new-patient-group-progress", arrowId: "new-patient-group-arrow", amountId: "new-patient-group-amount", percentageId: "new-patient-group-percentage", progressValue: 76, amount: "12.3K", percentage: "10.36%", upOrDown: "up" },
  { progressId: "new-appointment-progress", arrowId: "new-appointment-arrow", amountId: "new-appointment-amount", percentageId: "new-appointment-percentage", progressValue: 56, amount: "76", percentage: "13.95%", upOrDown: "down" },
];

// Function to populate the statistic area
function populateStatisticArea() {
  statistics.forEach(stat => {
      // Update progress circle
      const progressElement = document.getElementById(stat.progressId);
      progressElement.style.setProperty("--percentage", stat.progressValue);

      // Update amount
      const amountElement = document.getElementById(stat.amountId);
      amountElement.textContent = stat.amount;

      // Update percentage
      const percentageElement = document.getElementById(stat.percentageId);
      percentageElement.textContent = stat.percentage;

      // Update arrow direction class based on upOrDown value
      const arrowElement = document.getElementById(stat.arrowId);
      arrowElement.className = `arrow ${stat.upOrDown === 'up' ? '' : 'down'}`;
  });
}


const todos = [
  { title: "Assign new patients to therapists", time: "11 JUL 8:10 PM" },
  { title: "Create identity information for new therapists", time: "11 JUL 11 PM" },
  { title: "Monitoring statistics", time: "11 JUL 7:00 PM" },
  { title: "Review patient feedback", time: "12 JUL 9:30 AM" },
  { title: "Prepare weekly report", time: "12 JUL 3:15 PM" },
  { title: "Schedule follow-up meetings", time: "13 JUL 2:00 PM" },
  { title: "Schedule follow-up meetings", time: "13 JUL 2:00 PM" },
  { title: "Schedule follow-up meetings", time: "13 JUL 2:00 PM" },
  { title: "Schedule follow-up meetings", time: "13 JUL 2:00 PM" },{ title: "Schedule follow-up meetings", time: "13 JUL 2:00 PM" },
  { title: "Schedule follow-up meetings", time: "13 JUL 2:00 PM" },
];

function populateTodoList() {
  const todoContainer = document.querySelector(".todo .care-scroll");
  todoContainer.innerHTML = ''; // Clear existing items

  todos.forEach(todo => {
      const todoItem = document.createElement("div");
      todoItem.className = "todo-item";
      todoItem.innerHTML = `
          <div class="circle"></div>
          <div class="task-content">
              <p class="task-title">${todo.title}</p>
              <p class="task-time">${todo.time}</p>
          </div>
      `;
      todoContainer.appendChild(todoItem);
  });
}


// chart.js

// Function to initialize and update the chart
function updateChart(data, timeRange) {
  var patientChart = echarts.init(document.getElementById('patient-chart'));

  var option = {
      title: {
          text: `{mainText|${data.mainText}} {subText|Patients}`,
          left: '10px',
          top: '10px',
          textStyle: {
              rich: {
                  mainText: {
                      fontSize: 24,
                      fontWeight: 'bold',
                      color: '#333'
                  },
                  subText: {
                      fontSize: 12,
                      color: '#666',
                      padding: [0, 0, 0, 10] 
                  }
              }
          }
      },
      tooltip: {
          trigger: 'axis',
          backgroundColor: 'rgba(255, 255, 255, 0.8)',
          borderColor: '#ccc',
          borderWidth: 1,
          textStyle: {
              color: '#333'
          }
      },
      legend: {
          data: ['Visiter', 'Register'],
          top: '10px',
          left: 'center',
          itemWidth: 8,
          itemHeight: 8,
          textStyle: {
              color: '#8A92A6'
          },
          orient: 'horizontal',
          icon: 'circle',
      },
      grid: {
          left: '1%',
          right: '2%',
          bottom: '3%',
          top: '20%',
          containLabel: true
      },
      xAxis: {
          type: 'category',
          boundaryGap: false,
          data: timeRange,
          axisLine: {
              show: false
          },
          axisTick: {
              show: false
          },
          axisLabel: {
              color: '#666'
          }
      },
      yAxis: {
          type: 'value',
          axisLine: {
              show: false
          },
          axisTick: {
              show: false
          },
          axisLabel: {
              color: '#666'
          },
          splitLine: {
              lineStyle: {
                  color: '#eee'
              }
          }
      },
      series: [
          {
              name: 'Visiter',
              type: 'line',
              smooth: true,
              showSymbol: false,
              areaStyle: {
                  color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                      { offset: 0, color: 'rgba(58, 87, 232, 0.4)' },
                      { offset: 1, color: 'rgba(58, 87, 232, 0.1)' }
                  ])
              },
              lineStyle: {
                  color: '#3A57E8',
                  width: 2
              },
              data: data.visiter
          },
          {
              name: 'Register',
              type: 'line',
              smooth: true,
              showSymbol: false,
              areaStyle: {
                  color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                      { offset: 0, color: 'rgba(133, 244, 250, 0.4)' },
                      { offset: 1, color: 'rgba(133, 244, 250, 0.1)' }
                  ])
              },
              lineStyle: {
                  color: '#85F4FA',
                  width: 2
              },
              data: data.register
          }
      ],
      color: ['#3A57E8', '#85F4FA']
  };

  //patientChart.setOption(option);

  // Handle window resizing
  window.addEventListener('resize', function() {
      //patientChart.resize();
  });
}

// Mock data for demonstration
const mockData = {
  mainText: '855.8K',
  visiter: [90, 81, 85, 92, 88, 87, 85, 90],
  register: [14, 23, 35, 45, 42, 45, 55, 44]
};

const mockTimeRange = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug'];


// diagnostic.js

// Mock data for diagnostic chart
const diagnosticData = {
  blue: { percentage: 75, value: '212K', label: 'Insomnia' },
  cyan: { percentage: 25, value: '106K', label: 'Paranoea' }
};

// Function to update the diagnostic chart
function updateDiagnosticChart(data) {
  // Update blue segment
  const blueSegment = document.getElementById('segment-blue');
  blueSegment.style.setProperty('--percentage', data.blue.percentage);

  const insomniaValue = document.getElementById('insomnia-value');
  insomniaValue.textContent = data.blue.value;

  // Update cyan segment
  const cyanSegment = document.getElementById('segment-cyan');
  cyanSegment.style.setProperty('--percentage', data.cyan.percentage);

  const paranoeaValue = document.getElementById('paranoea-value');
  paranoeaValue.textContent = data.cyan.value;
}




















// Initialize data on page load
window.addEventListener("DOMContentLoaded", () => {

  populateStatisticArea();

  populateTodoList();

  updateChart(mockData, mockTimeRange);

  updateDiagnosticChart(diagnosticData);
});
