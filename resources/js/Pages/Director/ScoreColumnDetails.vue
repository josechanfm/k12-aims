<template>
<AdminLayout>
    <div class="bg-white rounded-lg shadow-md flex flex-col gap-4 pt-4 px-4">
        <div class="">
            
            <div class="flex justify-center">
                <div class="flex items-center ">
                    <div class="flex items-center" @click="currentSection = 1">
                        <div class="w-8 h-8 rounded-full flex items-center justify-center text-white" :class="currentSection >= 1 ? 'bg-indigo-600' : 'bg-gray-300'">
                            1
                        </div>
                        <div class="ml-2 font-medium" :class="currentSection === 1 ? 'text-indigo-700' : 'text-gray-600'">
                            選擇科目
                        </div>
                    </div>

                    <div class="mx-4 w-20 h-1 rounded bg-gray-200"></div>

                    <div class="flex items-center" @click="currentSection = 2" :class="{'opacity-50': !selectedSubject}">
                        <div class="w-8 h-8 rounded-full flex items-center justify-center text-white" :class="currentSection >= 2 && selectedKlass ? 'bg-indigo-600' : 'bg-gray-300'">
                            2
                        </div>
                        <div class="ml-2 font-medium" :class="currentSection === 2 && selectedKlass ? 'text-indigo-700' : 'text-gray-600'">
                            選擇班級
                        </div>
                    </div>

                    <div class="mx-4 w-20 h-1 rounded bg-gray-200"></div>

                    <div class="flex items-center" @click="currentSection = 3" :class="{'opacity-50': !selectedKlass}">
                        <div class="w-8 h-8 rounded-full flex items-center justify-center text-white" :class="currentSection >= 3 && selectedKlass ? 'bg-indigo-600' : 'bg-gray-300'">
                            3
                        </div>
                        <div class="ml-2 font-medium" :class="currentSection === 3 ? 'text-indigo-700' : 'text-gray-600'">
                            管理學分欄
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 主要内容区 - 横向布局 -->
        <div class="flex-1">
            <div class=" mx-auto py-2 h-full ">
                <div class="rounded-xl bg-gray-50 shadow-lg h-full border-gray-200 border-t-2 overflow-hidden">
                    <div class="horizontal-container grid grid-cols-4">
                        
                        <!-- 科目选择区 -->
                        <div class="section-container" :class="{'active-section': currentSection === 1}" >
                            <div class="p-6 h-full flex flex-col">
                                <h2 class="text-xl font-bold text-gray-800 mb-4 flex items-center">
                                    <BookOutlined  class="mr-2 text-indigo-600"/> 選擇科目
                                    <span class="ml-auto text-sm text-gray-500">{{ subjects.length }} 科目</span>
                                </h2>

                                <div class="flex-1 overflow-y-auto ">
                                    <div v-for="subject in subjects" :key="subject.id" @click="selectSubject(subject)" 
                                        class="mx-1 px-2 py-3 mb-3 rounded-lg border cursor-pointer transition-all hover:shadow-md course-item" :class="{
                                        'border-indigo-500 bg-indigo-50': selectedSubject && selectedSubject.id === subject.id,
                                        'border-gray-200': !selectedSubject || selectedSubject.id !== subject.id
                                    }">
                                        <div class="flex items-center ">
                                            <div class="ml-3 flex-1">
                                                <div class="font-bold text-gray-800">
                                                    {{ subject.code }}
                                                    &nbsp; 
                                                    {{ subject.title_zh }}
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

                        <!-- 班级选择区 -->
                        <div class="section-container " :class="{'active-section': currentSection === 2}" v-if="selectedSubject">
                            <div class="p-6 h-full flex flex-col">
                                <h2 class="text-xl font-bold text-gray-800 mb-4 flex items-center">
                                    <SearchOutlined class="mr-2 text-indigo-600"/> 选择班级
                                    <!-- <span class="ml-auto text-sm text-gray-500">{{ classes.length }} 班级</span> -->
                                </h2>
                                
                                <a-tabs v-model:activeKey="selectKlassTabKey" type="card" class="">
                                    <a-tab-pane :key="1" tab="按級" class="">
                                        <!-- 按級生成 -->
                                        <div v-for="(grade,key) in gradeKlass" :key="grade" @click="selectGrade(grade)" class="mx-1 px-2 py-3 mb-3 rounded-lg border cursor-pointer transition-all hover:shadow-md" :class="{
                                                'border-indigo-500 bg-indigo-50': selectedGrade && selectedGrade.includes( grade ),
                                                'border-gray-200': !selectedGrade || selectedGrade.includes( grade )
                                            }">
                                            <div class="flex items-start">
                                                <div class="ml-3 flex-1">
                                                    <div class="font-bold text-gray-800">{{ grades.find( x => x.id == grade )?.title_zh }}</div>
                                                </div>
                                                <div class="text-xs bg-indigo-100 text-indigo-700 rounded-full px-2 py-1">
                                                    <!-- {{ kls.subjects.length }}科目 -->
                                                </div>
                                            </div>
                                        </div>
                                    </a-tab-pane>
                                    <a-tab-pane :key="2" tab="按班" class="">
                                        <!-- 按班生成 -->
                                        <div class="mb-4 ">
                                            <div class="relative">
                                                <input type="text" placeholder="搜索班级..." class="w-full pl-10 pr-4 py-2 rounded-lg border border-gray-300 focus:outline-none focus:ring-2 focus:ring-indigo-300">
                                                <SearchOutlined class="absolute left-3 top-3 text-gray-400"/>
                                            </div>
                                        </div>
                                        <div class="flex-1 overflow-y-auto custom-scrollbar">
                                            <div v-for="kls in klasses" :key="kls.id" @click="selectKlass(kls)" class="mx-1 px-2 py-3 mb-3 rounded-lg border cursor-pointer transition-all hover:shadow-md" :class="{
                                                'border-indigo-500 bg-indigo-50': selectedKlass && selectedKlass.id == kls.id,
                                                'border-gray-200': !selectedKlass || selectedKlass.id == kls.id
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
                                    </a-tab-pane>
                                </a-tabs>

                            </div>
                        </div>
                        
                        <!-- 管理细项 -->
                        <div class="section-container col-span-2" :class="{'active-section': currentSection === 3}" v-if="selectedKlass || selectedGrade.length > 0">
                            <div class="p-6 h-full flex flex-col">
                                <h2 class="text-xl font-bold text-gray-800 mb-4 flex items-center">
                                    <MenuUnfoldOutlined class="mr-2 text-indigo-600"/> 管理細項
                                </h2>
                                <!-- 添加新细项 -->
                                <div class="mb-4">
                                    <div class="flex flex-col bg-slate-200/75 px-2 pt-2 rounded-lg shadow-md">
                                        <div class="text-base font-semibold text-gray-700 mx-4 flex items-center gap-1">
                                            <span v-if="selectKlassTabKey == '1'">批量添加新細項</span>
                                            <span v-else>添加 {{ selectedKlass.name_zh }} 新細項</span>
                                            <PlusOutlined />
                                        </div>
                                        <a-divider class="m-2"/>
                                        <a-form class="grid grid-cols-2" :model="newScoreColumn" :label-col="{ span: 8 }" :wrapper-col="{ span: 16 }" autocomplete="off" 
                                            @finish="submitScoreColumn">
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
                                <a-divider class="mt-1 mb-3"/>

                                <!-- 细项列表 -->
                                <div class="flex-1 overflow-y-auto">    
                                    <a-tabs v-model:activeKey="scoreColumnTabKey" type="card" class="rounded-lg bg-white shadow-md ">
                                        <a-tab-pane  v-for="term in terms" :key="term.value" :tab="term.label" class="">
                                            
                                            <div v-for="(scoreColumn, index) in scoreColumns?.filter( x => x.term_id == term.value)" :key="index" 
                                                class="mx-1 px-2 py-5 border-b border-gray-200 "
                                                :class="{'inserted':scoreColumn.inserted}">
                                                <div class="flex items-center px-4">
                                                    <div class="flex-1">
                                                        <div :class="{'line-through text-gray-400': scoreColumn.completed}" class="flex flex-col justify-center font-medium ">
                                                            <div>( {{ scoreColumn.column_letter }} ) {{ scoreColumn.field_label }}</div>
                                                            
                                                            <div class="w-full break-all text-xs px-2 text-gray-600 my-2">
                                                                <div v-if="selectKlassTabKey == '1'">
                                                                    {{ [...new Set(scoreColumn.course_id.map(c => selectedCourse.find(x => x.id == c)?.klass_name))].join(', ') }}
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="flex space-x-1">
                                                        <button @click.stop="editItem(index)" class="w-10 h-10 rounded-full bg-blue-100 text-blue-600 hover:bg-blue-200 flex items-center justify-center">
                                                            <EditOutlined />
                                                        </button>
                                                        <button @click.stop="deleteItem(index)" class="w-10 h-10 rounded-full bg-red-100 text-red-600 hover:bg-red-200 flex items-center justify-center">
                                                            <DeleteOutlined />
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </a-tab-pane>
                                    </a-tabs>
                                    
                                </div>
                            </div>
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
import * as AntdIcons from '@ant-design/icons-vue';
export default {
    components: {
        AdminLayout,
        ...AntdIcons,
    },
    props: ['terms', 'subjects', 'grades'],
    data() {
        return {
            
            klasses:[],
            currentSection: 1,
            scoreColumnTabKey: 1,
            selectKlassTabKey:1,

            selectedGrade: [],
            selectedSubject: null,
            selectedKlass: null,
            selectedCourse: null,
            scoreColumns: null,
            newScoreColumn: {},
        }
    },
    computed: {
        gradeKlass(){
            // 找到 klasses 並找到很哪些級
            return this.klasses.map(item => item.grade_id)
                .filter((gradeId, index, arr) => arr.indexOf(gradeId) === index);
        }
    },
    methods: {
        
        selectSubject(subject) {
            this.selectedSubject = subject;
            this.currentSection = 2;
            
            axios.get(route('director.course.scoreColumn.getKlassBySubject',{subject:this.selectedSubject.id}))
                .then(res=>{
                    this.klasses = res.data
                })
        },
        selectGrade( grade ){
            this.selectedGrade.push( grade )
            
            this.currentSection = 3
            
            // 整級
            axios.get(route('director.course.scoreColumn.getGradeScoreColumn',
                { subject: this.selectedSubject.id, grade: this.selectedGrade}
            ))
                .then(res=>{
                    this.scoreColumns = []
                    res.data.map( x => x.score_columns).forEach( (score_column) =>{
                        // 合併所有course的score column
                        this.scoreColumns = this.scoreColumns.concat( score_column ) 
                    })
                    this.selectedCourse = res.data
                    this.scoreColumns = this.filterGradeScoreColumn( this. scoreColumns)
                })
        },
        selectKlass(kls) {
            // 按班
            this.selectedKlass = kls 
            this.currentSection = 3
            
            axios.get(route('director.course.scoreColumn.getScoreColumn',
                {subject: this.selectedSubject.id, klass: this.selectedKlass.id}
            ))
                .then(res=>{
                    console.log( res.data )
                    this.selectedCourse = res.data
                    this.scoreColumns = res.data.score_columns
                })
        },
        filterGradeScoreColumn(arr){
            let merged = {};
    
            arr.forEach(obj => {
                let key = obj.column_letter;
                if (!merged[key]) {
                    merged[key] = {
                        ...obj,
                        id: [obj.id.toString()], // 将 id 转为字符串数组
                        course_id: [obj.course_id.toString()] // 将 course_id 转为字符串数组
                    };
                } else {
                    merged[key].id.push(obj.id.toString()); // 添加 id 到数组
                    merged[key].course_id.push(obj.course_id.toString()); // 添加 course_id 到数组
                    // 可以选择保留其他字段的最新值或其他逻辑
                    // 这里简单保留第一个对象的其他字段
                }
            });
            
            return Object.values(merged);
        },
        submitScoreColumn(){
            if(this.selectKlassTabKey == 1){
                this.addScoreColumnBatch()
            }else{
                this.addScoreColumn()
            }
        },
        addScoreColumnBatch(){
            this.newScoreColumn.course_ids = this.selectedCourse.map( x => x.id)
            this.$inertia.post(route("director.course.scoreColumns.batchStore"), this.newScoreColumn, {
                preserveScroll: true,
                preserveState: true,
                onSuccess: (page) => {

                },
            });
        },
        addScoreColumn() {
            
            this.$inertia.post(route("director.course.scoreColumns.store",this.selectedCourse), this.newScoreColumn, {
                preserveScroll: true,
                preserveState: true,
                onSuccess: (page) => {
                    let insert_score_column_id = page.props.data.id

                    //Refresh updated course score
                    this.selectKlass( this.selectedKlass )
                    this.newScoreColumn = {}

                    // 成功顯示
                    setTimeout(() => {
                        let record = this.scoreColumns.find( x => x.id == insert_score_column_id)
                        if( record ){ record.inserted = true }
                    }, 500); 
                },
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

.inserted{
    @apply bg-green-200;
}
</style>
