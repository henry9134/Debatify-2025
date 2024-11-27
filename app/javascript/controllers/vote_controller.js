import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="vote"
export default class extends Controller {
  static targets = ["voteCount", "upvoteIcon", "form", "button"];

  handleVote(event) {
    event.preventDefault();
    const commentId = this.data.get("id");
    const voted = this.upvoteIconTarget.classList.contains("voted");

    fetch(this.formTarget.action, {
      method: "POST",
      headers: { "Accept": "application/json" },
      body: new FormData(this.formTarget)
    })
    .then(response => response.json())
    .then((data) => {
      console.log(data)
      if (!voted) {
        this.upvoteIconTarget.setAttribute('data-voted', 'true');

        let currentVotes = parseInt(this.voteCountTarget.innerText);
        this.voteCountTarget.innerText = data.voteCount;
        this.buttonTarget.innerHTML = data.button;
      } else {
        this.upvoteIconTarget.setAttribute('data-voted', 'false');

        let currentVotes = parseInt(this.voteCountTarget.innerText);
        this.voteCountTarget.innerText = data.voteCount;
        this.buttonTarget.innerHTML = data.button;
      }
    })
  }
}
