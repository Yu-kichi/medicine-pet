import { createApp } from 'vue'
import PrescriptionsNew from './prescriptionsNew.vue';

document.addEventListener("DOMContentLoaded", () => {
    const selector = "#prescriptions-new"
    const prescriptionsNew = document.querySelector(selector);
    if (prescriptionsNew) {
      const petId = JSON.parse(prescriptionsNew.getAttribute("pet-id"));
      const app = createApp(PrescriptionsNew, { petId: petId})
      app.mount(selector);
    }
});
