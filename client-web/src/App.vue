<template>
  <div class="bg-slate-50">
    
    <!-- <div v-if="is_loading"> -->
      <router-view/>
    <!-- </div>

    <div v-else>
      <p>Loading...</p>
    </div> -->

  </div>
</template>

<style src="./assets/tailwind.css" />


<script>
import api from '@/utilitaires/api'

export default {
  name: 'App',
  data(){
    return {
      is_loading: false,
    }
  },
  async mounted(){

    let token = localStorage.getItem('token')


    if (token!==null) {
      
      await api.get(`/currentUser/?token=${token}`).then(res => {
  
        let user = res.data[0]
        this.$store.commit('setLoggedUser', user)
  
        if(user.is_staff){
          this.$router.push('/super-admin')
        }else if (user.is_association){
          
          api.get(`/association/${user.id}/`).then(res => {
            this.$store.commit('setLoggedObject', res.data)
            this.$router.push('/admin-association')
          })
          
        }else if (user.equipe_secours){
          
          api.get(`/equipeSecours/${user.id}/`).then(res => {
            this.$store.commit('setLoggedObject', res.data)
            this.$router.push('/equipe_secours')
          })
  
        }else {
          this.$router.push({name: 'login'})
        }
  
        this.is_loading = true
  
      }).catch(err => {
        console.log(`Error : ${err.code}`)
      })
    }


  }
}

</script>

