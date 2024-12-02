import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["level"]; // Register the level element

  update(event) {
    const newPercentage = event.detail.percentage; // Receive the new percentage
    if (this.levelTarget) {
      this.levelTarget.style.height = `${newPercentage}%`; // Update the height dynamically
    }
  }
}
