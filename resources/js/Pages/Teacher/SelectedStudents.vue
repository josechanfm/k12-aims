<template>
    <AdminLayout title="學生名單" :breadcrumb="breadcrumb">
        <!--  -->
            <div class="flex flex-wrap font-bold text-sm gap-1">
                <div class=" capsule-outline ">
                    <div class="capsule-label ">學年</div>
                    <div class=" "> 
                       {{ klass.grade.year.title }}    
                    </div>
                </div>
                <div class="capsule-outline">
                    <div class="capsule-label ">班別</div>
                    <div class=" ">{{ klass.tag  }}</div>
                </div>
                <div class="flex-1"></div>
            </div>
        <!--  -->

        <a-table :dataSource="students" :columns="columns"  :pagination='false' size="small">
            <template #bodyCell="{column, text, record, index}">
                <template v-if="column.dataIndex == 'action'">
                    <a-button :href="route('teacher.student.profile',record.id)" class="ant-btn" target="_blank">學生檔案</a-button>
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
    props: ['klass','students'],
    data() {
        return {
            breadcrumb:[
                {label:"主控台", url:route('director.dashboard')},
                {label:"年級班別", url:route('director.grades.index',{'type':'secondary'})},
                {label:'學生名單' ,url:null}
            ],
            columns:[
                {
                title: '頭像',
                    dataIndex: 'avatar',
                },{
                    title: '姓名(中文)',
                    dataIndex: 'name_c',
                },{
                    title: '姓名(外文)',
                    dataIndex: 'name_p',
                },{
                    title: '性別',
                    dataIndex: 'sex',
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