import { createApp } from 'vue'
import App from '../selectPet.vue';

document.addEventListener("DOMContentLoaded", () => {
    const node = document.getElementById("select-pet");
    const app = createApp(App)
    app.mount("#select-pet");
});
