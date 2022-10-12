<template>
    <div class="md:flex mt-4">
        <div class="md:w-2/6 space-y-10 mr-10">
            <div class="h-36 w-full bg-white p-2 rounded-lg shadow-lg text-cyan-900">
                <h1 class="border-b pb-1">Parkings</h1>
                <h1 class="text-5xl text-center py-5">
                    {{parkings.length}}
                </h1>
            </div>
            <div class="h-36 w-full bg-white p-2 rounded-lg shadow-lg text-yellow-700">
                <h1 class="border-b pb-1">Motards</h1>
                <h1 class="text-5xl text-center py-5">
                    {{motards.length}}
                </h1>
            </div>
            <div class="h-36 w-full bg-white p-2 rounded-lg shadow-lg text-red-700">
                <h1 class="border-b pb-1">Courses</h1>
                <h1 class="text-5xl text-center py-5">
                    {{courses.length}}
                </h1>
            </div>
        </div>
        <div class="md:w-4/6">

        </div>
    </div>
</template>

<script>
import { mapGetters } from 'vuex'
// import api from '@/utilitaires/api'

export default {
    name: 'AccueilAssociation',
    data(){
        return {

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