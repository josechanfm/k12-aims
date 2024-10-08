<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                成績表項目列表
            </h2>
        </template>
        <a-button @click="onClickCreate()" size="small" type="info">成績表轉換項目</a-button>
            <a-table :dataSource="transcripts" :columns="columns">
                <template #bodyCell="{column, text, record, index}">
                    <div class="flex gap-1" v-if="column.dataIndex=='operation'">
                        <a-button @click="onClickEdit(record)" type="edit" size="small">編輯</a-button>
                        <a-button @click="onClickDelete(record.id)" type="delete" size="small">刪除</a-button>
                    </div>
                    <template v-else-if="column.dataIndex=='courses'">
                        <ul>
                            <li v-for="klass in record['klasses']">Class: {{klass.acronym}}</li>
                        </ul>
                    </template>
                    <template v-else>
                        {{record[column.dataIndex]}}
                    </template>
                </template>
            </a-table>

        <!-- Modal Start-->
        <a-modal v-model:open="modal.isOpen" :title="modal.title" width="60%" @update="updateRecord()" @onCancel="closeModal()">
            <a-form
                :model="modal.data"
                name="Transcript"
                ref="modalRef"
                :rules="rules"
                :validate-messages="validateMessages"
            >
                <a-form-item label="Category" name="category">
                    <a-input v-model:value="modal.data.category" />
                </a-form-item>
                <a-form-item label="Field Name" name="field_name">
                    <a-input v-model:value="modal.data.field_name" />
                </a-form-item>
                <a-form-item label="Title Zh" name="title_zh">
                    <a-input v-model:value="modal.data.title_zh" />
                </a-form-item>
                <a-form-item label="Title En" name="title_en">
                    <a-input v-model:value="modal.data.title_en" />
                </a-form-item>
                <a-form-item label="備註" name="remark">
                    <a-textarea v-model:value="modal.data.remark" placeholder="textarea with clear icon" allow-clear />
                </a-form-item>
            </a-form>
        <template #footer>
            <a-button key="back" @click="modalCancel">Return</a-button>
            <a-button v-if="modal.mode=='EDIT'" key="Update" type="primary" @click="updateRecord()">Update</a-button>
            <a-button v-if="modal.mode=='CREATE'"  key="Store" type="primary" @click="storeRecord()">Create</a-button>
        </template>
    </a-modal>    
    <!-- Modal End-->
    </AdminLayout>

</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { defineComponent, reactive } from 'vue';

export default {
    components: {
        AdminLayout,
    },
    props: ['transcripts'],
    data() {
        return {
            modal: {
                mode:null,
                isOpen: false,
                title:'Transcripts',
                data:{}
            },
            dataSource:[],
            columns:[
                {
                    title: 'Category',
                    dataIndex: 'category',
                },{
                    title: 'Field Name',
                    dataIndex: 'field_name',
                },{
                    title: 'Title Zh',
                    dataIndex: 'title_zh',
                },{
                    title: 'Operation',
                    dataIndex: 'operation',
                },
            ],
            rules:{
                category:{
                    required:true,
                },
                field_name:{
                    required:true,
                },
                title_zh:{
                    required:true,
                }
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
    methods: {
        onClickCreate(record){
            this.modal.data={};
            this.modal.title="Edit Transcript";
            this.modal.mode='CREATE';
            this.modal.isOpen = true;
        },
        onClickEdit(record){
            this.modal.data={...record};
            this.modal.title="Edit Transcript";
            this.modal.mode='EDIT';
            this.modal.isOpen = true;
        },
        storeRecord(){
            this.$refs.modalRef.validateFields().then(()=>{
                this.$inertia.post('/master/transcriptTemplate/', this.modal.data,{
                    onSuccess:(page)=>{
                        console.log(page);
                        this.modal.isOpen=false;
                    },
                    onError:(err)=>{
                        console.log(err);
                    }
                });
            }).catch(err => {
                console.log(err);
            });
        },
        updateRecord(){
            this.$refs.modalRef.validateFields().then(()=>{
                this.$inertia.put('/master/transcriptTemplate/' + this.modal.data.id, this.modal.data,{
                    onSuccess:(page)=>{
                        console.log(page);
                        this.modal.isOpen=false;
                    },
                    onError:(error)=>{
                        console.log(error);
                    }
                });
            }).catch(err => {
                console.log("error", err);
            });
           
        },
        onClickDelete(recordId){
            if (!confirm('Are you sure want to remove?')) return;
            this.$inertia.delete('/master/transcripts/' + recordId,{
                onSuccess: (page)=>{
                    console.log(page);
                },
                onError: (error)=>{
                    console.log(error);
                }
            });
            this.ChangeModalMode('Close');
        },
        modalCancel(){
            this.modal.data={}
            this.modal.isOpen=false
        },
        onFinishFailed(errorInfo){
            console.log('errorInfo: '+errorInfo);
        }
    },
}
</script>