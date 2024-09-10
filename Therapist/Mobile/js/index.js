
// Mock data for the doctor and patients
const mockData = {
  doctor: {
    name: "Dr. DeHui",
    photo: "images/image 1.png"
  },
  schedule: [
    { date: "9", week: "MON" },
    { date: "10", week: "TUE" },
    { date: "11", week: "WED", active: true },
    { date: "12", week: "THU" },
    { date: "13", week: "FRI" },
    { date: "14", week: "SAT" }
  ],
  reminder: {
    doctor: "Dr. Olivia Turner, M.D.",
    treatment: "Treatment and prevention of skin and photodermatitis."
  },
  patients: [
    { name: "Olivia Turner, M.D.", msg: "I haven’t been eating well lately, please help me.", photo: "images/YinaNa.jpg" },
    { name: "Tao Zhe", msg: "I’ve been feeling dizzy recently.", photo: "images/TaoZhe.jpeg" },
    { name: "San Meng", msg: "I have trouble sleeping.", photo: "images/SanMeng.jpg" },
    { name: "Yao Shui", msg: "I have joint pain.", photo: "images/YaoShui.jpg" }
  ],
  currentLoad: {
    activePatients: 99,
    appointments: 120
  }
};

document.addEventListener("DOMContentLoaded", function () {
  // Populate Doctor Information
  const doctorName = document.querySelector(".welcome h2");
  const doctorPhoto = document.querySelector(".doctor-photo");
  doctorName.textContent = mockData.doctor.name;
  doctorPhoto.src = mockData.doctor.photo;

  // Populate Schedule
  const datesContainer = document.querySelector(".dates");
  datesContainer.innerHTML = ""; // Clear the current static HTML
  mockData.schedule.forEach(item => {
    const dateDiv = document.createElement("div");
    dateDiv.classList.add("date");
    if (item.active) {
      dateDiv.classList.add("active");
    }
    dateDiv.innerHTML = `<span class="date-number">${item.date}</span> <span class="date-week">${item.week}</span>`;
    datesContainer.appendChild(dateDiv);
  });

  // Populate Reminder Details
  const reminderDoctor = document.querySelector(".reminder p");
  const reminderTreatment = document.querySelector(".reminder span");
  reminderDoctor.textContent = mockData.reminder.doctor;
  reminderTreatment.textContent = mockData.reminder.treatment;

  // Populate Patients
  const patientCardsContainer = document.querySelector(".patient-cards");
  patientCardsContainer.innerHTML = ""; // Clear current static HTML
  mockData.patients.forEach(patient => {
    const patientCard = document.createElement("div");
    patientCard.classList.add("patient-card");
    patientCard.innerHTML = `
      <img src="${patient.photo}" alt="${patient.name}" class="patient-photo">
      <p class="patient-name">${patient.name}</p>
      <p class="patient-msg">"${patient.msg}"</p>
      <button class="contact-btn">Contact</button>
    `;
    patientCardsContainer.appendChild(patientCard);
  });

  // Populate Current Load Summary
  document.querySelector(".blue-card .count").textContent = mockData.currentLoad.activePatients;
  document.querySelector(".red-card .count").textContent = mockData.currentLoad.appointments;
});



// Select the canvas element
const canvas = document.getElementById('waveChart');
const ctx = canvas.getContext('2d');

// Set up the canvas styling
ctx.fillStyle = '#2260FF'; // Set the background color (same as your image)
ctx.fillRect(0, 0, canvas.width, canvas.height);

// Set up line styling
ctx.lineWidth = 10;  // Thickness of the line
ctx.strokeStyle = '#FFFFFF';  // Color of the line

// Start the line path
ctx.beginPath();
ctx.moveTo(0, 150);  // Starting point

// Create the wave using quadratic curves
ctx.quadraticCurveTo(50, 100, 100, 150);  // First curve
ctx.quadraticCurveTo(150, 200, 200, 150);  // Second curve
ctx.quadraticCurveTo(250, 100, 300, 150);  // Third curve
ctx.quadraticCurveTo(350, 200, 400, 150);  // Fourth curve
ctx.quadraticCurveTo(450, 100, 500, 150);  // Fifth curve

// Draw the line
ctx.stroke();

// Set up the second wave overlay
ctx.lineWidth = 10; // Slightly thinner line for the blue shadow effect
ctx.strokeStyle = 'rgba(255, 255, 255, 0.5)';  // Lighter blue for shadow

ctx.beginPath();
ctx.moveTo(100, 150);  // Offset start
ctx.quadraticCurveTo(150, 200, 200, 150);
ctx.quadraticCurveTo(250, 100, 300, 150);
ctx.quadraticCurveTo(350, 200, 400, 150);
ctx.stroke();

// Select the canvas element
const canvas1 = document.getElementById('linechart');
const ctx1 = canvas1.getContext('2d');

// Set the canvas background color
ctx1.fillStyle = '#FF5C5C';  // Set white background
ctx1.fillRect(0, 0, canvas.width, canvas.height);

// Draw a new curved line
ctx1.beginPath();
ctx1.moveTo(50, 150);  // Start at point (50, 150)

// Create a different wavy pattern using quadraticCurveTo
ctx1.quadraticCurveTo(100, 50, 150, 100);  // First curve (control point at 100, 50, ending at 150, 100)
ctx1.quadraticCurveTo(200, 150, 250, 50);  // Second curve (control point at 200, 150, ending at 250, 50)
ctx1.quadraticCurveTo(300, 0, 350, 100);   // Third curve (control point at 300, 0, ending at 350, 100)
ctx1.quadraticCurveTo(400, 150, 450, 50);  // Fourth curve (control point at 400, 150, ending at 450, 50)

// Set line properties
ctx1.lineWidth = 5;  // Set the thickness of the line
ctx1.strokeStyle = '#FFFFFF';  // Set the color of the line to orange
ctx1.stroke();

// Optional: Add circles at curve points for emphasis
ctx1.fillStyle = '#FFFFFF';  // Set fill color for the circles
ctx1.beginPath();
ctx1.arc(150, 100, 5, 0, Math.PI * 2);  // Circle at (150, 100)
ctx1.fill();

ctx1.beginPath();
ctx1.arc(250, 50, 5, 0, Math.PI * 2);  // Circle at (250, 50)
ctx1.fill();

ctx1.beginPath();
ctx1.arc(350, 100, 5, 0, Math.PI * 2);  // Circle at (350, 100)
ctx1.fill();

ctx1.beginPath();
ctx1.arc(450, 50, 5, 0, Math.PI * 2);  // Circle at (450, 50)
ctx1.fill();

