import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["replies"];

  toggleReplies() {


    this.repliesTarget.classList.toggle("show");
  }


}
