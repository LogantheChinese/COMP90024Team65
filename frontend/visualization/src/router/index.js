import { createRouter, createWebHistory } from 'vue-router'

const routes = [
  {
    path: '/homepage',
    name: 'homepage',
    component: () => import('../views/HomePage.vue')
  },
  {
    path:"/",
    redirect:"/homepage"
  }
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

export default router
