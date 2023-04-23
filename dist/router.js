import { createRouter, createWebHistory } from 'vue-router';

const router = createRouter({
    history: createWebHistory(),
    routes: [{
            path: '/',
            component: () =>
                import ('../src/components/Home.vue'),
        },
        {
            path: '/search',
            component: () =>
                import ('../src/components/Search/index.vue'),
        },
        {
            path: '/watch',
            component: () =>
                import ('../src/components/Watch/index.vue'),
        },
        {
            path: '/channel/:id',
            component: () =>
                import ('../src/components/Channel/index.vue'),
        },
        {
            path: '/history',
            component: () =>
                import ('../src/components/History.vue'),
        },
        {
            path: '/settings',
            component: () =>
                import ('../src/components/Settings.vue'),
        },
        {
            path: '/:pathMatch(.*)*',
            component: () =>
                import ('../src/components/PageNotFound.vue'),
        },
        {
            path: '/premium',
            component: () =>
                import ('../src/components/Pay.vue'),
        },
        {
            path: '/success',
            component: () =>
                import ('../src/components/Success.vue'),
        },
    ],
});

export default router;