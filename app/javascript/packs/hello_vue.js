import Vue from 'vue/dist/vue.esm'
import App from '../app.vue'
import Exam from './components/exam.vue'
import BootstrapVue from 'bootstrap-vue'
Vue.use(BootstrapVue);

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#hello',
    data: {
      
    },
    components: {App, Exam}
  })
})
