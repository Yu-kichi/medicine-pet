import { createApp } from 'vue'
import ClinicEdit from './clinicEdit.vue';

document.addEventListener("DOMContentLoaded", () => {
    const selector = "#clinic-edit"
    const clinicEdit = document.querySelector(selector);
    if (clinicEdit) {
      const petId = JSON.parse(clinicEdit.getAttribute("pet-id"));
      const currentUserId = JSON.parse(clinicEdit.getAttribute("currentuser-id"));
      const clinicId = JSON.parse(clinicEdit.getAttribute("clinic-id"));
      const app = createApp(ClinicEdit, {petId: petId, currentUserId: currentUserId, clinicId: clinicId })
      app.mount(selector);
    }
});
