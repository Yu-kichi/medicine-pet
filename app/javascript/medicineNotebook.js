import { createApp } from 'vue'
import MedicineNotebook from './medicineNotebook.vue';

document.addEventListener("DOMContentLoaded", () => {
    const selector = "#medicine-notebook"
    const medicineNotebook = document.querySelector(selector);
    if (medicineNotebook) {
      const petId = JSON.parse(medicineNotebook.getAttribute("pet-id"));
      const app = createApp(MedicineNotebook, { petId: petId})
      app.mount(selector);
    }
});
