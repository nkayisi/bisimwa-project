<template>

  <div class="h-screen overflow-auto">

    <div v-if="is_loading">
        <navigationPrincipale :navigations="navigations" />

        <div class="p-10">
            <router-view/>
        </div>
    </div>

    <div v-else>
        <p>Loading...</p>
    </div>
    
  </div>

</template>


<script>
import navigationPrincipale from '../../components/navigationPrincipale.vue'

const navigations = [
    {
        path: '/equipe_secours',
        name: 'intervention',
        label: 'Alertes'
    },
    {
        path: '/equipe_secours/historique',
        name: 'historique',
        label: 'Historique d\'intervention'
    },
    {
        path: '/equipe_secours/rapport',
        name: 'rapport',
        label: 'Rapport'
    }  
]

export default {
    name: 'EquipeSecoursView',
    components: {
        navigationPrincipale
    },
    data() {
        return {
            navigations,
            is_loading: false,
        }
    },
    async created(){
        this.$router.push({name: 'intervention'})
        this.is_loading = true
    }
}

</script>


<style>
nav a.router-link-exact-active {
  color: #09d67a;
}
</style>
