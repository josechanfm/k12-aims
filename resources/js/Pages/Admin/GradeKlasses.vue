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
      <div class="rounded-lg border border-gray-200">
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
            <div class="flex flex-wrap items-center justify-between gap-4 p-4 bg-gray-50 border-b">
              <!-- 班主任管理 -->
              <div class="flex items-center gap-2">
                <span class="font-medium">班主任：</span>
                <div v-if="klass.is_modify_head_ids" class="flex items-center gap-2">
                  <a-select
                    v-model:value="klass.klass_head_ids"
                    placeholder="請選擇班主任"
                    mode="multiple"
                    :options="teachers"
                    :field-names="{ value: 'id', label: 'name_zh' }"
                    class="min-w-[200px]"
                  />
                  <a-button type="primary" size="small" @click="storeHeadIds(klass)">
                    保存
                  </a-button>
                  <a-button size="small" @click="klass.is_modify_head_ids = false">
                    取消
                  </a-button>
                </div>
                <div v-else class="flex items-center gap-2">
                  <div class="flex flex-wrap gap-1">
                    <a-tag v-for="x in klass.klass_heads" :key="x.id" color="blue">
                      {{ x.name_zh }}
                    </a-tag>
                  </div>
                  <a-button size="small" @click="klass.is_modify_head_ids = true">
                    <template #icon>
                      <EditOutlined />
                    </template>
                    修改
                  </a-button>
                </div>
              </div>

              <!-- 學期和鎖定操作 -->
              <div class="flex items-center gap-4">
                <div class="flex items-center gap-2">
                  <span class="font-medium">學期：</span>
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
                      :class="{
                        '!bg-blue-500 !border-blue-500': term.value == klass.current_term,
                        'hover:!text-blue-500': term.value != klass.current_term
                      }"
                    >
                      {{ term.label }}
                    </a-radio-button>
                  </a-radio-group>
                </div>

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

            <!-- 學生和科目表格 -->
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4 p-4">
              <!-- 學生表格 -->
              <div class="border border-gray-200 rounded-lg overflow-hidden">
                <a-table 
                  :dataSource="klass.students" 
                  size="small" 
                  :pagination="false" 
                  :rowKey="record => record.id"
                  bordered
                >
                  <a-table-column title="學號" align="center" width="80px">
                    <template #default="{record}">
                      <span class="font-mono">{{ record.pivot.student_number }}</span>
                    </template>
                  </a-table-column>
                  <a-table-column title="姓名" width="150px">
                    <template #default="{record}">
                      <div class="font-medium">{{ record.name_c }}</div>
                      <div class="text-xs text-gray-500">{{ record.name_p }}</div>
                    </template>
                  </a-table-column>
                  <a-table-column title="文/理" align="center" width="60px">
                    <template #default="{record}">
                      <a-tag :color="sci_art_color[ record.pivot.stream]">
                        {{ sci_art[ record.pivot.stream]??record.pivot.stream }}
                      </a-tag>
                    </template>
                  </a-table-column>
                  <a-table-column title="親屬" align="center" >
                    <template #default="{record}">
                    
                    </template>
                  </a-table-column>
                </a-table>
              </div>

              <!-- 科目表格 -->
              <div class="border border-gray-200 rounded-lg overflow-hidden">
                <a-table 
                  :dataSource="klass.courses" 
                  size="small" 
                  :pagination="false" 
                  :rowKey="record => record.id"
                  bordered
                >
                  <a-table-column title="#" width="40px" align="center">
                    <template #default="{index}">
                      {{ index + 1 }}
                    </template>
                  </a-table-column>
                  <a-table-column title="科目名稱">
                    <template #default="{ record }">
                      <div class="font-medium">{{ record.study_subject.subject.title_zh }}</div>
                      <div class="text-xs text-gray-500">{{ record.study_subject.subject.title_en }}</div>
                    </template>
                  </a-table-column>
                  <a-table-column title="授課老師">
                    <template #default="{ record }">
                      <div class="flex items-center gap-2">
                        <div v-if="record.is_modify_teacher_ids" class="flex items-center gap-2 w-full">
                          <a-select
                            v-model:value="record.teacher_ids"
                            placeholder="請選擇老師"
                            mode="multiple"
                            :options="teachers"
                            :field-names="{ value: 'id', label: 'name_zh' }"
                            class="flex-1"
                          />
                          <a-button type="primary" size="small" @click="storeTeacherIds(record)">
                            保存
                          </a-button>
                          <a-button size="small" @click="record.is_modify_teacher_ids = false">
                            取消
                          </a-button>
                        </div>
                        <div v-else class="flex items-center gap-2">
                          <div class="flex flex-wrap gap-1">
                            <a-tag v-for="x in record.teaching" :key="x.id" color="green">
                              {{ x.name_zh }}
                            </a-tag>
                          </div>
                          <a-button size="small" @click="record.is_modify_teacher_ids = true">
                            <template #icon>
                              <EditOutlined />
                            </template>
                          </a-button>
                        </div>
                      </div>
                    </template>
                  </a-table-column>
                </a-table>
              </div>
            </div>
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
      @cancel="modalCancel"
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

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import ButtonLink from '@/Components/ButtonLink.vue';
import { LockOutlined, EditOutlined } from '@ant-design/icons-vue';

