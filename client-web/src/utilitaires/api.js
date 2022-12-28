import axios from 'axios'


const Axios = axios.create({
    baseURL: 'http://192.168.0.101:8000/api/'
})


/** 
 * interceper all axios requests to add token
*/
// Axios.interceptors.request.use(request => {
//     // add token in request header if the user is connected
//     let token = localStorage.getItem('token')
//     if (token) {
//         request.headers.Authorization = 'Token '+token
//     }

//     return request
// })



export default {

    // Auth actions
    // =======================================

    login(loginInfo){
        return new Promise((resolve, reject) => {
            
            Axios.post('/auth/login/', loginInfo).then( response => {
                resolve(response)
            }).catch(error => {
                reject(error)
            })
            
        })
    },


    logout(token){
        return new Promise((resolve, reject) => {
            Axios.post('auth/logout/', {key: token}).then(response => {
                localStorage.removeItem('token')
                resolve(response)
            }).catch(error => {
                reject(error)
            })
        })
    },


    getUser(payload){
        return new Promise((resolve, reject) => {
            Axios.get('auth/user/', payload).then(response => {
                resolve(response)
            }).catch(error => {
                reject(error)
            })
        })
    },

    // Getter actions
    // =======================================
    async get (endpoint) {
        return await new Promise((resolve, reject) => {
            Axios.get(endpoint).then(response => {
                resolve(response)
            }).catch(error => {
                reject(error)
            })
        })
    },


    // Post actions
    // ======================

    post(endpoint, payload) {
        return new Promise((resolve, reject) => {
            Axios.post(endpoint, payload).then(response => {
                resolve(response)
            }).catch(error => {
                reject(error)
            })
        })
    },


    // Update actions
    // ======================

    update(endpoint, payload){
        return new Promise((resolve, reject) => {
            Axios.put(endpoint, payload).then(response => {
                resolve(response)
            }).catch(error => {
                reject(error)
            })
        })
    },


    // Delete Actions
    // ===============================
    delete (endpoint, id){
        return new Promise((resolve, reject) => {
            Axios.delete(endpoint+ id+'/').then(response => {
                resolve(response)
            }).catch(error => {
                reject(error)
            })
        })
    }

}