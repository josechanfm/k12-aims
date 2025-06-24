<template>
    <AdminLayout title="班別列表" :breadcrumb="breadcrumb">
        <div  class="p-2 bg-white rounded-lg flex flex-col gap-1">
        <!--  -->
        <div class="flex flex-wrap font-bold text-sm gap-1">
                <div class=" capsule-outline ">
                    <div class="capsule-label ">學年</div>
                    <div class=" "> 
                       {{ grade.year.title }}    
                    </div>
                </div>
                <div class="capsule-outline">
                    <div class="capsule-label ">年級</div>
                    <div class=" ">{{ grade.tag  }}</div>
                </div>
                <div class="flex-1"></div>
            </div>
        <!--  -->
        
        <div class="flex">
            <div class="flex-1 flex gap-1 items-center">
            <a-button as="link" :key="g.id" v-for="g in grades" :href="route('admin.grade.klasses.index', g.id)"
                :type="grade.tag==g.tag?'active':'list'" >
                {{g.tag }}
            </a-button>
        </div>  
            <a-button @click="createRecord()" type="create" size="small">新增班別</a-button>
        </div>
        <div  class="rounded-lg border-gray-200 border p-2">
        <a-table :dataSource="klasses" :columns="columns" >
            <template #bodyCell="{ column, text, record, index }">
                <template v-if="column.dataIndex == 'operation'">
                    <div class="flex flex-col gap-1" >
                        <a-button  type="xs-normal"  as="link" :href="route('director.klasses.show',record.id)" >班別管理</a-button>
                        <a-button  type="xs-normal" as="link" :href="route('teacher.selected.students', {model:'klass',id:record})" >學生名單</a-button>
                        <span v-if="record.grade.grade_year <= 3">
                            <a-button class="w-full"  type="xs-normal" as="link"  :href="route('admin.klass.themes.index', record.id)" >主題</a-button>
                        </span>
                      
                        <span v-else>
                            <a-button class="w-full"  type="xs-normal" as="link"  :href="route('admin.klass.courses.index', record.id)">科目</a-button>
                        </span>
                        <a-popconfirm
                            :title="(record.course_locked?'是否確定解鎖':'是否確定鎖定')+record.tag+'的成績表?'"
                            ok-text="Yes"
                            cancel-text="No"
                            @confirm="onClickSelectedTermLock(record.id,0)"
                        > 
                        <a-button type="xs-normal">
                                {{ record.course_locked?'解鎖成績':'鎖定成績' }}
                            </a-button>
                        </a-popconfirm>
                        <a-button @click="editRecord(record)" size="small" class="!text-xs" type="edit">修改</a-button>
                    </div>
                </template>
                <template  v-else-if="column.dataIndex == 'terms'">
                    <!--  :disabled="record.course_locked" ? -->
                    <a-radio-group size="small" class="flex flex-col text-nowrap items-center" v-model:value="record.current_term"  @change="onClickSelectedTermLock(record.id,record.current_term)" >
                        <a-radio class="rounded-lg"
                            :class="term.value==record.current_term?'text-blue-600 font-black':''"
                            v-for="term in yearTerms" :key="term.value" :value="term.value">{{term.label}}</a-radio>
                    </a-radio-group>   
                </template>
                <template v-else-if="column.dataIndex == 'head_teacher'">
                    <!-- {{ record.klass_heads }} -->
                      <div class="flex items-center gap-1">
                        <div class="cursor-pointer "  >
                            <div class=" rounded-lg p-1 !text-blue-600 font-black bg-blue-200" v-if="record.is_modify_head_ids===true" @click="storeHeadIds(record)">保存 </div>
                            <div class=" rounded-lg p-1 !text-green-600 font-black bg-green-200" v-else @click="record.is_modify_head_ids=!!!(record.is_modify_head_ids)">修改 </div>
                        </div>
                        <div v-if="record.is_modify_head_ids===true">
                            <a-select  v-model:value="record.klass_head_ids" class="!min-w-32 !w-64" placeholder="請選擇..."
                            max-tag-count="responsive" :options="teachers" mode="multiple"
                            :field-names="{ value: 'id', label: 'name_zh'  }"></a-select>
                        </div>
                        <div  v-else>
                           <a-tag v-for="x in  record.klass_heads" :key="x">{{ x.name_zh }}</a-tag>
                        </div>
                    </div>
                
                </template>
                <template v-else-if="column.dataIndex == 'room'">
                    {{ record.room }}
                </template>
                <template v-else-if="column.dataIndex == 'courses'">
                    {{ record.course_count }}
                </template>
                <template v-else-if="column.dataIndex == 'students'">
                    {{ record.student_count }}
                    <!-- {{ record.students.length }} -->
                </template>
                <template v-else-if="column.dataIndex == 'transcript_migrated'">
                    <div class="flex">
                        <div v-if="record.transcript_migrated">
                            <NodeExpandOutlined />
                        </div>
                        <div v-else>
                            <MenuOutlined />
                        </div>
                        <div v-if="record.transcript_locked">
                            <LockOutlined />
                        </div>
                    </div>
                </template>
                <template v-else>
                    {{ record[column.dataIndex] }}
                </template>
            </template>
        </a-table>
    </div>
        <!-- Modal Start-->
        <a-modal v-model:open="modal.isOpen" :title="modal.title" width="60%">
            <a-form ref="modalRef" :model="modal.data" name="klasses" :label-col="{ span: 8 }" :wrapper-col="{ span: 16 }"
                autocomplete="off" :rules="rules" :validate-messages="validateMessages">
                <a-form-item label="年級代號" name="grade">
                    {{ grade.tag }}
                </a-form-item>
                <a-form-item label="班別號" name="letter">
                    <a-select v-model:value="modal.data.letter" style="width: 100%" placeholder="請選擇..."
                        max-tag-count="responsive" :options="klassLetters"></a-select>
                </a-form-item>
                <a-form-item label="班別別稱" name="byname">
                    <a-input v-model:value="modal.data.byname" />
                </a-form-item>
                <a-form-item label="專業方向" name="stream">
                    <a-radio-group v-model:value="modal.data.stream" :options="studyStreams" option-type="button" button-style="solid" :disabled="modal.mode=='EDIT'"/>
                </a-form-item>
                <a-form-item label="學習計劃" name="study_id">
                    <a-select v-model:value="modal.data.study_id" :options="studies" :fieldNames="{value:'id',label:'title_zh'}" :disabled="modal.mode=='EDIT'"/>
                    </a-form-item>
                <a-form-item label="當前學段" name="current_term">
                    <a-radio-group v-model:value="modal.data.current_term" :options="yearTerms" option-type="button" button-style="solid"/>
                </a-form-item>
                <a-form-item label="學科鎖定" name="course_locked">
                    <a-switch v-model:checked="modal.data.course_locked" checkedChildren="鎖定成績" unCheckedChildren="解鎖成績"/>
                </a-form-item>
                <a-form-item label="教室編號" name="room">
                    <a-input v-model:value="modal.data.room" />
                </a-form-item>
                <a-form-item label="班主任" name="klass_head_ids">
                    <a-select v-model:value="modal.data.klass_head_ids" style="with:100%" placeholder="請選擇..."
                        max-tag-count="responsive" :options="teachers" mode="multiple"
                        :field-names="{ value: 'id', label: 'name_zh'  }"></a-select>
                </a-form-item>
            </a-form>
            <template #footer>
                <a-button key="back" @click="modalCancel" type="delete">關閉</a-button>
                <a-button v-if="modal.mode == 'EDIT'" key="Update" type="edit" @click="updateRecord()" >提交並更改</a-button>
                <a-button v-if="modal.mode == 'CREATE'" key="Store" type="create" @click="storeRecord()">提交並新增</a-button>
            </template>
        </a-modal>
        <!-- Modal End-->
    </div>
    </AdminLayout>
