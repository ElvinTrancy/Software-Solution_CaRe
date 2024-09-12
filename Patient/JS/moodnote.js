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
    const scrollContainer = document.getElementById('scroll-container');
    const images = scrollContainer.getElementsByTagName('img');
    const percentageDisplay = document.getElementById("percentage-display");

    scrollContainer.addEventListener("scroll", function() {
        //centerImageOnScroll();
        const scrollWidth = scrollContainer.scrollWidth - scrollContainer.clientWidth;
        const scrollLeft = scrollContainer.scrollLeft;

       
        const scrollPercent = (scrollLeft / scrollWidth) * 100;

        // display
        if (scrollPercent < 20) {
            percentageDisplay.textContent = "I'm feeling depressed.";
        } else if (scrollPercent < 40) {
            percentageDisplay.textContent = "I'm feeling sad.";
        } else if (scrollPercent < 60) {
            percentageDisplay.textContent = "I'm feeling neutral.";
        } else if (scrollPercent < 80) {
            percentageDisplay.textContent = "I'm feeling happy.";
        } else {
            percentageDisplay.textContent = "I'm feeling overjoyed.";
        }
    });

    function centerImageOnScroll() {
        let containerRect = scrollContainer.getBoundingClientRect();
        let closestImg = null;
        let closestDistance = Number.MAX_VALUE;

        for (let img of images) {
            let imgRect = img.getBoundingClientRect();
            let imgCenter = imgRect.left + imgRect.width / 2;
            let containerCenter = containerRect.left + containerRect.width / 2;
            let distance = Math.abs(imgCenter - containerCenter);

            // Find the image closest to the center of the container
            if (distance < closestDistance) {
                closestImg = img;
                closestDistance = distance;
            }
        }

        if (closestImg) {
            // Scroll the container to center the closest image
            scrollContainer.scrollTo({
                left: closestImg.offsetLeft - (scrollContainer.offsetWidth / 2) + (closestImg.offsetWidth / 2),
                behavior: 'smooth'
            });

            // Optional: Highlight the active image
            for (let img of images) {
                img.classList.remove('active');
            }
            closestImg.classList.add('active');
        }
    }
});