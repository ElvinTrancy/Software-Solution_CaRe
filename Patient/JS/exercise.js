document.addEventListener("DOMContentLoaded", function() {
    const sliderThumb = document.getElementById("slider-thumb");
    const sliderProgress = document.getElementById("slider-progress");
    const fitnessLevelText = document.getElementById("fitness-level-text");

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
        const progressWidth = (initialProgressPercent / 100) * sliderContainerWidth;

        sliderProgress.style.width = `${initialProgressPercent}%`;
        sliderThumb.style.right = `${100 - initialProgressPercent}%`;

        // Set the fitness level text based on the initial progress
        fitnessLevelText.textContent = levels[currentLevel];
    }

    initializeThumbPosition();  // Call this function to set initial positions

    // Handle slider thumb drag
    sliderThumb.addEventListener("mousedown", function(e) {
        document.addEventListener("mousemove", onDrag);
        document.addEventListener("mouseup", function() {
            document.removeEventListener("mousemove", onDrag);
        });
    });

    function onDrag(e) {
        const sliderContainerWidth = sliderProgress.parentElement.offsetWidth;
        let newPosition = (e.clientX - sliderProgress.parentElement.getBoundingClientRect().left);

        // Ensure the thumb stays within bounds
        if (newPosition < 0) newPosition = 0;
        if (newPosition > sliderContainerWidth) newPosition = sliderContainerWidth - 1;

        const progressPercent = (newPosition / sliderContainerWidth) * 100;
        sliderProgress.style.width = `${progressPercent}%`;
        sliderThumb.style.right = `${100 - progressPercent}%`;

        // Adjust level text based on the slider position
        const newLevel = Math.floor(progressPercent / 20);
        if (newLevel !== currentLevel) {
            currentLevel = newLevel;
            fitnessLevelText.textContent = levels[currentLevel];
        }
    }
});
