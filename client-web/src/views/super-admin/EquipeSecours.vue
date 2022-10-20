<template>
    <main>
    <div class="overflow-x-auto relative shadow-md sm:rounded-lg">
        <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
            <thead class="text-gray-700 bg-slate-300 dark:bg-gray-700 dark:text-gray-400">
                <tr>
                    <th scope="col" class="py-3 px-6 uppercase">
                        Nom de l'Equipe de secours
                    </th>
                    <th scope="col" class="py-3 px-6">
                        Position
                    </th>
                    <th scope="col" class="py-3 px-6 uppercase">
                        Nombre de membres
                    </th>
                    <th scope="col" class="py-3 px-6 text-right">
                        <span @click="isOpen=true" class="bg-green-500 text-white text-xs px-4 cursor-pointer py-2 rounded-full">Ajouter</span>
                    </th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="equipe in equipeSecours" :key="equipe.user" class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-600">
                    <th scope="row" class="py-4 px-6 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                        {{equipe.nom}}
                    </th>
                    <td class="py-4 px-6">
                        {{equipe.position}}
                    </td>
                    <td class="py-4 px-6">
                        {{equipe.nombre_member}}
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
            <h1 class="border-b pb-4">Ajouter Une Equipe de Secours</h1>
        </template>

        <template #content>
            <form @submit.prevent="ajouterEquipe">

                <div>

                    <h1 class="text-xs text-slate-600 border-b mt-6">Infos du compte</h1>

                    <div class="my-4">
                        <input v-model="username" type="text" class="w-full h-10 px-4 border rounded-md bg-scale-200" required placeholder="Nom d'utilisation">
                    </div>

                    <div class="flex space-x-4">
                        <div>
                            <input v-model="password1" type="password" class="w-full h-10 px-4 border rounded-md bg-scale-200" required placeholder="Mot de passe">
                        </div>

                        <div>
                            <input v-model="password2" type="password" class="w-full h-10 px-4 border rounded-md bg-scale-200" required placeholder="Confirmation">
                        </div>
                    </div>

                </div>

                <h1 class="text-xs text-slate-600 border-b mt-10">Infos générales</h1>

                <div class="my-4">
                    <input v-model="nom" type="text" class="w-full h-10 px-4 border rounded-md bg-scale-200" required placeholder="Nom">
                </div>

                <div class="my-4">
                    <input v-model="position" type="text" class="w-full h-10 px-4 border rounded-md bg-scale-200" required placeholder="Position">
                </div>

                <div class="my-4">
                    <input v-model="nbre_membres" type="text" class="w-full h-10 px-4 border rounded-md bg-scale-200" required placeholder="Nbre. membres">
                </div>

                <div class="flex justify-between mt-8">
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
</main>
</template>


<script>
import ModalDialog from '@/components/ModalDialog.vue';
import { mapGetters } from 'vuex'
import { PencilIcon } from '@heroicons/vue/solid';

import api from '@/utilitaires/api'

export default {
    name: 'EquipeSecours',
    components: {ModalDialog, PencilIcon},
    data(){
        return {
            isOpen: false,
            username: '',
            password1: '',
            password2: '',
            nom: '',
            position: '',
            nbre_membres: ''
        }
    },
    methods: {

        clearFields(){
            this.username = '',
            this.password1 = '',
            this.password2 = '',
            this.nom = '',
            this.position = '',
            this.nbre_membres = ''
        },

        ajouterEquipe(){

            if(this.password1===this.password2) {

                let formData = new FormData()
                formData.append('username', this.username)
                formData.append('password', this.password1)
                formData.append('nom', this.nom)
                formData.append('position', this.position)
                formData.append('nombre_member', this.nbre_membres)

                api.post('equipeSecours/', formData).then(res => {
                    this.$store.commit('setEquipeSecour', res.data)
                    this.clearFields()
                    this.isOpen = false
                })

            }
        }

    },
    computed: {
        // mix the getters into computed with object spread operator
        ...mapGetters([
        'equipeSecours',
        ])
    },
}

</script>



