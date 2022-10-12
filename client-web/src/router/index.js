import { createRouter, createWebHistory } from 'vue-router'

const routes = [
  {
    path: '/',
    name: 'login',
    component: () => import('../views/LoginView.vue')
  },
  {
    path: '/super-admin',
    name: 'superAdmin',
    component: () => import('../views/super-admin/SuperAdminView.vue'),
    children: [
      {
        path: '',
        name: 'accueilSuperAdmin',
        component: () => import('../views/super-admin/AdminAccueil.vue')
      },
      {
        path: '/association',
        name: 'association',
        component: () => import('../views/super-admin/AssociationView.vue'),
        children: [
          {
            path: '',
            name: 'enregistrementAssociation',
            component: () => import('../views/super-admin/NouveauAssociation.vue')
          },
          {
            path: '/association/:id',
            name: 'detailsAssociation',
            // props: true,
            component: () => import('../views/super-admin/DetailsAssociation.vue')
          },
        ]
      },
      {
        path: '/equipe-secours',
        name: 'equipe-secours',
        component: () => import('../views/super-admin/EquipeSecours.vue')
      },
      {
        path: '/alerte',
        name: 'alerte',
        component: () => import('../views/super-admin/AlerteView.vue')
      }
    ]
  },
  {
    path: '/admin-association',
    name: 'adminAssociation',
    component: () => import('../views/association/AdminAssociation.vue'),
    children: [
      {
        path: '',
        name: 'accueilAssociation',
        component: () => import('../views/association/AccueilAssociation.vue')
      },
      {
        path: '/parking',
        name: 'parking',
        component: () => import('../views/association/ParkingView.vue')
      },
      {
        path: '/motard',
        name: 'motard',
        component: () => import('../views/association/MotardView.vue'),
        children: [
          {
            path: '',
            name: 'nouveauMotard',
            component: () => import('../views/association/NouveauMotard.vue')
          },
          {
            path: '/details-motard/:id',
            // props: true,
            name: 'detailsMotard',
            component: () => import('../views/association/DetailsMotard.vue')
          }
        ]
      },
      {
        path: '/course',
        name: 'course',
        component: () => import('../views/association/CourseView.vue')
      },
    ]
  },
  {
    path: '/equipe_secours',
    name: 'equipeSecoursView',
    component: () => import('../views/equipe-secours/EquipeSecoursView.vue'),
    children: [
      {
        path: '',
        name: 'intervention',
        component: () => import('../views/equipe-secours/InterventionView.vue')
      },
      {
        path: '/equipe_secours/historique',
        name: 'historique',
        component: () => import('../views/equipe-secours/HistoriqueView.vue')
      },
      {
        path: '/equipe_secours/rapport',
        name: 'rapport',
        component: () => import('../views/equipe-secours/RapportView.vue')
      }
    ]
  }
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

export default router
