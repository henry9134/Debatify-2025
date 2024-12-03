import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["replies", "upvoteIcon", "secondReplies", "hidden"];

  toggleReplies(event) {
    console.log(event.target, event.currentTarget);
    console.log(this.upvoteIconTarget);
    if (event.target !== this.upvoteIconTarget) {
      this.repliesTarget.classList.toggle("reply-expand");
    }

  }

  toggleSecondReplies(event) {
    console.log(event.target, event.currentTarget);
    // this.secondRepliesTarget.classList.toggle("reply-expand");
    const parent = event.currentTarget.parentElement.parentElement.parentElement.parentElement;
    console.log(parent);
    parent.querySelector(".add-comment-bar").classList.toggle("reply-expand");
    this.toggleHidden();
  }

  toggleHidden() {
    console.log("hi");
    this.hiddenTarget.classList.toggle("replies");
  }





}
