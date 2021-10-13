import { createApp } from 'vue'
import PrescriptionsMedicinesNew from './prescriptionsMedicinesNew.vue';

document.addEventListener("DOMContentLoaded", () => {
    const selector = "#prescriptions-medicines-new"
    const prescriptionsMedicinesNew = document.querySelector(selector);
    if (prescriptionsMedicinesNew) {
      const petId = JSON.parse(prescriptionsMedicinesNew.getAttribute("pet-id"));
      const prescriptionId = JSON.parse(prescriptionsMedicinesNew.getAttribute("prescription-id"));
      const app = createApp(PrescriptionsMedicinesNew, { petId: petId, prescriptionId: prescriptionId})
      app.mount("#prescriptions-medicines-new");
    }
});
