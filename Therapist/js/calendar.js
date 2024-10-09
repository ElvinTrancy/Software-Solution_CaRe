// JavaScript to generate the calendar and handle event data

const calendarBody = document.getElementById("calendar-body");
const monthYear = document.getElementById("calendar-month-year");


document.getElementById('prev-month').addEventListener('click', () => changeMonth(-1));
document.getElementById('next-month').addEventListener('click', () => changeMonth(1));


const eventTypes = [
  { name: 'Therapy Sessions', className: 'purple' },
  { name: 'Client Meetings', className: 'pink' },
  { name: 'Continuing Education', className: 'orange' },
  { name: 'Personal Therapy', className: 'purple' },
];

function generateRandomEvents(year, month, numEvents = 10) {
  const events = [];
  const daysInMonth = new Date(year, month + 1, 0).getDate();

  for (let i = 0; i < numEvents; i++) {
      const randomDay = Math.floor(Math.random() * daysInMonth) + 1;
      const randomEventIndex = Math.floor(Math.random() * eventTypes.length);
      const randomEvent = eventTypes[randomEventIndex];

      // Check if the day already has an event
      const existingEventIndex = events.findIndex(event => event.date === `${year}-${(month + 1).toString().padStart(2, '0')}-${randomDay.toString().padStart(2, '0')}`);

      if (existingEventIndex !== -1) {
          // Add another event to the same day (allowing multiple events per day)
          events[existingEventIndex].multipleEvents.push(randomEvent);
      } else {
          // Add a new event for the day
          events.push({
              date: `${year}-${(month + 1).toString().padStart(2, '0')}-${randomDay.toString().padStart(2, '0')}`,
              multipleEvents: [randomEvent]
          });
      }
  }

  return events;
}
function generateCalendar(date, events) {
    // Clear previous dates
    calendarBody.innerHTML = '';

    const year = date.getFullYear();
    const month = date.getMonth();

    monthYear.textContent = date.toLocaleDateString('en-US', { year: 'numeric', month: 'long' });

    const firstDayOfMonth = new Date(year, month, 1).getDay();
    const daysInMonth = new Date(year, month + 1, 0).getDate();
    const daysInPreviousMonth = new Date(year, month, 0).getDate(); // Days in the previous month

    let dateCount = 1;
    let row = document.createElement('tr');

    // Adjust so Monday is the first day of the week
    let startDay = firstDayOfMonth === 0 ? 6 : firstDayOfMonth - 1;

    // Filling in blank days before the 1st of the month (previous month's dates)
    for (let i = 0; i < startDay; i++) {
        const emptyCell = document.createElement('td');
        emptyCell.classList.add('striped'); // Add the striped background
        emptyCell.textContent = daysInPreviousMonth - startDay + i + 1; // Fill with previous month's dates
        row.appendChild(emptyCell);
    }

    let lastRow;
    let rowCount = 1; // Track the number of rows generated

    // Adding all the days of the current month
    while (dateCount <= daysInMonth) {
        for (let i = startDay; i < 7; i++) {
            const cell = document.createElement('td');
            if (dateCount > daysInMonth) break;

            cell.textContent = dateCount;

            const eventDate = new Date(year, month, dateCount).toISOString().slice(0, 10);
            
            const eventForDate = events.filter(event => event.meeting_date === eventDate);
            //console.log(eventForDate);
            // If events are found for the current date
            if (eventForDate && eventForDate.length > 0) {
                eventForDate.forEach(eventForDay => {
                    const eventSpan = document.createElement('span');
                    const randomClass = getRandomClass(); // Get a random class for each event
                    eventSpan.classList.add('event', randomClass);
                    eventSpan.textContent = eventForDay.group_name;
                    cell.appendChild(eventSpan);
                });
            }

            row.appendChild(cell);
            dateCount++;
        }

        calendarBody.appendChild(row);
        lastRow = row;
        row = document.createElement('tr');
        startDay = 0; // Reset to 0 for the following rows
        rowCount++; // Increment the row count
    }

    // Filling in blank days after the last day of the month (next month's dates)
    let nextMonthDay = 1;
    let remainingCells = 7 - lastRow.childNodes.length; // Calculate how many cells are left in the current row

    if (remainingCells !== 7) {
        for (let i = 0; i < remainingCells; i++) {
            const emptyCell = document.createElement('td');
            emptyCell.classList.add('striped'); // Add the striped background
            emptyCell.textContent = nextMonthDay++; // Fill with next month's dates
            lastRow.appendChild(emptyCell);
        }
    }

    // Calculate and set the height for each td element
    const calendarContainer = document.querySelector('.calendar-container');
    const availableHeight = calendarContainer.clientHeight; // Get available height of container
    const tdHeight = availableHeight / rowCount; // Divide by the number of rows

    // Apply the height to each td
    const allCells = document.querySelectorAll('.calendar-table td');
    allCells.forEach(cell => {
        cell.style.height = `${tdHeight}px`;
    });
}

// Function to get a random class for the event
function getRandomClass() {
    const classes = ['purple', 'pink', 'orange'];
    return classes[Math.floor(Math.random() * classes.length)];
}









function changeMonth(offset) {
    currentDate.setMonth(currentDate.getMonth() + offset);
    generateCalendar(currentDate);
}

