<template>
    <div class="md:flex md:space-x-10">

        <div class="md:w-80">
            <button @click="GoAjouterAssociation" type="buttom" aria-current="true" class="w-80 py-2 px-6 mb-8 text-center text-white bg-green-600 rounded-lg border-gray-200 cursor-pointer focus:outline-none">
                Ajouter association
            </button>
            <div class="text-sm font-medium text-gray-900 bg-white rounded-lg border border-gray-200 dark:bg-gray-700 dark:border-gray-600 dark:text-white" style="height: 485px;">
                <button aria-current="true" class="py-3 uppercase px-4 w-full font-medium text-left text-white bg-cyan-700 rounded-t-lg border-b border-gray-200 cursor-default focus:outline-none dark:bg-gray-800 dark:border-gray-600">
                    Liste des associations
                </button>
                <div class="p-2">
                    <input type="text" class="w-full h-8 border rounded-full px-2 placeholder-slate-200" placeholder="Recherche">
                </div>
                <button v-for="association in associations" :key="association.user" @click="GoDetailsAssociation(association)" type="button" 
                :class="[association_active===association ? 'bg-gray-200 text-green-700' : '', 'py-2 text-lg flex justify-between items-center font-semibold px-4 w-full text-left border-b border-gray-200 cursor-pointer hover:bg-gray-200 hover:text-green-700 dark:border-gray-600 dark:hover:bg-gray-600 dark:hover:text-white dark:focus:ring-gray-500 dark:focus:text-white']">
                    <div>
                        {{association.nom}}
                        <span class="text-xs text-slate-400 block">No. impot : {{association.numero_impot}}</span>
                    </div>
                    <ChevronRightIcon class="h-8 w-8"/>
                </button>
            </div>
        </div>

        <div class="md:w-4/5">
            <DetailsAssociation v-if="is_details" :parking_counter="parking_counter" :motard_counter="motard_counter" :association="association_active"/>
            <NouveauAssociation v-else/>
        </div>

    </div>
</template>

<script>
import { ChevronRightIcon } from '@heroicons/vue/solid'
import { mapGetters } from 'vuex'
import DetailsAssociation from './DetailsAssociation.vue'
import NouveauAssociation from './NouveauAssociation.vue'


export default {
    name: 'AssociationView',
    components:{ChevronRightIcon, DetailsAssociation, NouveauAssociation},
    data (){
        return {
            association_active: null,
            is_details: false,
            parking_counter: 0,
            motard_counter: 0
        }
    },
    methods: {
        GoAjouterAssociation(){
            this.association_active = null
            this.is_details = false
        },

        GoDetailsAssociation(payload){

            this.parking_counter = 0
            this.motard_counter = 0

            for (let index = 0; index < this.parkings.length; index++) {
                
                const el = this.parkings[index];
                if (el.association.user.id === payload.user.id) {
                    this.parking_counter += 1
                    
                    for (let index = 0; index < this.motards.length; index++) {
                        const el2 = this.motards[index];
                        if (el2.parking.id === el.id) {
                            
                            this.motard_counter += 1
                            console.log(this.motard_counter)
                        }
                    }
                }
            }

            this.association_active = payload
            this.is_details = true
        }
    },
    created(){
        this.$router.push({name: 'enregistrementAssociation'})
    },
    computed: {
        ...mapGetters([
        'associations',
        'parkings',
        'motards'
        ])
    },
}

</script>