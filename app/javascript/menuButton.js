import { createApp } from 'vue'
import MenuButton from './menuButton.vue';

document.addEventListener("DOMContentLoaded", () => {
    const selector = "#menu-button"
    const menuButton = document.querySelector(selector);
    if (menuButton) {
      const userId = JSON.parse(menuButton.getAttribute("user-id"));
      const app = createApp(MenuButton, { userId: userId})
      app.mount(selector);
    }
});
