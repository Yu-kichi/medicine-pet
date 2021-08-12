import { createApp } from 'vue'
import App from '../medicineNotebook.vue';

document.addEventListener("DOMContentLoaded", () => {
    const node = document.getElementById("app");
    const petId = JSON.parse(node.getAttribute("pet-id"));
    const app = createApp(App, { petId: petId})
    app.mount("#app");
});