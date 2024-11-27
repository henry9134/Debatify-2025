const searchInput = document.getElementById('search-bar');
searchInput.addEventListener('keyup', (e) => {
    const query = e.target.value;
    console.log(`User is typing: ${query}`); 

    // Send the query to the server using fetch
    fetch(`/topics?query=${encodeURIComponent(query)}`, {
        headers: { 'Accept': 'text/plain' } // This tells Rails to send the `format.text` response
    })
      .then(response => response.text())
      .then(html => {
        console.log(html)
        // replace the results on the page
        const resultsContainer = document.getElementById('results-container');
        resultsContainer.innerHTML = html;
      });
});