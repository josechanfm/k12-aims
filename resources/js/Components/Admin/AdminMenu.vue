<template>
    <div id="main_menu">
      <a-menu
        v-model:openKeys="openKeys"
        v-model:selectedKeys="selectedKeys"
        mode="inline"
        theme="dark"
        :inline-collapsed="collapsed"
      >

        <template v-for="item in list" :key="item.key">
          <template v-if="!item.children">
            <a-menu-item :key="item.key">
              <template #icon>
                <PieChartOutlined />
              </template>
              {{ item.title }}
            </a-menu-item>
          </template>
          <template v-else>
            <sub-menu :key="item.key" :menu-info="item" />
          </template>
        </template>
        <a-menu-item>
          <a @click.prevent='logout'>Logout</a>
        </a-menu-item>
      </a-menu>
    </div>
  </template>
  <script>
  import { defineComponent, ref } from 'vue';
  import { MenuFoldOutlined, MenuUnfoldOutlined, PieChartOutlined, MailOutlined } from '@ant-design/icons-vue'; // you can rewrite it to a single file component, if not, you should config vue alias to vue/dist/vue.esm-bundler.js
  import { Link } from '@inertiajs/inertia-vue3';
  import { Inertia } from '@inertiajs/inertia';

  const SubMenu = {
    name: 'SubMenu',
    props: {
      menuInfo: {
        type: Object,
        default: () => ({}),
      },
    },
    template: `
      <a-sub-menu :key="menuInfo.key">
        <template #icon><MailOutlined /></template>
        <template #title>{{ menuInfo.title }}</template>
        <template v-for="item in menuInfo.children" :key="item.key">
          <template v-if="!item.children">
            <a-menu-item :key="item.key">
              <template #icon>
                <PieChartOutlined />
              </template>
                <Link :href="item.url">
                  {{ item.title }}
                </Link>
            </a-menu-item>
          </template>
          <template v-else>
            <sub-menu :menu-info="item" :key="item.key" />
          </template>
        </template>
      </a-sub-menu>
    `,
    components: {
      PieChartOutlined,
      MailOutlined,
      Link
    },
  };
  const list = [{
    key: '0',
    title: '????????????',
    children: [{
      key: '0.1',
      title: '??????????????????',
      url:'/master/subjectTemplate',
    },{
      key: '0.2',
      title: '????????????',
      url:'/master/studies',
    },{
      key: '0.3',
      title: '???????????????',
      url:'/master/transcriptTemplate',
    },{
      key: '0.4',
      title: '????????????',
      url:'/master/configs',
    },{
      key: '0.5',
      title: '???????????????',
      url:'/master/roles',
    }],
  },{
    key: '1',
    title: '????????????',
    children: [{
      key: '1.2',
      title: '??????',
      url:'/admin/years',
    },{
      key: '1.3',
      title: '??????',
      url:'/admin/grades',
    },{
      key: '1.4',
      title: '??????',
      url:'/admin/klasses',
    }],
  },{
    key: '2',
    title: '????????????',
    children: [{
      key: '2.1',
      title: '????????????',
      url:'/manage/grades',
    },{
      key: '2.2',
      title: '??????',
      url:'/manage/teacher',
    },{
      key: '2.3',
      title: '???????????????',
      url:'/promote',
    }],
  },{
    key: '3',
    title: '??????',
    children: [{
      key: '3.1',
      title: '??????',
      url:'/teacher',
    }],
  },{
    key: '4',
    title: 'Navigation 4',
    children: [{
      key: '4.1',
      title: 'Navigation 4',
      children: [{
        key: '4.1.1',
        title: 'Option 4.1.1',
      }],
    }],
  }];
  export default defineComponent({
    components: {
      'sub-menu': SubMenu,
      MenuFoldOutlined,
      MenuUnfoldOutlined,
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
        selectedKeys: ref(['']),
        openKeys: ref(['']),
      };
    },
  
  });
  </script>