document.addEventListener("DOMContentLoaded", () => {
    const form = document.getElementById("message-form");
    const input = document.getElementById("message-input");
    const chatBox = document.getElementById("chat-box");

    form.addEventListener("submit", async (e) => {
        e.preventDefault();
        const message = input.value.trim();
        if (!message) return;

        appendMessage(message, "user");
        input.value = "";
        
        // Add a typing indicator for the agent
        appendMessage("...", "agent", true);

        try {
            const response = await fetch("/run_task", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                },
                body: JSON.stringify({ prompt: message }),
            });

            const data = await response.json();
            
            // Remove the typing indicator
            removeTypingIndicator();
            
            appendMessage(data.result, "agent");

        } catch (error) {
            console.error("Error:", error);
            // Remove the typing indicator and show an error
            removeTypingIndicator();
            appendMessage("Sorry, something went wrong.", "agent");
        }
    });

    function appendMessage(text, sender, isTyping = false) {
        const messageDiv = document.createElement("div");
        messageDiv.classList.add("message", `${sender}-message`);
        
        if(isTyping) {
            messageDiv.classList.add("typing-indicator");
        }

        const p = document.createElement("p");
        p.textContent = text;
        messageDiv.appendChild(p);
        chatBox.appendChild(messageDiv);
        chatBox.scrollTop = chatBox.scrollHeight;
    }
    
    function removeTypingIndicator() {
        const typingIndicator = chatBox.querySelector('.typing-indicator');
        if (typingIndicator) {
            chatBox.removeChild(typingIndicator);
        }
    }
}); 