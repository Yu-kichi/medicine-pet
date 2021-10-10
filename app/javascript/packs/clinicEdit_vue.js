import { createApp } from 'vue'
import App from '../clinicEdit.vue';

document.addEventListener("DOMContentLoaded", () => {
    const node = document.getElementById("app");
    const currentUserId = JSON.parse(node.getAttribute("currentuser-id"));
    const clinicId = JSON.parse(node.getAttribute("clinic-id"));
    const app = createApp(App, {currentUserId: currentUserId, clinicId: clinicId })
    app.mount("#app");
});