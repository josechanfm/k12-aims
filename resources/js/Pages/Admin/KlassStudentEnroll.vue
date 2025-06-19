<template>
  <AdminLayout title="分班">
    <div class="p-6 space-y-6">
      <!-- 篩選控制區域 -->
      <div class="flex flex-wrap items-end gap-4 mb-6">
        <div class="flex-1 min-w-[200px]">
          <label class="block text-sm font-medium text-gray-700 mb-1">選擇學年</label>
          <a-select
            v-model:value="yearCode"
            class="w-full"
            size="large"
          >
            <a-select-option 
              v-for="x in years" 
              :key="x.code" 
              :value="x.code"
            >
              {{ x.code }}
            </a-select-option>
          </a-select>
        </div>
        
        <div class="flex-1 min-w-[200px]">
          <label class="block text-sm font-medium text-gray-700 mb-1">選擇班別</label>
          <a-select
            v-model:value="klassId"
            class="w-full"
            size="large"
          >
            <a-select-option 
              v-for="x in klasses" 
              :key="x.id" 
              :value="x.id"
            >
              {{ x.tag }}
            </a-select-option>
          </a-select>
        </div>
        
        <a-button 
          type="primary" 
          size="large"
          @click="studentFinder"
        >
          預覽
        </a-button>
        
        <a-button 
            type="primary" 
            size="large"
            @click="handleEnrollStudents"
            :disabled="!canEnroll"
        >
            確認插入班別
        </a-button>
      </div>

      <!-- 主內容區域 -->
      <div class="flex flex-col lg:flex-row gap-4">
        <!-- 學生輸入區域 -->
        <div class="bg-white p-4 rounded-lg shadow-sm border border-gray-100 flex-1">
          <a-textarea
            v-model:value="text"
            class="w-full"
            :rows="10"
            placeholder="請輸入學生編號，每行一個，例如：&#10;S01998-8&#10;S00001-4"
          />
        </div>

        <!-- 結果展示區域 -->
        <div class="flex-1 grid grid-cols-1 md:grid-cols-2 gap-4">
          <!-- 可加入班級學生 -->
          <div class="bg-white p-4 rounded-lg shadow-sm border border-gray-100">
            <h3 class="text-lg font-semibold text-gray-800 mb-3">
              可加入學生 <span class="text-green-600">({{ passStudents.length }})</span>
            </h3>
            <div class="space-y-2 max-h-[300px] overflow-y-auto">
              <div 
                v-for="student in passStudents" 
                :key="student.id"
                class="p-2 rounded-md bg-green-50 border border-green-100"
              >
                <div class="flex items-center gap-2">
                  <span class="font-medium">{{ student.name_c }}</span>
                  <span class="text-sm text-gray-500">{{ student.id_no }}</span>
                  <span class="text-sm text-gray-500 ml-auto">{{ student.stud_id }}</span>
                </div>
              </div>
              <a-empty v-if="passStudents.length === 0" description="無可加入學生" />
            </div>
          </div>

          <!-- 已存在班級學生 -->
          <div class="bg-white p-4 rounded-lg shadow-sm border border-gray-100">
            <h3 class="text-lg font-semibold text-gray-800 mb-3">
              已存在班級 <span class="text-orange-600">({{ existStudents.length }})</span>
            </h3>
            <div class="space-y-2 max-h-[300px] overflow-y-auto">
              <div 
                v-for="student in existStudents" 
                :key="student.id"
                class="p-2 rounded-md bg-orange-50 border border-orange-100"
              >
                <div class="flex items-center gap-2">
                  <span class="font-medium">{{ student.name_c }}</span>
                  <span class="text-sm text-gray-500">{{ student.id_no }}</span>
                  <span class="text-sm text-gray-500 ml-auto">{{ student.stud_id }}</span>
                </div>
                <div class="text-xs text-orange-600 mt-1">
                  已存在: {{ student.klasses.map(x => x.tag).join(', ') }}
                </div>
              </div>
              <a-empty v-if="existStudents.length === 0" description="無重複學生" />
            </div>
          </div>

          <!-- 未找到學生 (單獨一行顯示) -->
          <div 
            class="bg-white p-4 rounded-lg shadow-sm border border-gray-100 md:col-span-2" 
            v-if="noFoundCodes.length > 0"
          >
            <h3 class="text-lg font-semibold text-gray-800 mb-3">
              未找到的學生編號 <span class="text-red-600">({{ noFoundCodes.length }})</span>
            </h3>
            <div class="grid grid-cols-2 md:grid-cols-4 lg:grid-cols-6 gap-2">
              <div 
                v-for="code in noFoundCodes" 
                :key="code"
                class="p-2 bg-red-50 rounded-md text-center"
              >
                <span class="text-red-600 font-mono">{{ code }}</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </AdminLayout>
</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { Modal } from 'ant-design-vue';
export default {
    components: {
        AdminLayout,
    },
    props: ['years','klasses'],
    data() {
        return {
            text:"",
            yearCode:null,
            klassId:null,
            students:[],
            noFoundCodes:[],
        }
    },
    created(){
        this.yearCode=this.years[0]?.code??null
    },
    methods: {
         handleEnrollStudents() {
            if (!this.klassId) {
                Modal.error({
                    title: '操作失敗',
                    content: '請先選擇要插入的班別',
                });
                return;
            }

            if (this.passStudents.length === 0) {
                Modal.warning({
                    title: '無可加入學生',
                    content: '沒有符合條件的學生可加入班別',
                });
                return;
            }

            Modal.confirm({
                title: '確定要執行分班操作嗎？',
                content: `將把 ${this.passStudents.length} 名學生加入選定的班別`,
                okText: '確認',
                cancelText: '取消',
                onOk: () => {
                    this.enrollStudents();
                },
            });
        },
        enrollStudents(){
             this.$inertia.post(route('admin.klassStudentEnroll.enrollStudents'),
                {  yearCode:this.yearCode,
                    klassId:this.klassId,
                    passStudents:this.passStudents
                },{
                    preserveScroll:true,
                    preserveState:true,
                    onSuccess:(page)=>{}
            })
        },
        studentFinder(){
            this.$inertia.post(route('admin.klassStudentEnroll.studentFinder'),
                {yearCode:this.yearCode,
                    klassId:this.klassId,
                    text:this.text
                },{
                    preserveScroll:true,
                    preserveState:true,
                    onSuccess:(page)=>{
                        this.students=page.props.data.students
                        this.noFoundCodes=page.props.data.noFoundCodes
                    }
            })
        }
    },
    computed:{
        canEnroll() {
            return this.passStudents.length > 0 && this.klassId !== null;
        },
        existStudents(){
            return this.students.filter(x=>x.klasses.length>0)
        },
        passStudents(){
            return this.students.filter(x=>x.klasses.length==0)
        }
    }
}
</script>