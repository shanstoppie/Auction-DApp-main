import { createRouter, createWebHistory } from 'vue-router'
import Sell from '../views/Sell.vue';
import Buy from '../views/Buy.vue';
import Hist from '../views/Hist.vue';
import DashBoard from '../views/DashBoard.vue';

const routes = [
  {
    path: '/',
    name: 'Sell',
    component: Sell
  },
  {
    path: '/buy',
    name: 'Buy',
    component: Buy
  },
  {
    path: '/hist',
    name: 'Hist',
    component: Hist
  },
  {
    path: '/db',
    name: 'DashBoard',
    component: DashBoard
  }
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

export default router
