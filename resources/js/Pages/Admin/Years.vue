<template>
    <AdminLayout title="學年" :breadcrumb="breadcrumb">
        <a-card class="flex flex-col gap-1 shadow-md ">
            <div class="flex">
                <div class="flex-1"></div> <a-button @click="createRecord()" type="create" size="small">創建新學年＋</a-button>
            </div>
        <!-- <div class="rounded-lg border-gray-200 p-2"> -->
           
            <a-table :dataSource="years" :columns="columns">
                <template #bodyCell="{column, text, record, index}">
                    <div v-if="column.dataIndex=='operation'" class="flex gap-1">
                        <a-button as="link" :href="route('admin.year.grades.index',record.id)" size="small" type="info">年級</a-button>
                        <a-button @click="lockTranscript(record)" size="small" type="info">鎖定成績表</a-button>
                        <a-button @click="editRecord(record)" size="small" type="edit">修改</a-button>
                        <a-button @click="deleteRecord(record)" size="small" type="delete">刪除</a-button>
                    </div>
                    <template v-else-if="column.dataIndex=='grade_group'">
                        <a-tag v-for="item in record[column.dataIndex]" :key="item"
                            :color="item.initial=='P'?'blue':item.initial=='S'?'green':'cyan'">{{item.initial}}:{{item.count}}</a-tag>
                    </template>
                    <template v-else-if="column.dataIndex=='current_year'">
                        <div  v-if="record[column.dataIndex]"><CheckOutlined /></div>
                    </template>
                    <template v-else>
                        {{record[column.dataIndex]}}
                    </template>
                </template>
            </a-table>
            
            <!-- </div> -->
            <!-- Modal Start-->
            <a-modal v-model:open="modal.isOpen" :title="modal.title" width="60%" @update="updateRecord(modalForm)" @onCancel="closeModal()">
                <a-form
                ref="modalRef"
                :model="modal.data"
                name="year"
                :label-col="{ span: 4 }"
                :wrapper-col="{ span: 20 }"
                autocomplete="off"
                :rules="rules"
                :validate-messages="validateMessages"
                @finish="onFinish"
                @onFinishFailed="onFinishFailed"
            >
            <!-- @validate="handleValidate" -->

                <a-form-item label="學年代號" name="code">
                    <a-input v-model:value="modal.data.code" style="width: 100px"/>
                </a-form-item>
                <a-form-item label="學年標題" name="title">
                    <a-input v-model:value="modal.data.title" />
                </a-form-item>
                <a-form-item label="時期" name="period">
                    <a-range-picker v-model:value="modal.data.period" :valueFormat="dateFormat" :format="dateFormat"/>
                </a-form-item>
                <a-form-item label="開始學段" name="current_term">
                    <a-radio-group v-model:value="modal.data.current_term">
                        <template v-for="term in yearTerms">
                            <a-radio-button :value="term.value">{{term.label}}</a-radio-button>
                        </template>
                    </a-radio-group>
                </a-form-item>
                <a-form-item label="當前學年" name="current_year">
                    <a-switch v-model:checked="modal.data.current_year" />
                </a-form-item>
                <a-form-item label="有效" name="active">
                    <a-switch v-model:checked="modal.data.active" />
                </a-form-item>
                <div v-if="modal.mode=='CREATE'">
                    <a-form-item label="簡介" name="description">
                        <a-textarea v-model:value="modal.data.description" />
                    </a-form-item>

                    <a-divider orientation="left">幼稚園</a-divider>
                    <div class="flex gap-1">
                        <div >
                            <a-form-item label="年級數" name="kgrade">
                                <a-select
                                v-model:value="modal.data.kgrade"
                                :options="kgradeOptions"
                                style="width: 80px"
                                />
                            </a-form-item>
                        </div>
                        <div :span="8">
                            <a-form-item label="班別數" name="kklass">
                                <a-select
                                v-model:value="modal.data.kklass"
                                :options="kklassOptions"
                                style="width: 80px"
                                />
                            </a-form-item>
                        </div>
                    </div>
                    <a-divider orientation="left">小學</a-divider>
                    <div class="flex">
                        <div >
                            <a-form-item label="年級數" name="pgrade">
                                <a-select
                                v-model:value="modal.data.pgrade"
                                :options="pgradeOptions"
                                style="width: 80px"
                                />
                            </a-form-item>
                        </div>
                        <div >
                            <a-form-item label="班級數" name="pklass">
                                <a-select
                                v-model:value="modal.data.pklass"
                                :options="pklassOptions"
                                style="width: 80px"
                                />
                            </a-form-item>
                        </div>
                    </div>
                    <a-divider orientation="left">中學</a-divider>
                    <div class="flex">
                        <div >
                            <a-form-item label="年級數" name="sgrade">
                                <a-select
                                v-model:value="modal.data.sgrade"
                                :options="sgradeOptions"
                                style="width: 80px"
                                />
                            </a-form-item>
                        </div>
                        <div >
                            <a-form-item label="班級數" name="sklass">
                                <a-select
                                v-model:value="modal.data.sklass"
                                :options="sklassOptions"
                                style="width: 80px"
                                />
                            </a-form-item>
                        </div>
                    </div>
                </div>
            </a-form>
            <template #footer>
                <a-button key="back" @click="modalCancel">返回</a-button>
                <a-button v-if="modal.mode=='EDIT'" key="Update" type="primary"  @click="updateRecord(modalForm)">更新</a-button>
                <a-button v-if="modal.mode=='CREATE'"  key="Store" type="primary"  @click="storeRecord(modalForm)">創建</a-button>
            </template>
        </a-modal>    
        <!-- Modal End-->
        </a-card>
    </AdminLayout>

