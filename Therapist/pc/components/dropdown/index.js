// dropdown.js

class Dropdown {
  constructor(dropdownElement) {
      this.dropdownElement = dropdownElement;
      this.selectedPeriod = this.dropdownElement.querySelector('.selected-period');
      this.dropdownMenu = this.dropdownElement.querySelector('.dropdown-menu');
      this.dropdownItems = this.dropdownMenu.querySelectorAll('.dropdown-item');

      this.init();
  }

  init() {
      this.dropdownElement.addEventListener('click', (event) => {
          this.toggleDropdown(event);
      });

      this.dropdownItems.forEach(item => {
          item.addEventListener('click', () => {
              this.selectItem(item);
          });
      });

      document.addEventListener('click', (event) => {
          this.closeDropdown(event);
      });
  }

  toggleDropdown(event) {
      event.stopPropagation(); // Prevent click from propagating to document
      this.dropdownElement.classList.toggle('active');
  }

  selectItem(item) {
      this.selectedPeriod.textContent = item.textContent;
      this.dropdownElement.classList.remove('active');
  }

  closeDropdown(event) {
      if (!this.dropdownElement.contains(event.target)) {
          this.dropdownElement.classList.remove('active');
      }
  }
}

// Initialize all dropdowns on the page
document.addEventListener('DOMContentLoaded', () => {
  const dropdowns = document.querySelectorAll('.dropdown');
  dropdowns.forEach(dropdown => new Dropdown(dropdown));
});
