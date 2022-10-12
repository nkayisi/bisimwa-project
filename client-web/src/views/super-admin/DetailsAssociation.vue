<template>

    <h1 class="border-b pb-1 mb-5 text-xs text-cyan-900">Info de l'association</h1>
    <div class="flex justify-between mb-5">
        <div class="w-80 bg-cyan-100 rounded-lg p-3">
            <h1 class="text-xs border-b">Nombre des parkings</h1>
            <h1 class="text-4xl py-5 text-center">{{parking_counter}}</h1>
        </div>
        <div class="w-80 bg-green-100 rounded-lg p-3">
            <h1 class="text-xs border-b">Nombre des motards</h1>
            <h1 class="text-4xl py-5 text-center">{{motard_counter}}</h1>
        </div>
    </div>

    <h1 class="border-b pb-1 mb-5 text-xs text-cyan-900">Info de l'association</h1>
    <div>
        <h1>Denomination: {{association.nom}}</h1>
        <h1>No. Impot: {{association.numero_impot}}</h1>
        <h1>Date de création: {{association.date_creation}}</h1>
    </div>

    <h1 class="border-b pb-1 mb-5 mt-5 text-xs text-cyan-900">Responsables</h1>
    <div>
        <h1>Président: {{association.president}}</h1>
        <h1>Vicce-Président: {{association.vice_president}}</h1>
    </div>

    <h1 class="border-b pb-1 mb-5 mt-5 text-xs text-cyan-900">Adresse</h1>
    <div>
        <h1>{{association.adresse}}</h1>
    </div>

    <div class="mt-3 flex justify-around items-center">
        <button class="bg-yellow-200 items-center flex space-x-2 text-yellow-700 px-5 py-2 rounded-md">
            <PencilIcon class="h-5 w-5"/>
            <span>Modifier</span>
        </button>
        <button class="bg-red-200 items-center flex space-x-2 text-red-700 px-5 py-2 rounded-md">
            <span>X</span>
            <span>Supprimer</span>
        </button>
    </div>

</template>


<script>
import { PencilIcon } from '@heroicons/vue/solid';
import { mapGetters } from 'vuex';

export default {
    name: 'DetailsAssociation',
    props: ['association', 'parking_counter', 'motard_counter'],
    components: {PencilIcon},
    data() {
        return {
        }
    },
    mounted(){
        
    },
    computed: {
        ...mapGetters([
        'associations',
        'parkings',
        'motards',
        'equipeSecours',
        'alertes',
        ])
    }
}

</script>

