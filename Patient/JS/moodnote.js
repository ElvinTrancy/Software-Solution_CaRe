document.addEventListener("DOMContentLoaded", function() {
    // select
    const moodButtons = document.querySelectorAll(".mood-buttons button");
    
    moodButtons.forEach(button => {
        button.addEventListener("click", function() {
            moodButtons.forEach(btn => btn.classList.remove("active"));
            button.classList.add("active");
        });
    });

    // roll-horizon
    const scrollContainer = document.getElementById("scroll-container");
    const percentageDisplay = document.getElementById("percentage-display");

    scrollContainer.addEventListener("scroll", function() {
        const scrollWidth = scrollContainer.scrollWidth - scrollContainer.clientWidth;
        const scrollLeft = scrollContainer.scrollLeft;

       
        const scrollPercent = (scrollLeft / scrollWidth) * 100;

        // display
        if (scrollPercent < 20) {
            percentageDisplay.textContent = "10%";
        } else if (scrollPercent < 40) {
            percentageDisplay.textContent = "20%";
        } else if (scrollPercent < 60) {
            percentageDisplay.textContent = "50%";
        } else if (scrollPercent < 80) {
            percentageDisplay.textContent = "80%";
        } else {
            percentageDisplay.textContent = "100%";
        }
    });
});