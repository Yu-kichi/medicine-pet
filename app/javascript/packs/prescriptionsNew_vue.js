import { createApp } from 'vue'
import App from '../prescriptionsNew.vue';

document.addEventListener("DOMContentLoaded", () => {
    const node = document.getElementById("app");
    const petId = JSON.parse(node.getAttribute("pet-id"));
    const app = createApp(App, { petId: petId})
    app.mount("#app");
});