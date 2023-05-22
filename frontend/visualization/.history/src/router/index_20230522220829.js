import { createRouter, createWebHashHistory } from 'vue-router'

const routes = [
  {
    path: '/homepage',
    name: 'homepage',
    component: () => import('../views/HomePage.vue')
  },
  {
    path:"/",
    redirect:"/homepage"
  },
  {
    path: '/homepage2',
    name: 'homepage2',
    component: () => import('../views/HomePage2.vue')
  },
]

const router = createRouter({
  history: createWebHashHistory(process.env.BASE_URL),
  routes
})

export default router
