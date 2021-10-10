import { createApp } from 'vue'
import App from '../clinicNew.vue';

document.addEventListener("DOMContentLoaded", () => {
    const node = document.getElementById("app");
    const currentUserId = JSON.parse(node.getAttribute("current-user-id"));
    const petId = JSON.parse(node.getAttribute("pet-id"));
    const prescriptionId = JSON.parse(node.getAttribute("prescription-id"));
    const app = createApp(App, { petId: petId, prescriptionId: prescriptionId, currentUserId: currentUserId})
    app.mount("#app");
});