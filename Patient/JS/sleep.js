document.addEventListener("DOMContentLoaded", function() {
  const sliderThumb = document.getElementById("slider-thumb");
  const sliderProgress = document.getElementById("slider-progress");
  const fitnessLevelText = document.getElementById("sleep-level-text");

  const levels = [
      "Level 1 (1 Hour/Day)",
      "Level 2 (3 Hour/Day)",
      "Level 3 (6 Hour/Day)",
      "Level 4 (9 Hour/Day)",
      "Level 5 (12 Hour/Day)"
  ];

  // Initialize slider
  let currentLevel = 2;  // Set to Level 3 (60%)
  const initialProgressPercent = 60; // Initialize progress to 60% (for Level 3)

  // Set initial thumb and progress position based on the initial level
  function initializeThumbPosition() {
      const sliderContainerWidth = sliderProgress.parentElement.offsetWidth;

      sliderProgress.style.width = `${initialProgressPercent}%`;
      sliderThumb.style.right = `${100 - initialProgressPercent}%`;

      // Set the fitness level text based on the initial progress
      fitnessLevelText.textContent = levels[currentLevel];
  }

  initializeThumbPosition();  // Call this function to set initial positions

  // Variables to track dragging state
  let isDragging = false;

  // Handle slider thumb drag
  sliderThumb.addEventListener("mousedown", startDrag);
  sliderThumb.addEventListener("touchstart", startDrag, { passive: false });

  function startDrag(e) {
      e.preventDefault(); // Prevent default touch behaviors (e.g., scrolling)
      isDragging = true;

      document.addEventListener("mousemove", onDrag);
      document.addEventListener("mouseup", endDrag);

      document.addEventListener("touchmove", onDrag, { passive: false });
      document.addEventListener("touchend", endDrag);
  }

  function onDrag(e) {
      if (!isDragging) return;

      e.preventDefault(); // Prevent default touch behaviors during dragging

      let clientX;

      if (e.type.startsWith('touch')) {
          clientX = e.touches[0].clientX;
      } else if (e.type.startsWith('mouse')) {
          clientX = e.clientX;
      } else {
          return;
      }

      const sliderContainer = sliderProgress.parentElement;
      const sliderContainerWidth = sliderContainer.offsetWidth;
      const containerLeft = sliderContainer.getBoundingClientRect().left;

      let newPosition = clientX - containerLeft;

      // Ensure the thumb stays within bounds
      if (newPosition < 0) newPosition = 0;
      if (newPosition > sliderContainerWidth) newPosition = sliderContainerWidth;

      const progressPercent = (newPosition / sliderContainerWidth) * 100;
      sliderProgress.style.width = `${progressPercent}%`;
      sliderThumb.style.right = `${100 - progressPercent}%`;

      // Adjust level text based on the slider position
      const newLevel = Math.floor(progressPercent / 20); // Assuming 5 levels
      if (newLevel !== currentLevel && newLevel >= 0 && newLevel < levels.length) {
          currentLevel = newLevel;
          fitnessLevelText.textContent = levels[currentLevel];
      }
  }

  function endDrag() {
      isDragging = false;

      document.removeEventListener("mousemove", onDrag);
      document.removeEventListener("mouseup", endDrag);

      document.removeEventListener("touchmove", onDrag);
      document.removeEventListener("touchend", endDrag);
  }
});
