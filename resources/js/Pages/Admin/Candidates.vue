<template>
    <AdminLayout title="入學報名列表" :breadcrumb="breadcrumb">
        <div class="flex items-center gap-1 my-1">
            <a-button @click="onClickCreate()" type="primary">新增報名</a-button>
            <div class="flex-1 "></div>
          
                <a-upload v-model:file-list="fileList"
                :customRequest="onXlsxUpload"
                :maxCount="1"  >
                    <a-button>
                    <upload-outlined></upload-outlined>
                        上傳學生資料
                    </a-button>
                </a-upload>
                <a _blank href="../excel/download_sheet">download</a>
        </div>
        <div v-if="$page.props.data" class="my-1"> 
            <div class="bg-white rounded-lg px-2 py-2">
                <div class="text-gray-400 font-extrabold">匯入資料</div>
                <a-tabs  :v-model:activeKey="'success'">
                    <a-tab-pane key="success"  :tab="'成功匯入('+$page.props.data.successes.length+')'">
                        <div class="rounded-lg border border-gray-50 p-1 bg-blue-100 text-base ">
                            <div class="font-semibold flex text-sm  text-gray-500  border-gray-400 border border-b border-t-0 border-l-0 border-r-0">
                                <div class="text-center w-1/3">校內編號</div>
                                <div class="w-1/3 text-center">姓名</div>
                                <div class="w-1/3 text-center">身份證</div>
                            </div>
                            <div class="overflow-y-scroll  max-h-[600px]">
                                <div class="font-base flex  border border-b border-t-0 border-l-0 border-r-0  border-gray-400 py-1" :key="idx" v-for="row,idx in $page.props.data.successes">
                                    <div class="text-center w-1/3">{{ row.stud_id }}</div>
                                    <div class="w-1/3 text-center">{{ row.name_zh }}</div>
                                    <div class="w-1/3 text-center">{{ row.id_num }}</div>
                                </div>
                            </div>
                            <div class="w-full text-center py-4" v-if="$page.props.data.successes.length==0">
                                無匯入學生
                            </div>
                        </div>
                    </a-tab-pane>
                    <a-tab-pane key="failure" :tab="'失敗('+$page.props.data.failures.length+')'">
                        <div class="rounded-lg border border-gray-50 p-1 bg-red-100 text-sm ">
                            <div class="font-semibold flex text-sm  text-gray-500  border-gray-400 border border-b border-t-0 border-l-0 border-r-0">
                                <div class="text-center w-1/3">行數</div>
                                <div class="w-1/3 text-center">欄位</div>
                                <div class="w-1/3 text-center">數誤信息</div>
                                <div class="w-1/3 text-center">數誤值</div>
                            </div>
                            <div class="overflow-y-scroll  max-h-[600px]">
                                <div class="font-base flex  border border-b border-t-0 border-l-0 border-r-0  border-gray-400 py-1" :key="idx" v-for="row,idx in $page.props.data.failures">
                                    <div class="text-center w-1/3">{{ row.row }}</div>
                                    <div class="w-1/3 text-center ">{{ $t(row.attribute) }}</div>
                                    <div class="w-1/3 text-center">{{ row.errors }}</div>
                                    <div class="w-1/3 text-center text-red-500">{{ row.values[row.attribute] }}</div>
                                </div>
                            </div>
                            <div class="w-full text-center py-4" v-if="$page.props.data.failures.length==0">
                                無匯入失敗學生
                            </div>
                        </div>
                    </a-tab-pane>
                </a-tabs>
            </div>
        </div>
            <a-table :dataSource="candidates.data" :columns="columns" :pagination="pagination" @change="onPaginationChange" ref="dataTable">
                <template #bodyCell="{column, text, record, index}">
                    <template v-if="column.dataIndex=='operation'">
                        <a-button  :disabled="record.accepted" @click="onClickAccepted(record)" size="small" type="info">接收</a-button>
                        <a-button :disabled="!record.accepted || record.student_id!=null" :href="route('admin.registrations.create',{candidate_id:record.id})" size="small" type="info">注冊</a-button>
                        <a-button :disabled="record.student_id==null || record.enrolled" :href="route('admin.enrollments.create',{student_id:record.student_id})"  size="small"  type="info">分班</a-button>
                        <a-button @click="onClickEdit(record)" size="small" type="edit">修改</a-button>
                        <a-button href="" :disabled="record.accepted || record.enrolled || record.student_id" @click="onClickDelete(record)" size="small" type="delete">刪除</a-button>
                    </template>
                    <template v-else-if="column.dataIndex=='accepted'">
                        {{ text?'是':'否' }}
                    </template>
                    <template v-else-if="column.dataIndex=='enrolled'">
                        {{ text?'是':'否' }}
                    </template>
                    <template v-else-if="column.dataIndex=='student_id'">
                        <a-button v-if="record.student_id" as="link" :href="route('director.students.show',record.student_id)" target="_blank">學生檔案</a-button>
                        <span v-else>--</span>
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
import ButtonLink from '@/Components/ButtonLink.vue';
import {CheckSquareOutlined, ConsoleSqlOutlined, StopOutlined} from '@ant-design/icons-vue';
import { extractIdentifiers } from '@vue/compiler-core';
import { router } from '@inertiajs/vue3';

