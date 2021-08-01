import { createApp } from 'vue'
import App from '../prescriptionsMedicinesEdit.vue';

document.addEventListener("DOMContentLoaded", () => {
    const node = document.getElementById("app");
    const petId = JSON.parse(node.getAttribute("pet-id"));
    const prescriptionId = JSON.parse(node.getAttribute("prescription-id"));
    const prescriptionsMedicineId = JSON.parse(node.getAttribute("prescriptions-medicine-id"));
    const app = createApp(App, { petId: petId, prescriptionId: prescriptionId, prescriptionsMedicineId: prescriptionsMedicineId})
    app.mount("#app");
});