<template>
    <nav class="h-14 px-10 flex items-center justify-between bg-cyan-800 sticky xs:justify-center top-0 text-white">
        <div class="space-x-10 flex items-center">
            <router-link v-for="item in navigations" :key="item.name" class="py-4" :to="item.path">
                {{ item.label }}
            </router-link>
        </div>
        <div>
            <button @click="logoutUser" class="bg-red-400 text-white text-sm py-2 rounded-full px-3 hover:text-red-800">
                Se Deconnecter
            </button>
        </div>
    </nav>
</template>


<style scoped>

a:hover {
    color: rgb(0, 181, 18);
}

</style>


<script>
import api from '@/utilitaires/api'

export default {
    name: 'navigationPrincipale',
    props: ['navigations'],
    data(){
        return{

        }
    },
    methods: {
        logoutUser(){
            api.logout().then(() => {
                localStorage.removeItem('token')
                this.$router.push({name: 'login'})
            })
        }
    }
}

</script>