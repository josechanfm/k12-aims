import './bootstrap';
import '../css/app.css';

import { createApp, h, hydrate } from 'vue';
import { createInertiaApp, Head, Link } from '@inertiajs/vue3';
import { resolvePageComponent } from 'laravel-vite-plugin/inertia-helpers';
import { ZiggyVue } from '../../vendor/tightenco/ziggy/dist/vue.m';
import  RolePermission  from './Directives/RolePermission.js';
import  LangMapper  from './Directives/lang.js';

import Antd from 'ant-design-vue';
//import 'ant-design-vue/dist/antd.css';
import 'ant-design-vue/dist/reset.css';
import '/resources/css/app.css';
// import '../../node_modules/tabulator-tables/dist/css/tabulator.css';

const appName = window.document.getElementsByTagName('title')[0]?.innerText || 'Laravel';

createInertiaApp({
    title: (title) => `${title} - ${appName}`,
    resolve: (name) => resolvePageComponent(`./Pages/${name}.vue`, import.meta.glob('./Pages/**/*.vue')),
    setup({ el, App, props, plugin }) {
        return createApp({ render: () => h(App, props) })
            .use(plugin)
            .use(ZiggyVue, Ziggy)
            .use(Antd)
            .use(RolePermission).use(LangMapper)
            // .component('inertia-head',Head)
            // .component('inertia-link',Link)
            .mount(el);
    },
});

