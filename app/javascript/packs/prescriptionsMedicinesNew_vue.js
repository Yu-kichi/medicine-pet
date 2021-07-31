import { createApp } from 'vue'
import App from '../prescriptionsMedicinesNew.vue';

document.addEventListener("DOMContentLoaded", () => {
    const node = document.getElementById("app");
    const petId = JSON.parse(node.getAttribute("pet-id"));
    const prescriptionId = JSON.parse(node.getAttribute("prescription-id"));
    const app = createApp(App, { petId: petId, prescriptionId: prescriptionId})
    app.mount("#app");
});