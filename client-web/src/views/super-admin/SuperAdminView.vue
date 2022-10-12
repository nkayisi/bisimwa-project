<template>

  <div class="h-screen overflow-auto">

    <div v-if="is_loading">
        <navigationPrincipale :navigations="navigations" />

        <div class="px-10 pt-6">
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

import api from '@/utilitaires/api'


const navigations = [
    {
        path: '/super-admin',
        name: 'accueil',
        label: 'Accueil'
    },
    {
        path: '/association',
        name: 'association',
        label: 'Associations'
    },
    {
        path: '/equipe-secours',
        name: 'equipe-secours',
        label: 'Equipes de Secours'
    },
    {
        path: '/alerte',
        name: 'alerte',
        label: 'Alertes'
    }
]

export default {
    name: 'SuperAdminView',
    components: {
        navigationPrincipale
    },
    data() {
        return {
            navigations,
            is_loading: false,
        }
    },
    async mounted() {

        await api.get('association/').then(res => {
            this.$store.dispatch('setAssociations', res.data)

            api.get('equipeSecours/').then(res => {
                this.$store.dispatch('setEquipeSecours', res.data)

                api.get('alerte/').then(res => {
                    this.$store.dispatch('setAlertes', res.data)

                    api.get('parking/').then(res => {
                        this.$store.dispatch('setParkings', res.data)
                        api.get('motard/').then(res => {
                            this.$store.dispatch('setMotards', res.data)
                            this.is_loading = true
                        })
                    })
                })
            })

        }).catch(err => {
            this.err_code = err.code
            console.log(err.code)
        })

    }
}

</script>


<style>
nav a.router-link-exact-active {
  color: #42b983;
}
</style>