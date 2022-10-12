<template>
    <div class="overflow-x-auto relative shadow-md sm:rounded-lg">
    <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
        <thead class="text-gray-700 bg-slate-300 dark:bg-gray-700 dark:text-gray-400">
            <tr>
                <th scope="col" class="py-3 px-6 uppercase">
                    Nom du parking
                </th>
                <th scope="col" class="py-3 px-6">
                    Adresse
                </th>
                <th scope="col" class="py-3 px-6 uppercase">
                    Nom Association
                </th>
                <th scope="col" class="py-3 px-6 text-right">
                    <span @click="isOpen=true" class="bg-green-500 text-white text-xs px-4 cursor-pointer py-2 rounded-full">Ajouter</span>
                </th>
            </tr>
        </thead>
        <tbody>
            <tr v-for="parking in parkings" :key="parking.id" class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-600">
                <th scope="row" class="py-4 px-6 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                    {{parking.nom}}
                </th>
                <td class="py-4 px-6">
                    {{parking.adresse}}
                </td>
                <td class="py-4 px-6">
                    {{parking.association.nom}}
                </td>
                <td class="py-4 px-6 text-right">
                    <div class="flex justify-around items-center">
                        <button class="bg-yellow-200 items-center flex space-x-2 text-yellow-700 p-2 rounded-full">
                            <PencilIcon class="h-5 w-5"/>
                        </button>
                        <button class="bg-red-200 items-center flex space-x-2 text-red-700 py-2 px-3 rounded-full">
                            <span>X</span>
                        </button>
                        </div>
                </td>
            </tr>
        </tbody>
    </table>
</div>

    <ModalDialog :openDialog="isOpen">

        <template #title>
            <h1 class="border-b pb-4">Ajouter Un Parking</h1>
        </template>

        <template #content>
            <form @submit.prevent="ajouterParking">

                <h1 class="text-xs text-slate-600 border-b mt-10">Infos du parking</h1>

                <div class="my-4">
                    <input v-model="nom" type="text" class="w-full h-10 px-4 border rounded-md bg-scale-200" required placeholder="Nom du Parking">
                </div>

                <div class="my-4">
                    <input v-model="adresse" type="text" class="w-full h-10 px-4 border rounded-md bg-scale-200" required placeholder="Adresse">
                </div>

                <div class="flex justify-between mt-10">
                    <button type="button" @click="isOpen=false"
                        class="inline-flex justify-center rounded-md border border-transparent bg-red-100 px-4 py-2 text-sm font-medium text-red-900 hover:bg-red-200 focus:outline-none focus-visible:ring-2 focus-visible:ring-red-500 focus-visible:ring-offset-2">
                        Annuler
                    </button>
                    <button type="submit"
                        class="inline-flex justify-center rounded-md border border-transparent bg-green-100 px-4 py-2 text-sm font-medium text-green-900 hover:bg-green-200 focus:outline-none focus-visible:ring-2 focus-visible:ring-green-500 focus-visible:ring-offset-2">
                        Enregistrer
                    </button>
                </div>

            </form>
        </template>

    </ModalDialog>

</template>


<script>
import ModalDialog from "@/components/ModalDialog.vue";
import { PencilIcon } from '@heroicons/vue/solid';
import { mapGetters } from 'vuex';

import api from '@/utilitaires/api'


export default {
    name: 'ParkingView',
    components: {ModalDialog, PencilIcon},
    data(){
        return{
            isOpen: false,
            username: '',
            password1: '',
            password2: '',
            nom: '',
            adresse: ''
        }
    },
    methods: {

        clearFields(){
            this.nom = '',
            this.adresse = ''
        },

        ajouterParking(){

            let formData = new FormData()
            formData.append('nom', this.nom)
            formData.append('adresse', this.adresse)
            formData.append('association', this.$store.state.loggedUser.id)

            api.post('parking/', formData).then(res => {
                this.$store.commit('setParking', res.data)
                this.clearFields()
                this.isOpen = false
            })

        }
    },
    computed: {
        ...mapGetters([
        'parkings',
        'motards',
        'courses'
        ])
    },
}

</script>



