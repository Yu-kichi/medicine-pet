import { createApp } from 'vue'
import App from '../header.vue';

document.addEventListener("DOMContentLoaded", () => {
    const node = document.getElementById("head");
    const petId = JSON.parse(node.getAttribute("pet-id"));
    const app = createApp(App, { petId: petId})
    app.mount("#head");
});
