<template>
<AdminLayout>
    <div>
        <div class="bg-white py-3 shadow-sm">
            <div class="container mx-auto px-6">
                <div class="flex items-center justify-between">
                    <div class="flex items-center">
                        <div class="flex items-center cursor-pointer" @click="currentSection = 1">
                            <div class="w-8 h-8 rounded-full flex items-center justify-center text-white" :class="currentSection >= 1 ? 'bg-indigo-600' : 'bg-gray-300'">
                                1
                            </div>
                            <div class="ml-2 font-medium" :class="currentSection === 1 ? 'text-indigo-700' : 'text-gray-600'">
                                选择班级
                            </div>
                        </div>

                        <div class="mx-4 w-16 h-1 rounded bg-gray-200"></div>

                        <div class="flex items-center cursor-pointer" @click="currentSection = 2" :class="{'opacity-50': !selectedKlass}">
                            <div class="w-8 h-8 rounded-full flex items-center justify-center text-white" :class="currentSection >= 2 && selectedKlass ? 'bg-indigo-600' : 'bg-gray-300'">
                                2
                            </div>
                            <div class="ml-2 font-medium" :class="currentSection === 2 && selectedKlass ? 'text-indigo-700' : 'text-gray-600'">
                                选择科目
                            </div>
                        </div>

                        <div class="mx-4 w-16 h-1 rounded bg-gray-200"></div>

                        <div class="flex items-center cursor-pointer" @click="currentSection = 3" :class="{'opacity-50': !selectedCourse}">
                            <div class="w-8 h-8 rounded-full flex items-center justify-center text-white" :class="currentSection >= 3 && selectedCourse ? 'bg-indigo-600' : 'bg-gray-300'">
                                3
                            </div>
                            <div class="ml-2 font-medium" :class="currentSection === 3 && selectedCourse ? 'text-indigo-700' : 'text-gray-600'">
                                管理细项
                            </div>
                        </div>
                    </div>

                    <div class="flex space-x-3">
                        <button class="px-4 py-2 bg-gray-100 text-gray-700 rounded-lg hover:bg-gray-200 transition flex items-center">
                            <i class="fas fa-sync-alt mr-2"></i> 重置
                        </button>
                        <button class="px-4 py-2 bg-green-600 text-white rounded-lg hover:bg-green-700 transition flex items-center">
                            <SaveOutlined class="mr-2"/> 保存更改
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- 主要内容区 - 横向布局 -->
        <div class="flex-1 bg-gray-100">
            <div class="container mx-auto px-2 py-2 h-full">
                <div class="bg-white rounded-xl shadow-lg h-full overflow-hidden">
                    <div class="horizontal-container grid grid-cols-4">
                        
                        <!-- 班级选择区 -->
                        <div class="section-container " :class="{'active-section': currentSection === 1}">
                            <div class="p-6 h-full flex flex-col">
                                <h2 class="text-xl font-bold text-gray-800 mb-4 flex items-center">
                                    <SearchOutlined class="mr-2 text-indigo-600"/> 选择班级
                                    <!-- <span class="ml-auto text-sm text-gray-500">{{ classes.length }} 班级</span> -->
                                </h2>

                                <div class="mb-4 ">
                                    <div class="relative">
                                        <input type="text" placeholder="搜索班级..." class="w-full pl-10 pr-4 py-2 rounded-lg border border-gray-300 focus:outline-none focus:ring-2 focus:ring-indigo-300">
                                        <SearchOutlined class="absolute left-3 top-3 text-gray-400"/>
                                    </div>
                                </div>

                                <div class="flex-1 overflow-y-auto custom-scrollbar">
                                    <div v-for="kls in klasses" :key="kls.id" @click="selectKlass(kls)" class="mx-1 px-2 py-3 mb-3 rounded-lg border cursor-pointer transition-all hover:shadow-md" :class="{
                                        'border-indigo-500 bg-indigo-50': selectedKlass && selectedKlass.id === kls.id,
                                        'border-gray-200': !selectedKlass || selectedKlass.id !== kls.id
                                    }">
                                        <div class="flex items-start">
                                            <div class="ml-3 flex-1">
                                                <div class="font-bold text-gray-800">{{ kls.tag }}</div>
                                            </div>
                                            <div class="text-xs bg-indigo-100 text-indigo-700 rounded-full px-2 py-1">
                                                <!-- {{ kls.subjects.length }}科目 -->
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- 科目选择区 -->
                        <div class="section-container" :class="{'active-section': currentSection === 2}" v-if="selectedKlass">
                            <div class="p-6 h-full flex flex-col">
                                <h2 class="text-xl font-bold text-gray-800 mb-4 flex items-center">
                                    <BookOutlined  class="mr-2 text-indigo-600"/> 选择科目
                                    <!-- <span class="ml-auto text-sm text-gray-500">{{ selectedKlass.subjects.length }} 科目</span> -->
                                </h2>

                                <div class="flex-1 overflow-y-auto ">
                                    <div v-for="course in courses" :key="course.id" @click="selectCourse(course)" 
                                        class="mx-1 px-2 py-3 mb-3 rounded-lg border cursor-pointer transition-all hover:shadow-md course-item" :class="{
                                        'border-indigo-500 bg-indigo-50': selectedCourse && selectedCourse.id === course.id,
                                        'border-gray-200': !selectedCourse || selectedCourse.id !== course.id
                                    }">
                                        <div class="flex items-center ">
                                            <div class="ml-3 flex-1">
                                                <div class="font-bold text-gray-800">
                                                    {{ course.study_subject.subject.code }}
                                                    &nbsp; 
                                                    {{ course.study_subject.subject.title_zh }}
                                                </div>
                                                <!-- <div class="text-sm text-gray-600 mt-1">{{ course.teacher }} | {{ course.items.length }}个细项</div> -->
                                            </div>
                                            <div class="subject-actions opacity-0 transition-opacity flex space-x-1">
                                                <button class="w-7 h-7 rounded-full bg-blue-100 text-blue-600 hover:bg-blue-200 flex items-center justify-center">
                                                    <CaretRightOutlined />
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- 管理细项 -->
                        <div class="section-container col-span-2" :class="{'active-section': currentSection === 3}" v-if="selectedCourse">
                            <div class="p-6 h-full flex flex-col">
                                <h2 class="text-xl font-bold text-gray-800 mb-4 flex items-center">
                                    <MenuUnfoldOutlined class="mr-2 text-indigo-600"/> 管理細項
                                    <!-- <span class="ml-auto text-sm text-gray-500">{{ selectedCourse.items.length }} 细项</span> -->
                                </h2>


                                <!-- 添加新细项 -->
                                <div class="mb-4">
                                    <div class="flex flex-col bg-slate-200/75 px-2 pt-2 rounded-lg shadow-md">
                                        <div class="text-base font-semibold text-gray-700 mx-4 flex items-center gap-1">添加新細項 <PlusOutlined /></div>
                                        <a-divider class="m-2"/>
                                        <a-form class="grid grid-cols-2" :model="newScoreColumn" :label-col="{ span: 8 }" :wrapper-col="{ span: 16 }" autocomplete="off" @finish="addScoreColumn">
                                            <a-form-item label="代號" name="column_letter"  >
                                                <a-input type="text" v-model:value="newScoreColumn.column_letter" :disabled="true" placeholder="自動生成" class="flex-1 px-4 py-2 rounded-l-lg border border-gray-300 focus:outline-none focus:ring-2 focus:ring-indigo-300" />
                                            </a-form-item>
                                            <a-form-item label="序號" name="sequence"  >
                                                <a-input type="text" v-model:value="newScoreColumn.sequence" placeholder="輸入排列序號" class="flex-1 px-4 py-2 rounded-l-lg border border-gray-300 focus:outline-none focus:ring-2 focus:ring-indigo-300" />
                                            </a-form-item>
                                            <a-form-item label="學分欄名稱" name="field_label" :rules="[{ required: true, message: '請輸入學分欄名稱' }]" >
                                                <a-input type="text" v-model:value="newScoreColumn.field_label" placeholder="輸入學分欄名稱" class="flex-1 px-4 py-2 rounded-l-lg border border-gray-300 focus:outline-none focus:ring-2 focus:ring-indigo-300" />
                                            </a-form-item>
                                            <a-form-item label="學段" name="term_id" >
                                                <a-select v-model:value="newScoreColumn.term_id" placeholder="選擇學段" :options="terms" class="focus:outline-none focus:ring-2 focus:ring-indigo-300"></a-select>
                                            </a-form-item>
                                            <a-form-item label="計算公式" name="formular" >
                                                <a-input type="text" v-model:value="newScoreColumn.formular" placeholder="輸入計算公式" class="flex-1 px-4 py-2 rounded-l-lg border border-gray-300 focus:outline-none focus:ring-2 focus:ring-indigo-300" />
                                            </a-form-item>
                                            <a-form-item label="簡介" name="description" >
                                                <a-input type="text" v-model:value="newScoreColumn.description" placeholder="輸入簡介" class="flex-1 px-4 py-2 rounded-l-lg border border-gray-300 focus:outline-none focus:ring-2 focus:ring-indigo-300" />
                                            </a-form-item>
                                            
                                            <a-form-item :wrapper-col="{ offset: 8, span: 16 }">
                                                <a-button type="primary" html-type="submit">提交</a-button>
                                            </a-form-item>
                                        </a-form>
                                    </div>
                                </div>

                                <!-- 细项列表 -->
                                <div class="flex-1 overflow-y-auto">    
                                    <div v-for="(scoreColumn, index) in selectedCourse.scoreColumns" :key="index" class="mx-1 px-2 py-3 mb-3 rounded-lg border border-gray-200 bg-white"
                                        :class="{'!bg-green-300':scoreColumn.inserted}">
                                        <div class="flex items-center px-4">
                                            <div class="flex-1">
                                                <div :class="{'line-through text-gray-400': scoreColumn.completed}" class="font-medium">
                                                    ( {{ scoreColumn.column_letter }} ) {{ scoreColumn.field_label }}
                                                </div>
                                            </div>
                                            <div class="flex space-x-1">
                                                <button @click.stop="editItem(index)" class="w-7 h-7 rounded-full bg-blue-100 text-blue-600 hover:bg-blue-200 flex items-center justify-center">
                                                    <EditOutlined />
                                                </button>
                                                <button @click.stop="deleteItem(index)" class="w-7 h-7 rounded-full bg-red-100 text-red-600 hover:bg-red-200 flex items-center justify-center">
                                                    <DeleteOutlined />
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 底部统计信息 -->
        <footer class="bg-white border-t py-3">
            <div class="container mx-auto px-6">
                <div class="flex justify-between items-center">
                    <div class="text-sm text-gray-600">
                        <i class="far fa-copyright mr-1"></i> 2023 班级管理系统
                    </div>
                    <div class="flex space-x-6">
                        <div class="text-sm">
                            <span class="text-gray-600">班级:</span>
                            <!-- <span class="font-medium ml-1">{{ classes.length }}</span> -->
                        </div>
                        <div class="text-sm">
                            <span class="text-gray-600">科目:</span>
                            <!-- <span class="font-medium ml-1">{{ totalSubjects }}</span> -->
                        </div>
                        <div class="text-sm">
                            <span class="text-gray-600">细项:</span>
                            <!-- <span class="font-medium ml-1">{{ totalItems }}</span> -->
                        </div>
                    </div>
                </div>
            </div>
        </footer>
    </div>
