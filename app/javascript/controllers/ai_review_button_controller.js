import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
    static targets = ["commentInput"];
    
    analyse(){
        console.log("analyse start")
        const userComment = this.commentInputTarget.value;
        console.log("User Comment:", userComment);

        fetch('/comments/analyse', {
            method: "POST",
            headers: {
                "Content-Type": "application/json", //specify JSON format
                "X-CSRF-token": document.querySelector('meta[name="csrf-token"]').content // Add CSRF token for Rails authenticity
            },
            body: JSON.stringify({comment: userComment}) // Send comment data
        })
          .then(response => {
            if (!response.ok) {
                throw new Error(`HTTP error! Status: ${response.status}`);
            }
            return response.json(); // Parse JSON response
          })
          .then(data => {
            console.log("Analysis Result:",data.analysis);
            console.log("Analysis Result:",data);

            const content = data.analysis 

            const selectDiv = document.querySelector(".ai");

            selectDiv.innerHTML = '';

            const aiAnswer = document.createElement("div");
            aiAnswer.textContent = content; 
            aiAnswer.classList.add("ai-answer");

            selectDiv.appendChild(aiAnswer);
          })
          .catch(error => {
            console.error("Error:", error);
          });


    }
}