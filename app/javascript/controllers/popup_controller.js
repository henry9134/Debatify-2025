import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static targets = ["modal"];

    connect() {
        console.log("Popup controller connected");
        this.isVisible = false; // Tracks visibility state
    }

    toggle(event) {
        // Get the button's position
        const button = event.target;
        const buttonRect = button.getBoundingClientRect();

        // Position the popover near the button
        this.modalTarget.style.top = `${buttonRect.top + window.scrollY}px`;
        this.modalTarget.style.left = `${buttonRect.right + 10}px`;

        // Toggle visibility
        if (this.isVisible) {
            this.close();
        } else {
            this.open();
        }
    }

    open() {
        this.modalTarget.style.display = "block";
        this.isVisible = true;
    }

    close() {
        this.modalTarget.style.display = "none";
        this.isVisible = false;
    }
}