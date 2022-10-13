<template>
  <div class="min-h-screen flex items-center justify-center py-12 px-4 sm:px-6 lg:px-8">
    <div class="max-w-md w-full space-y-8 bg-cyan-50 shadow-lg px-5 py-20 rounded-xl">
      <div>

        <h2 class="text-center text-3xl tracking-tight font-bold text-gray-900">Connecxion</h2>
        
      </div>
      <form class="mt-8 space-y-6" @submit.prevent="login">
        
        <div class="rounded-md shadow-sm -space-y-px py-8">
          <div>
            <label for="username" class="sr-only">Username</label>
            <input v-model="username" id="username" name="username" type="username" autocomplete="username" required class="appearance-none rounded-none relative block w-full px-3 py-2 border border-gray-300 placeholder-gray-500 text-gray-900 rounded-t-md focus:outline-none focus:ring-cyan-500 focus:border-cyan-500 focus:z-10 sm:text-sm" placeholder="Username" />
          </div>
          <div>
            <label for="password" class="sr-only">Password</label>
            <input v-model="password" id="password" name="password" type="password" autocomplete="current-password" required class="appearance-none rounded-none relative block w-full px-3 py-2 border border-gray-300 placeholder-gray-500 text-gray-900 rounded-b-md focus:outline-none focus:ring-cyan-500 focus:border-cyan-500 focus:z-10 sm:text-sm" placeholder="Password" />
          </div>
        </div>


        <div>
          <button type="submit" class="group relative w-full flex justify-center py-2 px-4 border border-transparent text-sm font-medium rounded-md text-white bg-cyan-600 hover:bg-cyan-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-cyan-500">
            <span class="absolute left-0 inset-y-0 flex items-center pl-3">
              <LockClosedIcon class="h-5 w-5 text-cyan-500 group-hover:text-cyan-400" aria-hidden="true" />
            </span>
            Se connecter
          </button>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
import api from '@/utilitaires/api'
import { LockClosedIcon } from '@heroicons/vue/solid'


export default {
  name: 'LoginView',
  components: {LockClosedIcon},
  data(){
    return{
      username: '',
      password: ''
    }
  },
  methods: {
    login(){
      api.login({username: this.username, password: this.password}).then(res => {
        let token = res.data.key
        
        localStorage.setItem('token', token)

        api.get(`/currentUser/?token=${token}`).then(res => {
          let user = res.data[0]
          this.$store.commit('setLoggedUser', user)
          document.location.reload()
        })
        
      }).catch(err => {
            console.log(err.code)
        })
    }
  }
}
</script>