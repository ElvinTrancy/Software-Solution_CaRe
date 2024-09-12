class Modal {
    constructor(id) {
        this.id = id; // Assign a unique ID to each modal instance

        // Create modal structure
        this.modalMask = this.createElement('div', `modal-mask-${this.id}`, 'modal-mask');
        document.body.appendChild(this.modalMask);

        this.modalWrap = this.createElement('div', `modal-wrap-${this.id}`, 'modal-wrap');
        this.modalMask.appendChild(this.modalWrap);

        this.modalContent = this.createElement('div', `modal-content-${this.id}`, 'modal-content');
        this.modalWrap.appendChild(this.modalContent);

        this.modalCloseButton = this.createElement('button', `modal-close-${this.id}`, 'modal-close');
        this.modalCloseButton.innerHTML = '&times;';
        this.modalContent.appendChild(this.modalCloseButton);

        this.modalHeader = this.createElement('div', `modal-header-${this.id}`, 'modal-header');
        this.modalContent.appendChild(this.modalHeader);

        this.modalBody = this.createElement('div', `modal-body-${this.id}`, 'modal-body');
        this.modalContent.appendChild(this.modalBody);

        this.modalFooter = this.createElement('div', `modal-footer-${this.id}`, 'modal-footer');
        this.modalContent.appendChild(this.modalFooter);

        this.cancelButton = this.createElement('button', `cancel-button-${this.id}`, 'btn btn-normal btn-small');
        this.cancelButton.textContent = 'Cancel';
        this.modalFooter.appendChild(this.cancelButton);

        this.okButton = this.createElement('button', `ok-button-${this.id}`, 'btn btn-primary btn-small');
        this.okButton.textContent = 'OK';
        this.modalFooter.appendChild(this.okButton);

        

        // Event listeners
        this.modalCloseButton.addEventListener('click', () => this.hide());
        this.cancelButton.addEventListener('click', () => this.hide());

        document.addEventListener('keydown', (event) => this.handleKeyPress(event));
    }

    // Helper function to create an element with ID and class
    createElement(tag, id, className) {
        const element = document.createElement(tag);
        element.id = id;
        element.className = className;
        return element;
    }

    handleKeyPress(event) {
        if (event.key === 'Escape' || event.key === 'Esc' || event.keyCode === 27) {
            this.hide();
        }
    }

    show({ title = 'Default Title', content = 'Default content...', okText = 'OK', cancelText = 'Cancel' }, onSuccess, onCancel) {
        this.modalHeader.textContent = title;
        this.modalBody.innerHTML = content;
        this.okButton.textContent = okText;
        this.cancelButton.textContent = cancelText;

        // Display the modal
        this.modalMask.style.display = 'block';
        this.modalWrap.style.display = 'flex';


        this.okButton.addEventListener('click', (e) => {
            if (onSuccess) onSuccess(e);
        });

        this.cancelButton.onclick = () => {
            if (onCancel) onCancel();
            this.hide();
        };
    }

    hide() {
        this.modalMask.style.display = 'none';
        this.modalWrap.style.display = 'none';
    }
}

