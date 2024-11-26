const searchInput = document.getElementById('search-bar');
searchInput.addEventListener('keyup', (e) => {
    const query = e.target.value;
    console.log(`User is typing: ${query}`); 

    // Send the query to the server using fetch
    // fetch(`/topics?query=${encodeURIComponent(query)}`)
    //   .then(response => response.text())
    //   .then(html => {
    //     // replace the results on the page
    //     console.log(html)
    //     document.querySelector("body").innerHTML = html
    //   });
});