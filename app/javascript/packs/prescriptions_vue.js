import { createApp } from 'vue'
import App from '../prescriptions.vue';

document.addEventListener("DOMContentLoaded", () => {
    const app = createApp(App);
    app.mount("#app");
});