</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { Modal } from 'ant-design-vue';
import { ExclamationCircleOutlined,CheckOutlined  } from '@ant-design/icons-vue';
import { ref, createVNode } from 'vue';
import dayjs from 'dayjs';

export default {
    components: {
        AdminLayout, Modal, createVNode, 
        ExclamationCircleOutlined, CheckOutlined
    },
    props: ['years','param','yearTerms','gradeYears'],
    data() {
        return {
            breadcrumb:[
                {label:"行政管理" ,url:route('admin.dashboard')},
                {label:"學年" ,url:null},
            ],
            kgrade:0,
            kklass:0,
            dataSource:[],
            dateFormat:'YYYY-MM-DD',
            modal:{
                mode:null,
                isOpen:false,
                data:{},
                title:'Years'
            },
            columns:[
                {
                    title: '學年代號',
                    dataIndex: 'code',
                    key: 'code',
                },{
                    title: '學年全稱',
                    dataIndex: 'title',
                    key: 'title',
                },{
                    title: '開學日',
                    dataIndex: 'start',
                    key: 'start',
                },{
                    title: '結業日',
                    dataIndex: 'end',
                    key: 'end',
                },{
                    title: '年級數目',
                    dataIndex: 'grade_group',
                    key: 'grade_group',
                },{
                    title: '現學段',
                    dataIndex: 'current_term',
                    key: 'active',
                },{
                    title: '當前學年',
                    dataIndex: 'current_year',
                    key: 'current_year',
                },{
                    title: '操作',
                    dataIndex: 'operation',
                    key: 'operation',
                },
            ],
            rules:{
                code:{required:true},
                title:{required:true},
                period:{required:true},
                current_term:{required:true},
                kgrade:{required:true},
                kklass:{required:true},
                pgrade:{required:true},
                pklass:{required:true},
                sgrade:{required:true},
                sklass:{required:true},
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
    mounted() {
   },
    methods: {
        createRecord(){
            this.modalForm={};
            this.modal.data.period=[dayjs('2022/09/01', this.dateFormat), dayjs('2023/07/01', this.dateFormat)];
            this.modal.data.current_term=1;
            this.modal.data.grade=[];
            this.modal.mode="CREATE";
            this.modal.isOpen=true
            this.modal.title="創建學年"
        },
        editRecord(record){
            this.modal.data={...record}
            if(this.modal.data.start){
                this.modal.data.period=[dayjs(this.modal.data.start, this.dateFormat), dayjs(this.modal.data.end, this.dateFormat)]
            }else{
                this.modal.data.period=[]
            }
            this.modal.mode="EDIT"
            this.modal.isOpen=true
            this.modal.title="修改學年"
        },
        storeRecord(record){
            this.$refs.modalRef.validateFields().then(()=>{
                this.$inertia.post((route('admin.years.store')), this.modal.data,{
                    onSuccess:(page)=>{
                        console.log(page);
                        this.modal.isOpen=false
                    },
                    onError:(err)=>{
                        //console.log(err);
                        Modal.error({
                            title: '數據一致性出錯',
                            content: '學年編號重複使用!',
                            okText: '了解',
                        });
                    }
                })
            }).catch(err => {
                console.log(err);
            });
        },
        updateRecord(data){
            console.log(this.modal.data);
            this.$refs.modalRef.validateFields().then(()=>{
                this.$inertia.put('/admin/years/' + this.modal.data.id, this.modal.data,{
                    onSuccess:(page)=>{
                        this.modal.isOpen=false;

                        //this.ChangeModalMode('Close');
                    },
                    onError:(error)=>{
                        console.log(error);
                    }
                });
                //this.loading=false;                
            }).catch(err => {
                console.log("error", err);
            });
           
        },
        deleteRecord(record){
            Modal.confirm({
                title: '是否確定',
                content: '刪除所選之主題?',
                okText: '確定',
                cancelText: '取消',
                onOk: () => {
                    this.$inertia.delete(route('admin.years.destroy', record.id), {
                        onSuccess: (page) => {
                            console.log(record.id+"deleted.");
                        },
                        onError: (error) => {
                            Modal.error({
                                title: '數據一致性出錯',
                                content: error.message,
                                okText: '了解',
                            });
                        }
                    });
                }
            })
        },
        // handleValidate(field){
        //     console.log("handleValidate: "+field);
        // },
        modalCancel(){
            this.modal.data={}
            this.modal.isOpen=false
        },
        onFinish(value){
            console.log("onFinish"+value);
        },
        onFinishFailed(errorInfo){
            console.log('errorInfo: '+errorInfo);
        },
        lockTranscript(record){
            if(!confirm('鎖定成績表分數轉換功能，是不確定？')) return;
            this.$inertia.get(route('admin.lockTranscripts'),{scope:'year',id:record.id},{
                onSuccess: (page)=>{
                    console.log(page);
                },
                onError: (error)=>{
                    console.log(error);
                }
            });
        }

    },
}
</script>