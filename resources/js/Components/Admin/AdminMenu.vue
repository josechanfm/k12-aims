<template>
    <div id="main_menu">
        <a-menu v-model:openKeys="openKeys" v-model:selectedKeys="selectedKeys" mode="inline" theme="light"
            :inline-collapsed="collapsed">
            <template v-for="item in list" :key="item.key">
                <div v-role="item.roles">
                    <a-sub-menu :key="item.key">
                        <template #icon>
                            <AppstoreOutlined />
                        </template>
                        <template #title>{{ item.title }}</template>
                        <template v-for="subitem in item.children" :key="subitem.key">
                            <a-menu-item v-if="!subitem.children" :key="subitem.key">
                                <template #icon>
                                    <TagOutlined />
                                </template>
                                <a-button type="text" :href="subitem.url">{{ subitem.title }}</a-button>
                            </a-menu-item>
                            <a-sub-menu v-else :key="subitem.key">
                                <template #icon>
                                    <AppstoreOutlined />
                                </template>
                                <template #title>{{ item.title }}</template>

                                <a-menu-item v-for="ssubitem in subitem.children" :key="ssubitem.key">
                                    <template #icon>
                                        <TagOutlined />
                                    </template>
                                    <a-button type="text" :href="ssubitem.url">{{ ssubitem.title }}</a-button>
                                </a-menu-item>

                            </a-sub-menu>
                        </template>
                    </a-sub-menu>
                </div>
            </template>
            <a-menu-item>
                <template #icon>
                    <LoginOutlined />
                </template>
                <a class="w-full text-start" @click='logout'>登出</a>
            </a-menu-item>
        </a-menu>

    </div>
</template>

<script>
import {
    defineComponent,
    ref
} from 'vue';
import {
    AppstoreOutlined,
    TagOutlined,
    MenuFoldOutlined,
    MenuUnfoldOutlined,
    PieChartOutlined,
    LoginOutlined,
    MailOutlined
} from '@ant-design/icons-vue'; // you can rewrite it to a single file component, if not, you should config vue alias to vue/dist/vue.esm-bundler.js


import { router } from '@inertiajs/vue3';
const logout = () => {
    if (confirm('Sure to logout?')) {
        router.post(route('logout'));
    }
};

const list = [{
    key: 'master',
    roles: ['master'],
    title: '系統維護管理',
    children: [{
        key: 'subjects',
        title: '全校學科總表',
        url: '/master/subjects',
        route: 'master.subjects'
            }, {
                key: 'studies',
                title: '學習計劃',
                url: '/master/studies',
            }, {
                key: 'theme_templates',
                title: '基力設置',
                url: '/master/theme_templates',
            }, {
                key: 'transcriptTemplate',
                title: '成績表欄位',
                url: '/master/transcriptTemplate',
            }, {
                key: 'configs',
                title: '系統參數',
                url: '/master/configs',
            }, {
                key: 'roles',
                title: '角色及權限',
                url: '/master/roles',
            },{
                key: 'users',
                title: '用戶權限分配',
                url: '/master/users',
            },{
                key: 'manuals',
                title: '用戶指南',
                url: '/master/manuals',
            }, {
                key: 'issues',
                title: '問題日志',
                url: '/master/issues',
            }
    ],
}, {
    key: 'admin',
    roles: ['master', 'admin'],
    title: '行政管理',
    children: [{
        key: 'years',
        title: '學年',
        url: '/admin/years',
    }, {
        key: 'year',
        title: '年級',
        url: '/admin/grades',
    }, {
        key: 'grade',
        title: '班別',
        url: '/admin/klasses',
    }, {
        key: 'students',
        title: '學生',
        url: '/admin/students',
    }, {
        key: 'student',
        title: '新生',
        url: '/admin/candidates',
    },
 {
        key: 'student',
        title: '分班',
        url: '/admin/klassStudentEnrolls',
    },

],
}, {
    key: 'director',
    roles: ['master', 'admin', 'director'],
    title: '教務管理',
    children: [{
        key: 'grades',
        title: '年級班別',
        url: '/director/grades',
        urlParamKey: 'gradeScope',
        children: [{
            key: 'kindergarten',
            title: '幼稚園部',
            url: '/director/grades?gradeScope=kindergarten'
        }, {
            key: 'primary',
            title: '小學部',
            url: '/director/grades?gradeScope=primary'
        }, {
            key: 'secondary',
            title: '中學部',
            url: '/director/grades?gradeScope=secondary'
        }]
    }, {
        key: 'teachers',
        title: '教師',
        url: '/director/teachers',
    }, {
        key: 'promotes',
        title: '升留班預處理',
        url: '/director/promotes',
    }],
}, {
    key: 'subjects',
    roles: ['master', 'admin', 'director'],
    title: '科目管理',
    children: [{
        key: 'subjects',
        title: '學分管理',
        url: '/director/score_columns/details',
        // urlParamKey: 'gradeScope',
    }],
}, {
    key: 'teacher',
    roles: ['teacher'],
    title: '教師',
    children: [{
        key: 'teacher',
        title: '任教',
        url: '/teacher',
    }],
}, {
    key: 'medical',
    roles: ['master', 'admin', 'director'],
    title: '保健醫療',
    children: [{
        key: '4.1',
        title: '總覽統計',
        url: '/medical',
    }, {
        key: '4.2',
        title: '就診記錄',
        url: '/medical/treatments',
    }, {
        key: '4.3',
        title: '體檢保建',
        url: '/medical/healthcares',
    }],
}, {
    key: '5',
    roles: ['master', 'admin', 'director'],
    title: '社工輔導',
    children: [{
        key: '4.1',
        title: '社工輔導',
        children: [{
            key: '4.1.1',
            title: 'Option 4.1.1',
        }],
    }],
}];

export default defineComponent({
    components: {
        AppstoreOutlined,
        MenuFoldOutlined,
        TagOutlined,
        MenuUnfoldOutlined,
        LoginOutlined,
        PieChartOutlined,
    },

    setup() {
        const collapsed = ref(false);

        const toggleCollapsed = () => {
            collapsed.value = !collapsed.value;
        };

        return {
            list,
            collapsed,
            toggleCollapsed,
            selectedKeys: ref([]),
            openKeys: ref([]),
            logout
        };
    },
    mounted() {
        window.app = this
        const regex = /\/([^/?]+)/g;
        const matches = this.$page.url.match(regex);
        const result = matches.map(match => match.replace('/', ''));
        this.selectedKeys.push(result[1] ?? '')
        this.openKeys.push(result[0] ?? '')
        if (result.length === 1) { // URL只有1個字詞時 
            let findParents = this.list.filter(menu => menu.children.filter(children => children.key == result[0]).length > 0)
            this.selectedKeys = [(result[0] ?? '')]
            this.openKeys = [findParents[0]?.key ?? '']
        }
        //URL有URL params作為menu區分且合共三層時情況 
        let findMenuObj = this.list.find(x => x.key == (result[0] ?? ''))
        if (findMenuObj) {
            let SubMenu = findMenuObj.children.find(x => x.key == (result[1] ?? ''))
            if ((SubMenu?.urlParamKey ?? undefined) !== undefined) {
                let searchParams = new URLSearchParams(window.location.search);
                this.selectedKeys = [searchParams.get(SubMenu.urlParamKey)]
                this.openKeys = result
            }
        }
    },
    methods: {
        logout() {
            router.post(route('logout'))
        }
    }
});
</script>

<style>


</style>
