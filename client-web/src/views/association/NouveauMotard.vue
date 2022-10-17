<template>
    <div>
        <form @submit.prevent="ajouterMotard">
            <h1 class="border-b pb-1 text-cyan-900 mb-4 text-xs font-semibold">Info compte</h1>
            <div class="flex justify-between space-x-4 mb-6">
                <fieldset>
                    <label for="" class="uppercase block text-xs font-semibold text-slate-400">nom d'utilisateur</label>
                    <input v-model="username" type="text" class="px-3 border rounded-md h-10 w-64" required>
                </fieldset>
                <fieldset>
                    <label for="" class="uppercase block text-xs font-semibold text-slate-400">mot de passe</label>
                    <input v-model="password1" type="password" class="px-3 border rounded-md h-10 w-64" required>
                </fieldset>
                <fieldset>
                    <label for="" class="uppercase block text-xs font-semibold text-slate-400">confirmation</label>
                    <input v-model="password2" type="password" class="px-3 border rounded-md h-10 w-64" required>
                </fieldset>
            </div>
            <div>
                <h1 class="border-b pb-1 text-cyan-900 mb-4 text-xs font-semibold">Infos générales</h1>
                <div class="flex justify-between">
                    <fieldset>
                        <label for="" class="uppercase block text-xs font-semibold text-slate-400">nom</label>
                        <input v-model="nom" type="text" class="px-3 border rounded-md h-10 w-64" required>
                    </fieldset>
                    <fieldset>
                        <label for="" class="uppercase block text-xs font-semibold text-slate-400">Post-nom</label>
                        <input v-model="post_nom" type="text" class="px-3 border rounded-md h-10 w-64" required>
                    </fieldset>
                    <fieldset>
                        <label for="" class="uppercase block text-xs font-semibold text-slate-400">Prenom</label>
                        <input v-model="prenom" type="text" class="px-3 border rounded-md h-10 w-64" required>
                    </fieldset>
                </div>
                <div class="flex justify-between mt-6">
                    <fieldset>
                        <label for="" class="uppercase block text-xs font-semibold text-slate-400">date de
                            naissance</label>
                        <input v-model="date_naissance" type="date" class="px-3 border rounded-md h-10 w-64">
                    </fieldset>
                    <fieldset>
                        <label for="" class="uppercase block text-xs font-semibold text-slate-400">Etat civil</label>
                        <select v-model="etat_civil"
                            class="px-3 border rounded-md h-10 w-64 cursor-pointer" required>
                            <option value="">----------</option>
                            <option value="Celibataire">Celibataire</option>
                            <option value="Marié">Marié</option>
                            <option value="Veuf">Veuf</option>
                        </select>
                    </fieldset>
                    <fieldset>
                        <label for="" class="uppercase block text-xs font-semibold text-slate-400">Numéro
                            national</label>
                        <input v-model="numero_national" type="text" class="px-3 border rounded-md h-10 w-64" required>
                    </fieldset>
                </div>
                <div class="flex justify-between mt-6">
                    <fieldset>
                        <label for="" class="uppercase block text-xs font-semibold text-slate-400">Genre</label>
                        <select v-model="genre" class="px-3 border rounded-md h-10 w-64 cursor-pointer"
                            required>
                            <option value="">----------</option>
                            <option value="Femme">Femme</option>
                            <option value="Homme">Homme</option>
                        </select>
                    </fieldset>
                    <fieldset>
                        <label for="" class="uppercase block text-xs font-semibold text-slate-400">Adresse</label>
                        <input v-model="adresse" type="text" class="px-3 border rounded-md h-10 w-64">
                    </fieldset>
                    <fieldset>
                        <label for="" class="uppercase block text-xs font-semibold text-slate-400">Téléphone</label>
                        <input v-model="phone" type="text" class="px-3 border rounded-md h-10 w-64">
                    </fieldset>
                </div>
                <div class="flex justify-between mt-6">
                    <fieldset>
                        <label for="" class="uppercase block text-xs font-semibold text-slate-400">Profession</label>
                        <input v-model="profession" type="text" class="px-3 border rounded-md h-10 w-64">
                    </fieldset>
                    <fieldset>
                        <label for="" class="uppercase block text-xs font-semibold text-slate-400">Parking</label>
                        <select v-model="parking" class="px-3 border rounded-md h-10 w-64 cursor-pointer"
                            required>
                            <option value="">----------</option>
                            <option v-for="parking in parkings" :key="parking.id" :value="parking.id">{{parking.nom}}
                            </option>
                        </select>
                    </fieldset>
                    <fieldset>
                        <label for="" class="uppercase block text-xs font-semibold text-slate-400">Photo</label>
                        <input @change="onFileChange" type="file" class="px-3 border rounded-md h-10 w-64">
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
import { mapGetters } from 'vuex'

import api from '@/utilitaires/api'


export default {
    name: 'NouveauMotard',
    data() {
        return {
            username: '',
            password1: '',
            password2: '',
            nom: '',
            post_nom: '',
            prenom: '',
            date_naissance: '',
            etat_civil: '',
            numero_national: '',
            genre: '',
            adresse: '',
            phone: '',
            profession: '',
            parking: '',
            photo: null,

            users: [],
        }
    },
    methods: {

        clearFields() {
            this.username = '',
                this.password1 = '',
                this.password2 = '',
                this.nom = '',
                this.post_nom = '',
                this.prenom = '',
                this.date_naissance = '',
                this.etat_civil = '',
                this.numero_national = '',
                this.genre = '',
                this.adresse = '',
                this.phone = '',
                this.profession = '',
                this.parking = '',
                this.photo = null
        },

        onFileChange(e) {
            this.photo = e.target.files[0];
        },

        ajouterMotard() {

            // let parking = this.parkings.find(park => park.id===int(this.prking))

            api.get(`ceni/?numero_national=${this.numero_national}`).then(res => {
                if (res.data.length > 0) {
                    let user = this.users.find(user => user.numero_national === this.numero_national)
                    if (user === undefined) {

                        if (this.password1 === this.password2) {

                            let formData = new FormData()
                            formData.append('username', this.username)
                            formData.append('password', this.password1)
                            formData.append('nom', this.nom)
                            formData.append('post_nom', this.post_nom)
                            formData.append('prenom', this.prenom)
                            formData.append('date_naissance', this.date_naissance)
                            formData.append('etat_civil', this.etat_civil)
                            formData.append('numero_national', this.numero_national)
                            formData.append('photo', this.photo)
                            formData.append('genre', this.genre)
                            formData.append('adresse', this.adresse)
                            formData.append('telephone', this.phone)
                            formData.append('profession', this.profession)
                            formData.append('parking', parseInt(this.parking))

                            api.post('motard/', formData).then(res => {
                                this.$store.commit('setMotard', res.data)
                                this.clearFields()
                            })
                        }

                    } else {
                        alert(`Ce numéro national a déjà un compte dans le système !`)
                    }
                } else {
                    alert(`Ce numéro national n'existe pas dans la base des données de la ceni !`)
                }
            })

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
        },

        ...mapGetters([
            'parkings',
        ])

    },
    created() {
        api.get('/utilisateur/').then(res => {
            this.users = res.data
        })
    }
}

</script>
