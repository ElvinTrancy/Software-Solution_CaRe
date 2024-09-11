document.addEventListener("DOMContentLoaded", function() {
    // select
    const moodButtons = document.querySelectorAll(".mood-buttons button");
    
    moodButtons.forEach(button => {
        button.addEventListener("click", function() {
            moodButtons.forEach(btn => btn.classList.remove("active"));
            button.classList.add("active");
        });
    });

    // roll
    const scrollContainer = document.getElementById("scroll-container");
    const percentageDisplay = document.getElementById("percentage-display");

    scrollContainer.addEventListener("scroll", function() {
        const scrollHeight = scrollContainer.scrollHeight - scrollContainer.clientHeight;
        const scrollTop = scrollContainer.scrollTop;

        
        const scrollPercent = (scrollTop / scrollHeight) * 100;

        // display
        if (scrollPercent < 20) {
            percentageDisplay.textContent = "Nutrient";
        } else if (scrollPercent < 40) {
            percentageDisplay.textContent = "Whole";
        } else if (scrollPercent < 60) {
            percentageDisplay.textContent = "Processed";
        } else if (scrollPercent < 80) {
            percentageDisplay.textContent = "Energy";
        } else {
            percentageDisplay.textContent = "Junk";
        }
    });
});
