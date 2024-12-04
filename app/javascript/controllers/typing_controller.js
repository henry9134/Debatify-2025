import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="typing"
export default class extends Controller {
  connect() {
    this.typing(); // Ensure typing is called on connect
  }

  typing() {
    const summaryElement = document.getElementById("ai-summary");
    let text = summaryElement.innerText;
    summaryElement.innerText = ""; // Clear the text initially

    let index = 0;
    const typingSpeed = 25; // Adjust typing speed here

    const type = () => {
      console.log("Typing animation with text:", text); // Debug log
      if (index < text.length) {
        summaryElement.innerText += text.charAt(index);
        index++;
        setTimeout(type, typingSpeed);
      }
    };

    const restartTypingAnimation = (newText) => {
      console.log("Restarting typing animation with new text:", newText); // Debug log
      text = newText; // Update text with new content
      summaryElement.innerText = ""; // Clear the text
      index = 0; // Reset index
      type(); // Start typing again
    };

    // Start the typing animation initially
    type();

    // Listen for Turbo Stream updates to restart animation
    document.addEventListener("turbo:before-stream-render", (event) => {
      if (event.detail.newStream) {
        const newContent = event.detail.newStream.querySelector("#ai-summary").innerText;
        restartTypingAnimation(newContent);
      }
    });
  }
}
