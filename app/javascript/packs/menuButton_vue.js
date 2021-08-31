import { createApp } from 'vue'
import App from '../menuButton.vue';

document.addEventListener("DOMContentLoaded", () => {
    const node = document.getElementById("menu-button");
    const app = createApp(App)
    app.mount("#menu-button");
});
