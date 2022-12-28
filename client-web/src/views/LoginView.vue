<template>
  <section class="bg-white min-h-screen flex items-center justify-center">
    <!-- login container -->
    <div class="bg-gray-100 flex rounded-2xl shadow-xl max-w-3xl">
      <!-- form -->
      <div class="sm:w-1/2 px-16 p-5">
        <h2 class="font-bold text-2xl text-[#002D74] text-center p-5">CONNEXION</h2>
        <!-- <p class="text-sm mt-4  text-[#002D74] text-center mb-1">
                    Feel Secure In Transport
                </p> -->
        <!-- <div class="flex items-center justify-center mb-4">
                    <img src="moto.png" class="h-10" >
                </div> -->

        <form action="" class="flex flex-col gap-4 " @submit.prevent="login">
          <input v-model="username" class="p-2 mt-8 rounded-xl border" type="text" name="username"
            placeholder="Username">
          <div class="relative">
            <input class="p-2 rounded-xl border w-full" type="password" v-model="password" name="password"
              placeholder="Passworld">
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="gray"
              class="bi bi-eye absolute top-1/2 right-0 -translate-y-1/2 right-4" viewBox="0 0 16 16">
              <path
                d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.133 13.133 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.133 13.133 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5c-2.12 0-3.879-1.168-5.168-2.457A13.134 13.134 0 0 1 1.172 8z" />
              <path d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z" />
            </svg>
          </div>
          <button type="submit" class="bg-[#002D74] rounded-xl text-white py-2">Login</button>

        </form>

        <div class="mt-10 grid grid-cols-3 items-center text-gray-500 mt-3">
          <hr class="border-gray-500">
          <p class="text-center text-sm">FEESTRA</p>
          <hr class="border-gray-500">
        </div>
        <p class="mt-5 text-xs border-b py-4 text-center">FEEL SECURE IN TRANSPORT</p>
        <div class="mt-3 text-xs flex justify-between items-center">
          <p class="">Don't have an acount ...</p>
          <button class="py-2 px-5 bg-white border rounded-xl">Register</button>
        </div>

      </div>
      <!-- Image -->
      <div class="sm:block hidden w-1/2 p-5">
        <img class="flex rounded-2xl" src="../assets/motard1.jpg" alt="">

      </div>

    </div>



  </section>

</template>

<script>
import api from '@/utilitaires/api'


export default {
  name: 'LoginView',
  data() {
    return {
      username: '',
      password: ''
    }
  },
  methods: {
    login() {
      api.login({ username: this.username, password: this.password }).then(res => {
        let token = res.data.key

        console.log(res)

        localStorage.setItem('token', token)

        api.get(`/currentUser/?token=${token}`).then(res => {
          let user = res.data[0]
          this.$store.commit('setLoggedUser', user)
          document.location.reload()
        })

      }).catch(err => {
        console.log(err.code)
      })
    },
  },
}

</script>