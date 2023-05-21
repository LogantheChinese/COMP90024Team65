import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
// flexible plugin
import "lib-flexible/flexible.js"

createApp(App).use(store).use(router).mount('#app')
