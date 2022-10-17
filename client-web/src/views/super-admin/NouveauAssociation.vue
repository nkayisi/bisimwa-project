<template>
    <div>
        <h1 class="mb-10 uppercase text-ld bg-green-600 text-white font-semibold p-2 text-center">
            formulaire d'ajout d'une association
        </h1>
        <h1 v-if="!passwords_match" class="mb-10 text-ld bg-red-100 text-red-800 font-semibold p-2 text-center">
            Les deux mots de passes ne sont pas identiques !
        </h1>
        <form @submit.prevent="ajouterAssociation">
            <div> 
                <h1 class="border-b pb-1 text-cyan-900 mb-4 text-xs font-semibold">Info compte</h1>
                <div class="md:flex justify-between md:space-x-4 mb-6">
                    <fieldset class="mt-2">
                        <label for="" class="uppercase block text-xs font-semibold text-black">nom d'utilisateur</label>
                        <input v-model="username" type="text" class="border rounded-md h-10 w-64" required>
                    </fieldset>
                    <fieldset class="mt-2">
                        <label for="" class="uppercase block text-xs font-semibold text-black">mot de passe</label>
                        <input v-model="password" type="password" class="border rounded-md h-10 w-64" required>
                    </fieldset>
                    <fieldset class="mt-2">
                        <label for="" class="uppercase block text-xs font-semibold text-black ">confirmation</label>
                        <input v-model="confirm" @keyup="watchPassword" type="password" :class="[passwords_match ? '' : 'focus:ring-red-600 ring-1','border rounded-md h-10 w-64']" required>
                    </fieldset>
                </div>
            </div>
            <div> 
                <h1 class="border-b pb-1 text-cyan-900 mb-4 text-xs font-semibold">Infos générales</h1>
                <div class="md:flex justify-between">
                    <fieldset class="mt-2">
                        <label for="" class="uppercase block text-xs font-semibold text-black">nom association</label>
                        <input v-model="nom" type="text" class="border rounded-md h-10 w-64" required>
                    </fieldset>
                    <fieldset class="mt-2">
                        <label for="" class="uppercase block text-xs font-semibold text-black">adresse</label>
                        <input v-model="adresse" type="text" class="border rounded-md h-10 w-64" required>
                    </fieldset>
                    <fieldset class="mt-2">
                        <label for="" class="uppercase block text-xs font-semibold text-black">numéro impot</label>
                        <input v-model="numero_impot" type="text" class="border rounded-md h-10 w-64" required>
                    </fieldset>
                </div>
                <div class="md:flex justify-between mt-6">
                    <fieldset class="mt-2">
                        <label for="" class="uppercase block text-xs font-semibold text-black">nom président</label>
                        <input v-model="president" type="text" class="border rounded-md h-10 w-64" required>
                    </fieldset>
                    <fieldset class="mt-2">
                        <label for="" class="uppercase block text-xs font-semibold text-black">nom vice-président</label>
                        <input v-model="vice_president" type="text" class="border rounded-md h-10 w-64" required>
                    </fieldset>
                    <fieldset class="mt-2">
                        <label for="" class="uppercase block text-xs font-semibold text-black">date de création</label>
                        <input v-model="date_creation" type="date" class="border rounded-md h-10 w-64" required>
                    </fieldset>
                </div>
            </div>
            <div class="mt-10">
                <button type="submit" class="py-2 px-6 bg-green-600 text-white rounded-lg">Enregistrer</button>
            </div>
        </form>
    </div>
</template>

<script>
import api from '@/utilitaires/api'

export default {
    name: 'NouveauAssociation',
    data(){
        return {
            username:'', password:'', confirm:'', nom:'', president:'', vice_president:'', numero_impot:'',
            date_creation:'', adresse:'',

            passwords_match: true
        }
    },
    methods: {

        ajouterAssociation(){

            if(this.password === this.confirm){
                this.passwords_match = true
                let formData = new FormData()
                formData.append('username', this.username)
                formData.append('password', this.password)
                formData.append('nom', this.nom)
                formData.append('president', this.president)
                formData.append('vice_president', this.vice_president)
                formData.append('numero_impot', this.numero_impot)
                formData.append('date_creation', this.date_creation)
                formData.append('adresse', this.adresse)

                api.post('association/', formData).then(res => {
                    this.$store.commit('setAssociation', res.data)
                    this.clearFields()
                })

            }else{
                this.passwords_match = false
            }

        },

        clearFields(){
            this.username='',
            this.password='',
            this.confirm='',
            this.nom='',
            this.president='',
            this.vice_president='',
            this.numero_impot='',
            this.date_creation='',
            this.adresse=''
        }

    },
    computed: {

        formatDate(date) {
            var d = new Date(date),
                month = '' + (d.getMonth() + 1),
                day = '' + d.getDate(),
                year = d.getFullYear();

            if (month.length < 2) 
                month = '0' + month;
            if (day.length < 2) 
                day = '0' + day;

            return [year, month, day].join('-');
        }

    }
}

</script>
