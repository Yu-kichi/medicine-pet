import { createApp } from 'vue'
import App from '../clinicNew.vue';

document.addEventListener("DOMContentLoaded", () => {
    const node = document.getElementById("app");
    const petId = JSON.parse(node.getAttribute("pet-id"));
    const prescriptionId = JSON.parse(node.getAttribute("prescription-id"));
    const currentUserId = JSON.parse(node.getAttribute("currentuser-id"));
    const app = createApp(App, { petId: petId, prescriptionId: prescriptionId, currentUserId: currentUserId})
    app.mount("#app");
});