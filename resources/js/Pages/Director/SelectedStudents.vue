<template>
    <AdminLayout title="學生名單" :breadcrumb="breadcrumb">
        <a-table :dataSource="students" :columns="columns">
            <template #bodyCell="{column, text, record, index}">
                <template v-if="column.dataIndex == 'action'">
                    <a-button :href="route('director.students.show',record.id)" class="ant-btn" target="_blank">學生檔案</a-button>
                </template>
                <template v-else-if="column.dataIndex=='avatar'">
                    <a-image v-if="record.avatar" width="100px" :src="record.avatar.preview_url"/>
                </template>
                <template v-else>
                    {{record[column.dataIndex]}}
                </template>
            </template>
        </a-table>
    </AdminLayout>
</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';

export default {
    components: {
        AdminLayout,
    },
    props: ['students'],
    data() {
        return {
            breadcrumb:[
                {label:"主控台", url:route('director.dashboard')},
                {label:"年級班別", url:route('director.grades.index',{'type':'secondary'})},
                {label:'學生名單' ,url:null}
            ],
            columns:[
            {
                    title: '姓名(中文)',
                    dataIndex: 'name_zh',
                },{
                    title: '姓名(外文)',
                    dataIndex: 'name_fn',
                },{
                    title: '性別',
                    dataIndex: 'gender',
                },{
                    title: '有效',
                    dataIndex: 'active',
                },{
                    title: '選科',
                    dataIndex: 'subject',
                },{
                    title: 'Avatar',
                    dataIndex: 'avatar',
                },{
                    title:'操作',
                    dataIndex: 'action'
                }
            ],

        }
    },
    created(){

    },
    methods: {
    },
}
</script>