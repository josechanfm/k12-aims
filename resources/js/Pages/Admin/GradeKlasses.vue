<template>
  <AdminLayout title="班別列表" :breadcrumb="breadcrumb">
    <div class="p-4 bg-white rounded-lg shadow-sm flex flex-col gap-4">
      <!-- 年級切換導航 -->
      <div class="flex flex-wrap items-center justify-between gap-2">
        <div class="flex flex-wrap gap-1">
          <a-button 
            v-for="g in grades" 
            :key="g.id" 
            @click="visitGradeYear(g)"
            :type="g.grade_year == gradeYear ? 'primary' : 'default'"
            size="small"
            class="!flex items-center"
          >
            {{ g.tag }}
          </a-button>
        </div>
      </div>

      <!-- 班別內容區域 -->
      <div class="rounded-lg border border-gray-200 p-2">
        <a-tabs 
          v-model:activeKey="selectKlassId"  
          type="card"
          class="ant-tabs-custom"
        >
          <a-tab-pane 
            v-for="klass in klasses" 
            :key="klass.id" 
            :tab="klass.tag"
          >
            <!-- 班別頭部操作區 -->
            <div class="flex flex-wrap items-center gap-2 mb-4 p-2 bg-gray-50 rounded-lg">
              <!-- 班主任管理 -->
            <div class="flex items-center gap-2 bg-gray-50 p-2 rounded-lg border">
                <div class="cursor-pointer" @click="klass.is_modify_head_ids ? storeHeadIds(klass) : klass.is_modify_head_ids = true">
                <a-tag :color="klass.is_modify_head_ids ? 'blue' : 'green'">
                    {{ klass.is_modify_head_ids ? '保存' : '修改' }}
                </a-tag>
                </div>
                
                <div v-if="klass.is_modify_head_ids" class="min-w-[200px]">
                <a-select
                    v-model:value="klass.klass_head_ids"
                    placeholder="請選擇班主任"
                    mode="multiple"
                    :options="teachers"
                    :field-names="{ value: 'id', label: 'name_zh' }"
                />
                </div>
                <div v-else class="flex flex-wrap gap-1">
                <a-tag v-for="x in klass.klass_heads" :key="x.id">
                    {{ x.name_zh }}
                </a-tag>
                </div>
            </div>

              <div class="flex-1"></div>

              <!-- 學期和鎖定操作 -->
              <div class="flex items-center gap-2 bg-white p-2 rounded border border-gray-200">
                <a-radio-group 
                  v-model:value="klass.current_term" 
                  size="small"
                  button-style="solid"
                  @change="onClickSelectedTermLock(klass.id, klass.current_term)"
                >
                  <a-radio-button
                    v-for="term in yearTerms"
                    :key="term.value"
                    :value="term.value"
                    :class="{ '!text-white': term.value == klass.current_term }"
                  >
                    {{ term.label }}
                  </a-radio-button>
                </a-radio-group>

                <a-popconfirm
                  :title="`確定要${klass.course_locked ? '解鎖' : '鎖定'} ${klass.tag} 的成績表嗎？`"
                  @confirm="onClickSelectedTermLock(klass.id, 0)"
                >
                  <a-button :type="klass.course_locked ? 'danger' : 'default'" size="small">
                    <template #icon>
                      <LockOutlined />
                    </template>
                    {{ klass.course_locked ? '解鎖成績' : '鎖定成績' }}
                  </a-button>
                </a-popconfirm>
              </div>
            </div>

            <!-- 科目表格 -->
            <a-table 
              :dataSource="klass.courses" 
              size="small" 
              :pagination="false"
              :rowKey="record => record.id"
              class="custom-ant-table"
            >
              <a-table-column title="科目名稱" width="25%">
                <template #default="{ record }">
                  <div class="font-medium">{{ record.study_subject.subject.title_zh }}</div>
                  <div class="text-xs text-gray-500">{{ record.study_subject.subject.title_en }}</div>
                </template>
              </a-table-column>
              
              <a-table-column title="授課老師">
                <template #default="{ record }">
                    <div class="flex items-center gap-2">
                        <div class="cursor-pointer" @click="record.is_modify_teacher_ids ? storeTeacherIds(record) : record.is_modify_teacher_ids = true">
                        <a-tag :color="record.is_modify_teacher_ids ? 'blue' : 'green'">
                            {{ record.is_modify_teacher_ids ? '保存' : '修改' }}
                        </a-tag>
                        </div>
                        
                        <div v-if="record.is_modify_teacher_ids" class="min-w-[200px]">
                        <a-select
                            v-model:value="record.teacher_ids"
                            placeholder="請選擇老師"
                            mode="multiple"
                            :options="teachers"
                            :field-names="{ value: 'id', label: 'name_zh' }"
                        />
                        </div>
                        <div v-else class="flex flex-wrap gap-1">
                        <a-tag v-for="x in record.teaching" :key="x.id">
                            {{ x.name_zh }}
                        </a-tag>
                        </div>
                    </div>
                </template>
              </a-table-column>
            </a-table>
          </a-tab-pane>
        </a-tabs>
      </div>
    </div>

    <!-- 班別編輯模態框 -->
    <a-modal
      v-model:open="modal.isOpen"
      :title="modal.title"
      width="60%"
      :footer="null"
      centered
    >
      <a-form
        ref="modalRef"
        :model="modal.data"
        :rules="rules"
        :validate-messages="validateMessages"
        layout="vertical"
      >
        <!-- 表單內容保持不變 -->
        <!-- ... -->
        
        <div class="flex justify-end gap-2 mt-6">
          <a-button @click="modalCancel">取消</a-button>
          <a-button 
            v-if="modal.mode == 'EDIT'" 
            type="primary" 
            @click="updateRecord"
          >
            提交更改
          </a-button>
        </div>
      </a-form>
    </a-modal>
  </AdminLayout>