export default {
  components: {
    AdminLayout,
    ButtonLink,
    LockOutlined,
    EditOutlined
  },
  props: [
    'gradeYear',
    'year',
    'yearTerms',
    'grades',
    'klasses', 
    'klassLetters', 
    'studyStreams',
    'teachers'
  ],
  data() {
    return {
      sci_art_color:{'ALL':"blue",'SCI':'理',"cyan":'purple'},
      sci_art:{'ALL':"全",'SCI':'理',"ART":'文'},
      breadcrumb: [
        { label: "行政管理", url: route('admin.dashboard') },
        { label: "學年", url: route('admin.years.index') },
        { label: "班別", url: null },
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
      selectKlassId: ''
    }
  },
  mounted() {
    this.selectKlassId = this.klasses[0]?.id || '';
  },
  methods: {
    visitGradeYear(g) {
      this.$inertia.visit(route('admin.klasses.index', { gradeYear: g.id }), {
        preserveState: true,
        preserveScroll: true,
        onSuccess: () => {
          this.selectKlassId = this.klasses[0]?.id || '';
        }
      });
    },
    closeModal() {
      this.isOpen = false;
      this.reset();
      this.editMode = false;
    },
    storeTeacherIds(record) {
      this.$inertia.put(route('admin.course.updateCourseTeachers', record.id), record, {
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
      let data = {
        klass_head_ids: record.klass_head_ids,
        id: record.id,
        tag: record.tag,
        letter: record.letter,
        grade_id: record.grade.id
      };
      
      this.$inertia.put(route('admin.grade.klasses.update', [record.grade.id, record.id]), data, {
        preserveScroll: true,
        preserveState: true,    
        onSuccess: (page) => {
          // Success handler
        },
        onError: (err) => {
          // Error handler
        }
      });
    },
    storeRecord() {
      this.$refs.modalRef.validateFields().then(() => {
        this.$inertia.post(route('admin.grade.klasses.store', this.grade.id), this.modal.data, {
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
        this.$inertia.put(route('admin.grade.klasses.update', [this.grade.id, this.modal.data.id]), this.modal.data, {
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
    modalCancel() {
      this.modal.data = {};
      this.modal.isOpen = false;
    },
    onClickSelectedTermLock(klassId, termId) {
      this.$inertia.post(route('admin.lock.klass', {klassId: klassId, termId: termId}), {}, {
        preserveScroll: true,
        preserveState: true,  
        onSuccess: (page) => {
          console.log(page);
        },
        onError: (err) => {
          alert(err.message);
        }
      });
    },
    getStudyPlan(text) {
      const study = this.studyPlans.find(study => study.id == text);
      return text;
    },
  }
}
</script>

<style scoped>
.ant-tabs-custom :deep(.ant-tabs-nav) {
  @apply mb-0;
}

.ant-tabs-custom :deep(.ant-tabs-tab) {
  @apply !px-4 !py-2 !m-0 !border-gray-200;
}

.ant-tabs-custom :deep(.ant-tabs-tab-active) {
  @apply !bg-blue-50 !border-b-blue-500 !text-blue-600;
}

.ant-tabs-custom :deep(.ant-tabs-tab:hover) {
  @apply !text-blue-500;
}

.ant-tabs-custom :deep(.ant-tabs-ink-bar) {
  @apply !bg-blue-500;
}

.ant-tabs-custom :deep(.ant-tabs-content) {
  @apply p-0;
}
</style>