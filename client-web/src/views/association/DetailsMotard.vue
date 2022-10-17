<template>
    <main>
    <h1 class="border-b pb-1 mb-5 text-xs text-cyan-900">Profil</h1>
    <div class="flex item-center space-x-3 mb-5 text-gray-400">
        <div class="text-center">
            <img :src="motard.photo" alt="" class="h-28 w-28 mx-auto rounded-full border">
            
        </div>
        <div class="justify-between">
            <div>
                <h1 class="font-semibold">Nom: {{motard.nom}}</h1>
            </div>
            <div>
                <h1 class="font-semibold">Post-nom: {{motard.post_nom}}</h1>
            </div>
            <div>
                <h1 class="font-semibold">Prénom: {{motard.prenom}}</h1>
            </div>
            <div>
                <h1>Username: {{motard.user.username}}</h1>
            </div>
        </div>
    </div>
    <h1 class="border-b pb-1 mb-5 text-xs text-cyan-900">Détails</h1>
    <div class="mb-5 text-gray-400 flex justify-around">
        <h1>Genre: <span class="bg-slate-200 text-slate-600 rounded-full px-3 py-2">{{motard.genre}}</span></h1>
        <h1>Date de naissance: <span class="bg-cyan-200 text-cyan-600 rounded-full px-3 py-2">{{motard.date_naissance}}</span></h1>
        <h1>Etat civil: <span class="bg-green-200 text-green-600 rounded-full px-3 py-2">{{motard.etat_civil}}</span></h1>
        <h1>Profession: <span class="bg-yellow-200 text-yellow-600 rounded-full px-3 py-2">{{motard.profession}}</span></h1>
    </div>

    <h1 class="border-b pb-1 mb-2 text-xs text-cyan-900">Adresse et contact</h1>
    <div class="mb-5 text-gray-400">
        <h1>Adresse: {{motard.adresse}}</h1>
        <h1>Téléphone: {{motard.telephone}}</h1>
        <h1>Numéro National: {{motard.numero_national}}</h1>
    </div>

    <h1 class="border-b pb-1 mb-2 text-xs text-cyan-900">Info association</h1>
    <div class="mb-5 text-gray-400">
        <h1>Matricule du motard: {{motard.matricule}}</h1>
        <h1>Parking: {{motard.parking.nom}}</h1>
        <h1>Association: {{motard.parking.association.nom}}</h1>
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
    </main>
</template>



<script>
import { PencilIcon } from '@heroicons/vue/solid';
import { mapGetters } from 'vuex';

export default {
    name: 'DetailsMotard',
    props: ['motard'],
    components: {PencilIcon},
    data() {
        return {
        }
    },
    mounted(){
    },
    computed: {
        ...mapGetters([
        'motards',
        ])
    },
}

</script>