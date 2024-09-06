const confirmModal = (() => {
  // Create modal elements dynamically
  const modalHTML = `
      <div class="modal-wrap" style="position: absolute; width: 450px">
          <div class="modal-content">
              <div class="modal-header">
                  <h2 class="modal-title" style="font-size: 1rem" id="confirm-modal-message">Message</h2>
              </div>
              <div class="modal-body">
                  <div class="modal-icon-message">
                      <span class="modal-icon">⚠️</span>
                      <p class="modal-message" id="confirm-modal-warning" style="display: none; color: red;"></p>
                  </div>
                  <div class="modal-buttons">
                        <button id="confirm-ok-btn" class="modal-btn alert">OK</button>
                        <button id="confirm-cancel-btn" class="modal-btn">Cancel</button>
                    </div>
              </div>
          </div>
      </div>
  `;

  // Create a modal container and append to the body
  const modalContainer = document.createElement('div');
  modalContainer.id = 'custom-confirm-modal';
  modalContainer.className = 'modal-mask';
  modalContainer.style.display = 'none';
  modalContainer.innerHTML = modalHTML;
  document.body.appendChild(modalContainer);

  // Function to show the modal
  function show(message, warning = '', onConfirm, onCancel, okText = 'OK', cancelText = 'Cancel') {
      // Set the message
      document.getElementById('confirm-modal-message').textContent = message;

      // Set the warning message, if provided
      const warningElement = document.getElementById('confirm-modal-warning');
      if (warning) {
          warningElement.textContent = warning;
          warningElement.style.display = 'block';
      } else {
          warningElement.style.display = 'none';
      }

      // Set button text
      document.getElementById('confirm-ok-btn').textContent = okText;
      document.getElementById('confirm-cancel-btn').textContent = cancelText;

      // Show the modal
      modalContainer.style.display = 'flex';

      // Set up event listeners for buttons
      document.getElementById('confirm-ok-btn').onclick = function() {
          if (onConfirm) onConfirm();
          hide();
      };

      document.getElementById('confirm-cancel-btn').onclick = function() {
          if (onCancel) onCancel();
          hide();
      };
  }

  // Function to hide the modal
  function hide() {
      modalContainer.style.display = 'none';
  }

  // Public API
  return {
      show,
      hide
  };
})();