</template>

<script >
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
    props: ['gradeYear','year','yearTerms','grades',
            'klasses', 'klassLetters', 'studyStreams','teachers'],
    data() {
        return {
            breadcrumb:[
                {label:"行政管理" ,url:route('admin.dashboard')},
                {label:"學年" ,url:route('admin.years.index')},
                // {label:"年級" ,url:route('admin.year.grades.index',this.grade.year_id)},
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
          
       
            selectKlassId:'',
        }
    },
    mounted(){
        this.selectKlassId=this.klasses[0].id
    },
    methods: {
        ///
      visitGradeYear(g) {
            this.$inertia.visit(route('admin.klasses.index', { gradeYear: g.id }), {
                preserveState: true,
                preserveScroll: true,
                onSuccess:()=>{
                    this.selectKlassId=this.klasses[0].id
                }
            })
        }, 
        ///
        closeModal() {
            this.isOpen = false;
            this.reset();
            this.editMode = false;
        },
        storeTeacherIds(record){
        this.$inertia.put(route('admin.course.updateCourseTeachers',record.id), record, {
                preserveScroll: true,
                preserveState: true,  
                onSuccess: (page) => {
                    console.log(page);
                },
                onError: (err) => {
                    console.log(err);
                }
            });
        },
        storeHeadIds(record) {
            let data={klass_head_ids:record.klass_head_ids,
                    id:record.id,
                    tag:record.tag,
                    letter:record.letter,
                    grade_id:record.grade.id
            }      
            // console.log('hi',record)
            // return false
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
                    preserveScroll: true,
                    preserveState: true,  
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
                    preserveScroll: true,
                    preserveState: true,  
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
        // createRecord() {
        //     this.modal.data = {};
        //     this.modal.data.grade_id = this.grade.id;
        //     this.modal.mode = 'CREATE';
        //     this.modal.title = "新增班別";
        //     this.modal.isOpen = true;
        //     this.klasses.forEach(klass => {
        //         this.klassLetters.forEach((kl, idx) => {
        //             if (klass.letter == kl.value) {
        //                 this.klassLetters[idx].disabled = true;
        //             }
        //         })
        //     })
        // },
        modalCancel(){
            this.modal.data={}
            this.modal.isOpen=false
        },
        onClickSelectedTermLock(klassId, termId) {
            this.$inertia.post(route('admin.lock.klass',{klassId:klassId,termId:termId}),{},{
                preserveScroll: true,
                preserveState: true,  
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

<style scoped>
/* 自定義樣式 */
.ant-tabs-custom :deep(.ant-tabs-tab) {
  @apply !px-4 !py-2;
}

.ant-tabs-custom :deep(.ant-tabs-tab-active) {
  @apply !bg-blue-50 !border-blue-200;
}

.custom-ant-table :deep(.ant-table-thead > tr > th) {
  @apply !bg-gray-50;
}

.custom-ant-table :deep(.ant-table-row) {
  @apply hover:!bg-gray-50;
}
</style>