import { createApp } from 'vue'
import PrescriptionsMedicinesEdit from './prescriptionsMedicinesEdit.vue';

document.addEventListener("DOMContentLoaded", () => {
    const selector = "#prescriptions-medicines-edit"
    const prescriptionsMedicinesEdit = document.querySelector(selector);
    if (prescriptionsMedicinesEdit) {
      const petId = JSON.parse(prescriptionsMedicinesEdit.getAttribute("pet-id"));
      const prescriptionId = JSON.parse(prescriptionsMedicinesEdit.getAttribute("prescription-id"));
      const prescriptionsMedicineId = JSON.parse(prescriptionsMedicinesEdit.getAttribute("prescriptions-medicine-id"));
      const app = createApp(PrescriptionsMedicinesEdit, { petId: petId, prescriptionId: prescriptionId, prescriptionsMedicineId: prescriptionsMedicineId})
      app.mount("#prescriptions-medicines-edit");
    }
});
