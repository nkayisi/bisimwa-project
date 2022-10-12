<template>
    <div>
        <!-- <p v-if="err_code==='ERR_NETWORK'" class="p-3 mb-5 bg-red-100 -mt-10 text-red-700 text-center">
            La connexion à la source de données a échouée ! Verifier votre connectivité.
        </p> -->
        <div class="md:flex">
            <div class="md:w-2/6 space-y-8 mr-10">
                <div class="h-40 w-full bg-white p-2 rounded-lg shadow-lg text-cyan-900">
                    <h1 class="border-b pb-1">Associations</h1>
                    <h1 class="text-5xl text-center py-5">
                        {{associations.length}}
                    </h1>
                </div>
                <div class="h-40 w-full bg-white p-2 rounded-lg shadow-lg text-yellow-700">
                    <h1 class="border-b pb-1">Equipes de Secours</h1>
                    <h1 class="text-5xl text-center py-5">
                        {{equipeSecours.length}}
                    </h1>
                </div>
                <div class="h-40 w-full bg-white p-2 rounded-lg shadow-lg text-red-700">
                    <h1 class="border-b pb-1">Alertes</h1>
                    <h1 class="text-5xl text-center py-5">
                        {{alertes.length}}
                    </h1>
                </div>
            </div>
            <div class="md:w-4/6">

            </div>
        </div>

    </div>
</template>


<script>

import { mapGetters } from 'vuex'


export default {
    name: 'AdminAccueil',
    data() {
        return {
            err_code: ''
        }
    },
    computed: {
        ...mapGetters([
        'associations',
        'equipeSecours',
        'alertes',
        ])
    }
}


</script>
