<template>

  <div class="h-screen overflow-auto">

    <div v-if="is_loading">
        <navigationPrincipale :navigations="navigations" />

        <div class="px-6 pt-6">
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
        path: '/admin-association',
        name: 'accueilAssociation',
        label: 'Accueil'
    },
    {
        path: '/parking',
        name: 'parking',
        label: 'Parkings'
    },
    {
        path: '/motard',
        name: 'motard',
        label: 'Motards'
    },
    {
        path: '/course',
        name: 'course',
        label: 'Courses'
    }
]

export default {
    name: 'AdminAssociation',
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

        await api.get('parking/?association='+this.$store.state.loggedUser.id).then(res => {
            this.$store.dispatch('setParkings', res.data)
            api.get('motard/').then(res => {
                this.$store.dispatch('setMotards', res.data)
                    api.get('course/').then(res => {
                        this.$store.dispatch('setCourses', res.data)
                        this.is_loading = true
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