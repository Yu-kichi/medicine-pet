import { createApp } from 'vue'
import PrescriptionsEdit from './prescriptionsEdit.vue';

document.addEventListener("DOMContentLoaded", () => {
    const selector = "#prescriptions-edit"
    const clinicEdit = document.querySelector(selector);
    if (clinicEdit) {
      const petId = JSON.parse(clinicEdit.getAttribute("pet-id"));
      const prescriptionId = JSON.parse(clinicEdit.getAttribute("prescription-id"));
      const app = createApp(PrescriptionsEdit, { petId: petId, prescriptionId: prescriptionId})
      app.mount(selector);
    }
});