</AdminLayout>
</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import * as AntdIcons from '@ant-design/icons-vue';
export default {
    components: {
        AdminLayout,
        ...AntdIcons,
    },
    props: ['terms', 'klasses'],
    data() {
        return {
            courses:[],
            currentSection: 1,
            selectedKlass: null,
            selectedCourse: null,
            newScoreColumn: {},
        }
    },
    computed: {
    },
    methods: {
        selectKlass(cls) {
            this.selectedKlass = cls;
            this.selectedCourse = null;
            this.currentSection = 2;
            
            axios.get(route('director.klass.courses',{klass:this.selectedKlass.id}))
                .then(res=>{
                    console.log(res.data)
                    this.courses = res.data
                })
                .catch(err=>{
                    console.log(err);
                })
        },
        selectCourse(course) {
            this.selectedCourse = course;
            this.currentSection = 3;
            
            axios.get(route('director.course.getScoreColumns',{course:this.selectedCourse.id}))
                .then(res=>{
                    this.selectedCourse.scoreColumns = res.data
                })
                .catch(err=>{
                    console.log(err);
                })
        },
        addScoreColumn() {
            console.log( this.selectedCourse.scoreColumns)
            console.log( this.newScoreColumn)
            // this.selectedCourse.scoreColumns.push( this.newScoreColumn )
            // return 
        
            
            this.$inertia.post(route("director.course.scoreColumns.store",this.selectedCourse), this.newScoreColumn, {
                preserveScroll: true,
                preserveState: true,
                onSuccess: (page) => {
                    
                    let insert_score_column_id = page.props.data.id

                    //Refresh updated course score
                    this.selectCourse( this.selectedCourse )
                    this.newScoreColumn = {}

                    // 成功顯示
                    setTimeout(() => {
                        let record = this.selectedCourse.scoreColumns.find( x => x.id == insert_score_column_id)
                        if( record ){
                            record.inserted = true
                        }
                        
                    }, 500); 
                },
                onError: (error) => {
                }
            });
        },
        deleteItem(index) {
            this.selectedCourse.items.splice(index, 1);
        }
    }
}
</script>

<style>
.horizontal-container {
    /* display: flex; */
    height: calc(100vh - 120px);
    overflow-x: auto;
    overflow-y: hidden;
    scroll-behavior: smooth;
}

.section-container {
    @apply border-r-2 border-slate-200 overflow-auto;
    transition: all 0.3s ease;
}

.section-container:hover {
    box-shadow: 0 0 15px rgba(99, 102, 241, 0.1);
}

.active-section {
    @apply bg-blue-50/50;
    /* background-color: #f0f9ff; */
    border-left: 2px solid #3b82f6;
}

.course-item:hover .subject-actions {
    opacity: 1;
}

</style>
