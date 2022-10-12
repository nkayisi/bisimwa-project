import { createStore } from 'vuex'

export default createStore({
  state: {

    associations: [],

    equipeSecours: [],

    loggedUser: null,
    logged_object: null,

    alertes: [],

    parkings: [],

    motards: [],

    courses: [],

  },
  getters: {
    
    associations(state){
      return state.associations
    },

    equipeSecours(state){
      return state.equipeSecours
    },

    alertes(state){
      return state.alertes
    },

    parkings(state){
      return state.parkings
    },

    courses(state){
      return state.courses
    },

    motards(state) {
      return state.motards
    }

  },
  mutations: {

    // AUTH 
    setLoggedUser(state, payload){
      state.loggedUser = payload
    },

    setLoggedObject(state, payload){
      state.logged_object = payload
    },


    // ASSOCIATION
    setAssociations(state, payload){
      state.associations = payload
    },


    setAssociation(state, payload){
      state.associations.push(payload)
    },

    // EQUIPE DE SECOURS
    setEquipeSecours(state, payload){
      state.equipeSecours = payload
    },

    setEquipeSecour(state, payload){
      state.equipeSecours.push(payload)
    },

    // ALERTE
    setAlertes(state, payload){
      state.alertes = payload
    },


    // PARKING 
    setParkings(state, payload){
      state.parkings = payload
    },


    setParking(state, payload){
      state.parkings.push(payload)
    },

    // COURSE
    setCourses(state, payload){
      state.courses = payload
    },

    setCourse(state, payload){
      state.courses.push(payload)
    },


    // MOTARD
    setMotards(state, payload){
      state.motards = payload
    },

    setMotard(state, payload){
      state.motards.push(payload)
    }


  },
  actions: {

    // ASSOCIATION
    setAssociations({commit}, payload){
      commit('setAssociations',payload)
    },

    // EQUIPE DE SECOURS
    setEquipeSecours({commit}, payload){
      commit('setEquipeSecours',payload)
    },

    // ALERTES
    setAlertes({commit}, payload){
      commit('setAlertes',payload)
    },

    // PARKING 
    setParkings({commit}, payload){
      commit('setParkings', payload)
    },

    // COURSES
    setCourses({commit}, payload){
      commit('setCourses', payload)
    },


    // MOTARD
    setMotards({commit}, payload){
      commit('setMotards', payload)
    }

  },
  modules: {
  }
})
