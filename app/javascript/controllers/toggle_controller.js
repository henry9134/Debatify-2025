import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["replies", "upvoteIcon"];

  toggleReplies(event) {
    console.log(event.target, event.currentTarget);
    console.log(this.upvoteIconTarget);
    if (event.target !== this.upvoteIconTarget) {
      this.repliesTarget.classList.toggle("reply-expand");
    }

  }


}
