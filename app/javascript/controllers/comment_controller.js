import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["statusField", "postButton", "sideButton"];

  connect() {
    console.log("Stimulus controller connected!");
    this.disablePostButton();
  }

  selectSide(event) {
    // Remove active class from all buttons
    this.sideButtonTargets.forEach(button => button.classList.remove("active"));

    // Highlight the selected button
    event.target.classList.add("active");

    // Update the hidden status field value
    this.statusFieldTarget.value = event.target.dataset.side;

    // Enable the Post Comment button
    this.enablePostButton();
  }

  enablePostButton() {
    console.log("Enabling post button");
    this.postButtonTarget.disabled = false;
  }

  disablePostButton() {
    console.log("Disabling post button");
    this.postButtonTarget.disabled = true;
  }

  resetModal() {
    console.log("Resetting modal");
    // Reset side button selection
    this.sideButtonTargets.forEach(button => button.classList.remove("active"));

    // Clear hidden field value
    this.statusFieldTarget.value = "";

    // Disable the Post Comment button
    this.disablePostButton();
  }
}
