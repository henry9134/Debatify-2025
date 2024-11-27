import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="search"
export default class extends Controller {
  static targets = ["input", "results"]

  connect() {
    console.log("Search controller connected.");
  }

  // Triggered on keyup
  search(event) {
    const query = this.inputTarget.value;

    // Send the query to the server using fetch
    fetch(`/topics?query=${encodeURIComponent(query)}`, {
      headers: { 'Accept': 'text/plain' } // This tells Rails to send the `format.text` response
    })
      .then(response => response.text())
      .then(html => {
        this.resultsTarget.innerHTML = html; // Update the results container
      });
  }
}