export default {
    components: {
        AdminLayout,
        ButtonLink,
        CheckSquareOutlined,
        StopOutlined
    },
    props: ['gradesKlasses','candidates'],
    data() {
        return {
            csrfToken:'',
            fileList :[],
            breadcrumb:[
                {label:"行政管理" ,url:route('admin.dashboard')},
                {label:"入學報名" ,url:null},
            ],
            pagination:{
                total: this.candidates.total,
                current:this.candidates.current_page,
                pageSize:this.candidates.per_page,
            },
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
                    title: '入讀年級',
                    dataIndex: 'start_grade_tag',
                },{
                    title: '入讀班別',
                    dataIndex: 'start_klass_tag',
                },{
                    title: '接收',
                    dataIndex: 'accepted',
                },{
                    title: '已注冊',
                    dataIndex: 'student_id',
                },{
                    title: '已分班',
                    dataIndex: 'enrolled',
                },{
                    title: '操作',
                    dataIndex: 'operation',
                }
            ],
        }
    },
    created(){
       window.app=this
    },
    methods: {
        onPaginationChange(page, filters, sorter){
            this.$inertia.get(route('admin.candidates.index'),{
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
            this.$inertia.get(route('admin.candidates.create'),{
                onSuccess:(page)=>{
                    console.log(page.data)
                },
                onError: (error)=>{
                    console.log(error)
                }
            });
        },
        onClickEdit(record){
            this.$inertia.get(route('admin.candidates.edit',record.id),{
                onSuccess:(page)=>{
                    console.log(page.data)
                },
                onError: (error)=>{
                    console.log(error)
                }
            });
        },
        onClickDelete(record){
            if (!confirm('是否確定刪除?')) return;
            this.$inertia.delete(route('admin.candidates.destroy',record.id),{
                onSuccess: (page)=>{
                    console.log(page);
                },
                onError: (error)=>{
                    console.log(error);
                }
            });
        },
        onClickAccepted(record){
            record.accepted=true;
            console.log(record)
            this.$inertia.put(route('admin.candidate.accepted'), record,{
                onSuccess:(page)=>{
                    console.log(page)
                    record.enroll_confirm=false
                },
                onError:(error)=>{
                    record.enroll_confirm=false
                    console.log(error);
                }
            });

        },
        onXlsxUpload(fileObj){
            this.$inertia.post(route('admin.excelToStudents'),{
                file:fileObj.file
            },{
                onSuccess(data){
                    console.log(data)
                },
                onCancel(err){
                  
                },
            })
            this.fileList=[]
        },
    },
}
</script>
