document.addEventListener("DOMContentLoaded", function() {
    const dropdownButton = document.getElementById("dropdownButton");
    const dropdownContent = document.getElementById("dropdownContent");
    const dropdownItems = document.querySelectorAll(".dropdown-item");

    // Toggle dropdown visibility
    dropdownButton.addEventListener("click", function() {
        dropdownContent.style.display = dropdownContent.style.display === "block" ? "none" : "block";
    });

    // Hide dropdown and update button text on selecting an option
    dropdownItems.forEach(function(item) {
        item.addEventListener("click", function(e) {
            e.preventDefault(); // Prevent the default link action
            const selectedValue = item.getAttribute("data-value");
            dropdownButton.innerHTML = `${selectedValue} <span class="arrow">&#9660;</span>`;
            dropdownContent.style.display = "none"; // Hide dropdown after selection
        });
    });

    // Hide dropdown if clicked outside
    window.addEventListener("click", function(event) {
        if (!dropdownButton.contains(event.target) && !dropdownContent.contains(event.target)) {
            dropdownContent.style.display = "none";
        }
    });
});

document.getElementById("dropdownButton").addEventListener("click", function() {
    var dropdownContent = document.getElementById("dropdownContent");
    if (dropdownContent.style.display === "block") {
        dropdownContent.style.display = "none";
    } else {
        dropdownContent.style.display = "block";
    }
});



