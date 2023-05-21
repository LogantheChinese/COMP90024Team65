import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
axios.defaults.baseURL="http://localhost:8082"
// flexible plugin
import "lib-flexible/flexible.js"
import axios from 'axios'

createApp(App).use(store).use(router).mount('#app')
