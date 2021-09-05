import { createApp } from 'vue'
import App from '../menuButton.vue';

document.addEventListener("DOMContentLoaded", () => {
    const node = document.getElementById("menu-button");
    const userId = JSON.parse(node.getAttribute("user-id"));
    const app = createApp(App, { userId: userId})
    app.mount("#menu-button");
});
