<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                年級學習計劃之學科
            </h2>
        </template>
        <div>Title: {{ study.title_zh }}</div>
        <div>Stream: {{ study.stream }}</div>
        <div>Version: {{ study.version }}</div>
        <div>Description: {{ study.description }}</div>
            <button @click="saveSelected"
                class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded my-3">保存更新</button>
            <a-table :dataSource="subjects" :columns="columns">
                <template #bodyCell="{column, text, record, index}">
                    <template v-if="column.dataIndex=='selected'">
                        <a-checkbox v-model:checked="record.selected" />
                    </template>
                    <template v-else-if="column.dataIndex=='subject_heads'">
                        <a-select v-model:value="record.subject_head_ids" placeholder="請選擇..." 
                            style="width:200px" :options="teachers" mode="multiple"
                            :field-names="{ label: 'name_zh', value: 'id' }" 
                            :disabled="!record.selected"
                        />
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
import axios from 'axios';
import { defineComponent, reactive } from 'vue';

export default {
    components: {
        AdminLayout,
    },
    props: ['study','subjects','teachers'],
    data() {
        return {
            modal: {
                mode:null,
                isOpen: false,
                title:'Subjects',
                data:{}
            },
            dataSource:[],
            columns:[
                {
                    title: '選科',
                    dataIndex: 'selected',
                },{
                    title: '學科名稱',
                    dataIndex: 'title_zh',
                },{
                    title: '專業方向',
                    dataIndex: 'stream',
                },{
                    title: '科組長',
                    dataIndex: 'subject_heads',
                }
            ],
            rules:{
                code:{
                    required:true,
                },
                title_zh:{
                    required:true,
                },
                title_en:{
                    required:true,
                },
                type:{
                    required:true,
                },
                stream:{
                    required:true,
                },
                eletive:{
                    required:true,
                },
            },
            validateMessages:{
                required: '${label} is required!',
                types: {
                    email: '${label} is not a valid email!',
                    number: '${label} is not a valid number!',
                },
                number: {
                    range: '${label} must be between ${min} and ${max}',
                },
            },
            labelCol: {
                style: {
                width: '150px',
                },
            },
            layout2col: {
                labelCol: {
                    span: 8,
                },
                wrapperCol: {
                    span: 20,
                },
            }

        }
    },
    mounted(){
        // var abc=this.subjects.map(subject=>{
        //     return subject.selected=this.study.subjects.find(ss=>{
        //         return subject.id==ss.id
        //     })!==undefined;
        // } )
        
        this.subjects.forEach(subject=>{
            // subject.selected=this.study.subjects.find(s=>{
            //     return subject.id==s.id
            // })!==undefined;
            subject.selected=false
            //subject.subject_head_ids=[]
            this.study.subjects.forEach(s=>{
                if(subject.id===s.id){
                    subject.selected=true
                    subject.subject_head_ids=JSON.parse(s.pivot.subject_head_ids)
                }
            })
        })
        console.log(this.subjects);
    },
    methods: {
        saveSelected(){
            const subjects=this.subjects.filter(subject=>{ return subject.selected==true })
            var data={}
            subjects.forEach(s=>{
                if(s.subject_head_ids){
                    data[s.id]={subject_head_ids:JSON.stringify(s.subject_head_ids)}
                }else{
                    data[s.id]={subject_head_ids:'[]'}
                }
                
            })
            console.log(data)
            this.$inertia.put(route('master.studySubjects.update',this.study.id),data,{
                onSuccess:(page)=>{
                    console.log(page);
                    this.modal.isOpen=false;
                },
                onError:(error)=>{
                    console.log(error);
                }
            });
        }
    },
}
</script>