</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import ButtonLink from '@/Components/ButtonLink.vue';
import { NodeExpandOutlined, MenuOutlined, LockOutlined } from '@ant-design/icons-vue'
export default {
    components: {
        AdminLayout,
        ButtonLink,
        NodeExpandOutlined,
        MenuOutlined,
        LockOutlined
    },
    props: ['yearTerms','grades', 'grade', 'klasses', 'klassLetters', 'studyStreams', 'studies','teachers'],
    data() {
        return {
            breadcrumb:[
                {label:"行政管理" ,url:route('admin.dashboard')},
                {label:"學年" ,url:route('admin.years.index')},
                {label:"年級" ,url:route('admin.year.grades.index',this.grade.year_id)},
                {label:"班別" ,url:null},
            ],
            selectedTerm: 1,
            modal: {
                mode: null,
                isOpen: false,
                title: 'Klasses',
                data: {}
            },
            dataSource: [],
            columns: [
                {
                    title: '班別代號',
                    dataIndex: 'tag',
                }, {
                    title: '班主任',
                    dataIndex: 'head_teacher',
                }, {
                    title: '專業方向',
                    dataIndex: 'stream',
                }, {
                    title: '教室編號',
                    dataIndex: 'room',
                }, {
                    title: '科目數目',
                    dataIndex: 'courses',
                }, {
                    title: '學生人數',
                    dataIndex: 'students',
                }, {
                    title: '成績表鎖定',
                    dataIndex: 'transcript_migrated',
                }, 
                {
                    title: '學段狀態',
                    dataIndex: 'terms',
                },
                {
                    title: '操作',
                    dataIndex: 'operation',
                },
            ],
            rules: {
                letter: {
                    required: true,
                },
                study_id: {
                    required: true,
                }
            },
            validateMessages: {
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
        // axios.get(route('api.config.item',{key:'year_terms'}))
        //     .then(res=>{
        //         this.yearTerms=res.data
        //     })
        //     .catch(err=>{
        //         console.log(err)
        //     })
    },
    methods: {
        closeModal() {
            this.isOpen = false;
            this.reset();
            this.editMode = false;
        },
        storeHeadIds(record) {
            let data={klass_head_ids:record.klass_head_ids,
                    id:record.id,
                    tag:record.tag,
                    letter:record.letter,
                    grade_id:record.grade.id
            }      
            this.$inertia.put(route('admin.grade.klasses.update',[record.grade.id,record.id]), data, {
                    preserveScroll: true,
                    preserveState: true,    
                    onSuccess: (page) => {
                     
                    },
                    onError: (err) => {
                       
                    }
                });
        },
        storeRecord() {
            console.log(this.modal.data);
            this.$refs.modalRef.validateFields().then(() => {
                this.$inertia.post(route('admin.grade.klasses.store',this.grade.id), this.modal.data, {
                    onSuccess: (page) => {
                        this.modal.isOpen = false;
                        console.log(page);
                    },
                    onError: (err) => {
                        console.log(err);
                    }
                });
            }).catch(err => {
                console.log(err);
            });
        },
        updateRecord() {
            this.$refs.modalRef.validateFields().then(() => {
                this.$inertia.put(route('admin.grade.klasses.update',[this.grade.id,this.modal.data.id]),  this.modal.data, {
                    onSuccess: (page) => {
                        this.modal.isOpen = false;
                    },
                    onError: (error) => {
                        console.log(error);
                    }
                });
            }).catch(err => {
                console.log("error", err);
            });

        },
        editRecord(record) {
            this.modal.data = { ...record };
            this.modal.mode = 'EDIT';
            this.modal.title = "修改班別";
            this.modal.isOpen = true;
        },
        createRecord() {
            this.modal.data = {};
            this.modal.data.grade_id = this.grade.id;
            this.modal.mode = 'CREATE';
            this.modal.title = "新增班別";
            this.modal.isOpen = true;
            this.klasses.forEach(klass => {
                this.klassLetters.forEach((kl, idx) => {
                    if (klass.letter == kl.value) {
                        this.klassLetters[idx].disabled = true;
                    }
                })
            })
        },
        modalCancel(){
            this.modal.data={}
            this.modal.isOpen=false
        },
        onClickSelectedTermLock(klassId, termId) {
            this.$inertia.post(route('admin.lock.klass',{klassId:klassId,termId:termId}),{},{
                onSuccess: (page)=>{
                    console.log(page);
                },
                onError:(err)=>{
                    alert(err.message)                        
                }
            })

        },
        getStudyPlan(text) {
            const study = this.studyPlans.find(study => study.id == text)
            return text;
            //return study.title_zh + " (v."+study.version+")"
        },

    },
}
</script>
