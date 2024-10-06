document.addEventListener('DOMContentLoaded', function() {
  // Assuming eventData is already available as a JavaScript variable
  if (!eventData) {
      console.error('No event data found.');
      return;
  }

  const calendarElement = document.getElementById('calendar'); // Assuming this is your calendar container

  // Clear previous events
  calendarElement.innerHTML = '';

  eventData.forEach(event => {
      // Create an event block or row for each event
      const eventDiv = document.createElement('div');
      eventDiv.classList.add('event'); // Add a class for styling
      
      // Create the event content
      const groupName = event.group_name;
      const meetingDate = new Date(event.meeting_date);
      const meetingTime = event.meeting_time;
      const leader = event.leader;
      
      eventDiv.innerHTML = `
          <h3>${groupName}</h3>
          <p>${meetingDate.toLocaleDateString()} at ${meetingTime}</p>
          <p>Leader: ${leader}</p>
      `;
      
      // Append the event to the calendar container
      calendarElement.appendChild(eventDiv);
  });
});