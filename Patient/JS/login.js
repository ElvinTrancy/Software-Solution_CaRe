
    // Wait for the DOM to load before attaching event listeners
    document.addEventListener('DOMContentLoaded', function() {
        // Selecting elements
        const emailInput = document.getElementById('email');
        const passwordInput = document.getElementById('password');
        const signInButton = document.querySelector('.sign-in');
        const emailError = document.querySelectorAll('.error-message')[0];
        const passwordError = document.querySelectorAll('.error-message')[1];

        // Email validation regex
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        
        // Password validation regex (minimum 6 characters, contains letters and numbers)
        const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$/;

        // Function to display error
        function showError(input, errorElement, message) {
            input.parentElement.classList.add('error'); // Add error class to input-box
            errorElement.querySelector('span').textContent = message; // Display the error message
            errorElement.style.display = 'block'; // Make the error visible
        }

        // Function to hide error
        function hideError(input, errorElement) {
            input.parentElement.classList.remove('error'); // Remove error class
            errorElement.style.display = 'none'; // Hide the error message
        }

        // Validate the form when clicking the sign-in button
        signInButton.addEventListener('click', function(event) {
            // Validate email
            if (!emailRegex.test(emailInput.value.trim())) {
                showError(emailInput, emailError, "ERROR: Wrong Email!");
                event.preventDefault(); // Prevent form submission
                return; // Stop execution if email is invalid
            }

            // Validate password
            if (!passwordRegex.test(passwordInput.value.trim())) {
                showError(passwordInput, passwordError, "ERROR: Password must be at least 6 characters and contain letters and numbers!");
                event.preventDefault(); // Prevent form submission
                return; // Stop execution if password is invalid
            }

            // If valid, navigate to home.html
            window.location.href = 'index.html';
        });

        // Remove error state on input change
        emailInput.addEventListener('input', function() {
            hideError(emailInput, emailError); // Remove error state when user types in the email input
        });

        passwordInput.addEventListener('input', function() {
            hideError(passwordInput, passwordError); // Remove error state when user types in the password input
        });
    });
