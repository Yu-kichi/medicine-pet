import { createApp } from 'vue'
import PrescriptionsShow from './prescriptionsShow.vue';

document.addEventListener("DOMContentLoaded", () => {
    const selector = "#prescriptions-show"
    const prescriptionsShow = document.querySelector(selector);
    if (prescriptionsShow) {
      const petId = JSON.parse(prescriptionsShow.getAttribute("pet-id"));
      const prescriptionId = JSON.parse(prescriptionsShow.getAttribute("prescription-id"));
      const app = createApp(PrescriptionsShow, { petId: petId, prescriptionId: prescriptionId})
      app.mount(selector);
    }
});
