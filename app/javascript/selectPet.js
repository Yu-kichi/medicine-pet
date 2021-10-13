import { createApp } from 'vue'
import SelectPet from './selectPet.vue';

document.addEventListener("DOMContentLoaded", () => {
    const selector = "#select-pet"
    const selectPet = document.querySelector(selector);
    if (selectPet) {
      const app = createApp(SelectPet)
      app.mount("#select-pet");
    }
});
