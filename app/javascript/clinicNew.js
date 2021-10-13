import { createApp } from 'vue'
import ClinicNew from './clinicNew.vue';

document.addEventListener("DOMContentLoaded", () => {
    const selector = "#clinic-new"
    const clinicNew = document.querySelector(selector);
    if (clinicNew) {
      const petId = JSON.parse(clinicNew.getAttribute("pet-id"));
      const currentUserId = JSON.parse(clinicNew.getAttribute("currentuser-id"));
      const prescriptionId = JSON.parse(clinicNew.getAttribute("prescription-id"));
      const app = createApp(ClinicNew, {petId: petId, currentUserId: currentUserId, prescriptionId: prescriptionId })
      app.mount("#clinic-new");
    }
});
