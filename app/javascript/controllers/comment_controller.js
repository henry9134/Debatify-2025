import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["statusField", "postButton", "sideButton"];

  connect() {
    console.log("Comment controller connected!");
    this.disablePostButton();
  }

  selectSide(event) {
    this.sideButtonTargets.forEach(button => button.classList.remove("active"));
    event.target.classList.add("active");
    this.statusFieldTarget.value = event.target.dataset.side;
    this.enablePostButton();
  }

  enablePostButton() {
    this.postButtonTarget.disabled = false;
  }

  disablePostButton() {
    this.postButtonTarget.disabled = true;
  }

  resetModal() {
    this.sideButtonTargets.forEach(button => button.classList.remove("active"));
    this.statusFieldTarget.value = "";
    this.disablePostButton();
  }

}
