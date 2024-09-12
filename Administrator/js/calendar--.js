document.addEventListener('DOMContentLoaded', function () {
  const currentMonthElement = document.querySelector('.current-month');
  const calendarDatesElement = document.querySelector('.calendar-dates');
  const prevMonthButton = document.querySelector('.prev-month');
  const nextMonthButton = document.querySelector('.next-month');

  const today = new Date();
  let currentMonth = today.getMonth();
  let currentYear = today.getFullYear();

  function renderCalendar(month, year) {
      currentMonthElement.textContent = new Date(year, month).toLocaleString('default', { month: 'long', year: 'numeric' });
      calendarDatesElement.innerHTML = '';
      const firstDay = new Date(year, month, 1).getDay();
      const today = new Date().getDate();
      const currentMonth = new Date().getMonth();
      const daysInMonth = new Date(year, month + 1, 0).getDate();

      for (let i = 0; i < firstDay; i++) {
        const noneElement = document.createElement('div');
        noneElement.style.pointerEvents = 'none';
          calendarDatesElement.appendChild(noneElement);
      }

      for (let i = 1; i <= daysInMonth; i++) {
          const dateElement = document.createElement('div');
          dateElement.classList.add('day');
          if(i == today && month == currentMonth) {
            dateElement.classList.add('selected');
          }
          dateElement.textContent = i;
          dateElement.addEventListener('click', function () {
            // Remove the 'selected' class from all day elements
            document.querySelectorAll('.day').forEach(day => {
                day.classList.remove('selected');
            });
            // Add the 'selected' class to the clicked element
            dateElement.classList.add('selected');
          });
          calendarDatesElement.appendChild(dateElement);
      }
  }

  prevMonthButton.addEventListener('click', function () {
      currentMonth--;
      if (currentMonth < 0) {
          currentMonth = 11;
          currentYear--;
      }
      renderCalendar(currentMonth, currentYear);
  });

  nextMonthButton.addEventListener('click', function () {
      currentMonth++;
      if (currentMonth > 11) {
          currentMonth = 0;
          currentYear++;
      }
      renderCalendar(currentMonth, currentYear);
  });

  renderCalendar(currentMonth, currentYear);
});
