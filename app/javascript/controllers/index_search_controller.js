import { Controller } from "@hotwired/stimulus";


export default class extends Controller {
  static targets = ["input", "results"]

  connect() {
    console.log("Index Search controller connected.");
    console.log("Input Target:", this.inputTarget);
  }

  search(event) {
    const query = this.inputTarget.value;

    fetch(`/topics?query=${encodeURIComponent(query)}`, {
      headers: { 'Accept': 'text/plain' }
    })
      .then(response => response.text())
      .then(html => {
        this.resultsTarget.innerHTML = html;
      });
  }
}
