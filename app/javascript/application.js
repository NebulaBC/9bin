// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("DOMContentLoaded", function() {
    async function submitForm(event) {
        event.preventDefault();
        const response = await fetch('/documents', {
            method: 'POST',
            headers: { 'Content-Type': 'text/plain' },
            body: document.getElementById('editor').value
        });

        if (response.ok) {
            const result = await response.json();
            if (result.key) {
                window.location.href = result.key;
            }
        }
    }

    document.addEventListener("keydown", function(event) {
        if (event.ctrlKey && event.key === "s") {
            event.preventDefault();
            submitForm(event);
        }
        if (event.ctrlKey && event.key === "n") {
            event.preventDefault();
            window.location.replace("/");
        }
        if (event.keyCode === 9) {
            event.preventDefault();
            document.execCommand("insertText", false, "\t");
        }
    });

    document.getElementById("new").addEventListener("click", function() {
        window.location.replace("/");
    });

    document.getElementById("submit").addEventListener("click", submitForm);
});
