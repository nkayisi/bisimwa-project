<template>
    <div class="md:flex md:space-x-10">

        <div class="md:w-80">
            <button @click="GoAjouterMotard" type="buttom" aria-current="true" class="w-80 py-2 px-6 mb-8 text-center text-white bg-green-400 rounded-lg border-gray-200 cursor-pointer focus:outline-none dark:bg-gray-800 dark:border-gray-600">
                Ajouter motard
            </button>
            <div class="text-sm font-medium text-gray-900 bg-white rounded-lg border border-gray-200 dark:bg-gray-700 dark:border-gray-600 dark:text-white" style="height: 480px;">
                <button aria-current="true" class="py-3 uppercase px-4 w-full font-medium text-left text-white bg-cyan-700 rounded-t-lg border-b border-gray-200 cursor-default focus:outline-none dark:bg-gray-800 dark:border-gray-600">
                    Liste des motards
                </button>
                <div class="p-2">
                    <input type="text" class="w-full h-8 border rounded-full px-2 placeholder-slate-200" placeholder="Rechercher motard">
                </div>
                <button v-for="motard in motards" :key="motard.id" @click="GoDetailsMotard(motard)" type="button" 
                :class="[motard_actif_id== motard.user.id ? 'bg-gray-100 text-green-700' :'','py-2 flex justify-between items-center px-4 w-full font-medium text-left border-b border-gray-200 cursor-pointer hover:bg-gray-100 hover:text-green-700 dark:border-gray-600 dark:hover:bg-gray-600 dark:hover:text-white dark:focus:ring-gray-500 dark:focus:text-white']">
                    <div>
                        <span class="block font-semibold text-lg">{{motard.nom}} {{motard.post_nom}} {{motard.prenom}}</span>
                        <span class="block text-gray-400">Matricule: {{motard.matricule}}</span>
                    </div>
                    <ChevronRightIcon class="h-8 w-8"/>
                </button>
            </div>
        </div>

        <div class="md:w-4/5">
            <NouveauMotard v-if="is_motardRecord"/>
            <DetailsMotard v-if="is_motardActif" :motard="motardActif"/>
        </div>

    </div>
</template>

<script>
import { ChevronRightIcon } from '@heroicons/vue/solid'
import { mapGetters } from 'vuex'
import DetailsMotard from './DetailsMotard.vue'
import NouveauMotard from './NouveauMotard.vue'

export default {
    name: 'MotardView',
    components: {ChevronRightIcon, DetailsMotard, NouveauMotard},
    data (){
        return {
            motard_actif_id: null,
            motardActif: null,
            is_motardActif: false,
            is_motardRecord: true
        }
    },
    methods: {
        GoAjouterMotard(){
            this.motard_actif_id = null
            this.is_motardActif = false
            this.is_motardRecord = true
            this.$router.push({name: 'nouveauMotard'})
        },

        GoDetailsMotard(motard){
            this.motard_actif_id = motard.user.id
            this.motardActif = motard
            this.is_motardRecord = false
            this.is_motardActif = true
        }
    },
    created(){
        this.GoAjouterMotard()
    },
    computed: {
        ...mapGetters([
        'motards',
        'courses'
        ])
    },
}

</script>