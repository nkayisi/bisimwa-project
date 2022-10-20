<template>
    <div>
        <div class="md:w-80">
            <button aria-current="true" type="button" class="w-80 py-2 px-6 mb-8 text-cyan-700 bg-slate-100 rounded-lg border-gray-200 cursor-pointer focus:outline-none dark:bg-gray-800 dark:border-gray-600">
                Maps
            </button>
            <div class="text-sm font-medium text-gray-900 bg-white rounded-lg border border-gray-200 dark:bg-gray-700 dark:border-gray-600 dark:text-white">
                <button aria-current="true" class="py-3 uppercase px-4 w-full font-medium text-left text-white bg-cyan-700 rounded-t-lg border-b border-gray-200 cursor-default focus:outline-none dark:bg-gray-800 dark:border-gray-600">
                    Liste des alertes
                </button>
                <button v-for="alerte in alertes" :key="alerte.id" type="button" class="py-2 px-4 w-full font-medium text-left border-b border-gray-200 cursor-pointer hover:bg-gray-100 hover:text-blue-700 dark:border-gray-600 dark:hover:bg-gray-600 dark:hover:text-white dark:focus:ring-gray-500 dark:focus:text-white">
                    {{alerte.date}}
                </button>
            </div>
        </div>
        <div class="md:w-96">
            <div id="myMap"></div>
        </div>
    </div>
</template>

<script>
import api from '@/utilitaires/api';
import GoogleMapsLoader from 'google-maps'

export default {

    data(){
        return {
            alertes: []
        }
    },

    created(){
        api.get('alerte/').then(res => {
            this.alertes = res.data
        })
    },
    mounted: function() {
        console.log("map: ", google.maps)
            this.map = new google.maps.Map(document.getElementById('myMap'), {
            center: {lat:61.180059, lng: -149.822075},
            scrollwheel: false,
            zoom: 4
            })
  }

}


</script>

<style scoped>
    #myMap {
    height:300px;
    width: 100%;
   }
</style>