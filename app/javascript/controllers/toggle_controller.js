import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["replies"];
  toggle(event) {
    const replies = this.repliesTarget;
    replies.classList.toggle("hidden");
  }
}
