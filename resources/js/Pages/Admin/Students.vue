<template>
    <AdminLayout title="全校學生列表" :breadcrumb="breadcrumb">
        <div  class="p-2 bg-white rounded-lg flex flex-col gap-1">
        <div class="flex">
            <div class="flex-1 text-red-500">
                <div>List all students</div>
                <div>Might need to add search and filter features</div>
                <div>Add student should not be here. can be remove from this page</div>
            </div>
            <a-button @click="onClickCreate()" size="small" type="create">新增學生</a-button>
        </div>
        <div  class="rounded-lg border-gray-200 border p-2">
            <a-table :dataSource="students.data" :columns="columns" :pagination="pagination" @change="onPaginationChange" ref="dataTable">
                <template #bodyCell="{column, text, record, index}">
                    <div v-if="column.dataIndex=='operation'" class="flex gap-1">
                        <a-button :href="route('director.students.show',record.id)"  target="_blank" size="small" type="info"> 學生檔案</a-button>
                        <a-button @click="onClickEdit(record)" size="small" type="edit">修改</a-button>
                        <a-button @click="onClickDelete(record)"  size="small" type="delete">刪除</a-button>
                    </div>
                    <template v-if="column.dataIndex=='username'">
                        <span v-if="record.user">
                            {{ record.user.username }}
                        </span>
                    </template>
                    <template v-else>
                        {{record[column.dataIndex]}}
                    </template>
                </template>
            </a-table>
        </div>
        <!-- Modal Start-->
        <a-modal v-model:open="modal.isOpen" :title="modal.title" >
            <a-form
                :model="modal.data"
                name="Staff"
                ref="modalRef"
                :rules="rules"
                :validate-messages="validateMessages"
                :label-col="{ span: 4 }"
                :wrapper-col="{ span: 20 }"
            >
                <a-form-item label="中文姓名" name="name_zh">
                    <a-input v-model:value="modal.data.name_c" />
                </a-form-item>
                <a-form-item label="外文姓名" name="name_fn">
                    <a-input v-model:value="modal.data.name_p" />
                </a-form-item>
                <a-form-item label="性別" name="gender">
                    <a-radio-group v-model:value="modal.data.gender" button-style="solid">
                        <a-radio-button value="M">男</a-radio-button>
                        <a-radio-button value="F">女</a-radio-button>
                    </a-radio-group>
                </a-form-item>
                <a-form-item label="聯繋電話" name="mobile">
                    <a-input v-model:value="modal.data.mobile" />
                </a-form-item>
                <a-form-item label="校部" name="sector">
                    <a-input v-model:value="modal.data.sector" />
                </a-form-item>
                <a-form-item label="教師" name="is_teacher">
                    <a-switch v-model:checked="modal.data.is_teacher" :checkedValue="1" :uncheckedValue="0"/>
                </a-form-item>
            </a-form>
            <template #footer>
                <a-button key="back" @click="modalCancel" type="delete">關閉</a-button>
                <a-button v-if="modal.mode=='EDIT'" key="Update" type="edit" @click="updateRecord()">提交並更改</a-button>
                <a-button v-if="modal.mode=='CREATE'"  key="Store" type="create" @click="storeRecord()">提交並新增</a-button>
            </template>

        </a-modal>
        </div>
    </AdminLayout>

</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import ButtonLink from '@/Components/ButtonLink.vue';
import {CheckSquareOutlined, StopOutlined} from '@ant-design/icons-vue';
import { extractIdentifiers } from '@vue/compiler-core';

export default {
    components: {
        AdminLayout,
        ButtonLink,
        CheckSquareOutlined,
        StopOutlined
    },
    props: ['students'],
    data() {
        return {
            breadcrumb:[
                {label:"行政管理" ,url:route('admin.dashboard')},
                {label:"全校學生" ,url:null},
            ],
            modal: {
                mode:null,
                isOpen: false,
                title:'Student',
                data:{}
            },
            pagination:{
                total: this.students.total,
                current:this.students.current_page,
                pageSize:this.students.per_page,
            },
            columns:[
                {
                    title: '姓名(中文)',
                    dataIndex: 'name_c',
                },{
                    title: '姓名(外文)',
                    dataIndex: 'name_p',
                },{
                    title: '性別',
                    dataIndex: 'sex',
                },{
                    title: '教師',
                    dataIndex: 'is_teacher',
                },{
                    title: '操作',
                    dataIndex: 'operation',
                }
            ],
            rules:{
                name_zh:{
                    required:true,
                },
                gender:{
                    required:true,
                },
                mobile:{
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
    created(){
       
    },
    methods: {
        onPaginationChange(page, filters, sorter){
            this.$inertia.get(route('admin.students.index'),{
                page:page.current,
                per_page:page.pageSize,
                //filter:filters,
                //sorter:sorter
            },{
                onSuccess: (page)=>{
                    console.log(page);
                },
                onError: (error)=>{
                    console.log(error);
                }
            });
        },
        onClickCreate(record){
            this.modal.data={};
            this.modal.title="新增職員記錄";
            this.modal.mode='CREATE';
            this.modal.isOpen = true;
        },
        onClickEdit(record){
            this.modal.data={...record};
            this.modal.title="修改職員記錄";
            this.modal.mode='EDIT';
            this.modal.isOpen = true;
        },
        onClickDelete(recordId){
            if (!confirm('是否確定刪除?')) return;
            this.$inertia.delete('/admin/---/' + recordId,{
                onSuccess: (page)=>{
                    console.log(page);
                },
                onError: (error)=>{
                    console.log(error);
                }
            });
        },
        modalCancel(){
            this.modal.data={}
            this.modal.isOpen=false
        },
        updateRecord(){
            this.$refs.modalRef.validateFields().then(()=>{
                this.$inertia.put(route('admin.students.update',this.modal.data.id), this.modal.data,{
                    onSuccess:(page)=>{
                        this.modal.data={}
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
        storeRecord(){
            this.$refs.modalRef.validateFields().then(()=>{
                this.$inertia.post(route('admin.students.store'), this.modal.data,{
                    onSuccess:(page)=>{
                        this.modal.data={}
                        this.modal.isOpen=false;
                    },
                    onError:(error)=>{
                        console.log(error);
                    }
                });
            }).catch(err => {
                console.log("error", err);
            });
        }

    },
}
</script>