<template>
<AdminLayout>
    {{ klasses[0] }}
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
                    <div class="horizontal-container">
                        
                        <!-- 班级选择区 -->
                        <div class="section-container" :class="{'active-section': currentSection === 1}">
                            <div class="p-6 h-full flex flex-col">
                                <h2 class="text-xl font-bold text-gray-800 mb-4 flex items-center">
                                    <SearchOutlined class="mr-2 text-indigo-600"/> 选择班级
                                    <span class="ml-auto text-sm text-gray-500">{{ classes.length }} 班级</span>
                                </h2>

                                <div class="mb-4 ">
                                    <div class="relative">
                                        <input type="text" placeholder="搜索班级..." class="w-full pl-10 pr-4 py-2 rounded-lg border border-gray-300 focus:outline-none focus:ring-2 focus:ring-indigo-300">
                                        <SearchOutlined class="absolute left-3 top-3 text-gray-400"/>
                                    </div>
                                </div>

                                <div class="flex-1 overflow-y-auto custom-scrollbar">
                                    <div v-for="kls in klasses" :key="kls.id" @click="selectClass(kls)" class="mx-1 px-2 py-3 mb-3 rounded-lg border cursor-pointer transition-all hover:shadow-md" :class="{
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
                                    <BookOutlined  class="text-indigo-600"/> 选择科目
                                    <!-- <span class="ml-auto text-sm text-gray-500">{{ selectedKlass.subjects.length }} 科目</span> -->
                                </h2>

                                <div class="flex-1 overflow-y-auto ">
                                    <div v-for="course in courses.filter( x => x.klass_id == selectedKlass.id)" :key="course.id" @click="selectCourse(course)" 
                                        class="p-2 mb-3 rounded-lg border cursor-pointer transition-all hover:shadow-md course-item" :class="{
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
                        
                        <!-- 科目细项 -->
                        <div class="section-container" :class="{'active-section': currentSection === 3}" v-if="selectedCourse">
                            <div class="p-6 h-full flex flex-col">
                                <h2 class="text-xl font-bold text-gray-800 mb-4 flex items-center">
                                    <MenuUnfoldOutlined class="text-indigo-600"/> 管理细项
                                    <!-- <span class="ml-auto text-sm text-gray-500">{{ selectedCourse.items.length }} 细项</span> -->
                                </h2>


                                <!-- 添加新细项 -->
                                <div class="mb-4">
                                    <h3 class="font-medium text-gray-700 mb-2">添加新细项</h3>
                                    <div class="flex">
                                        <input type="text" v-model="newItemName" placeholder="输入细项名称..." class="flex-1 px-4 py-2 rounded-l-lg border border-gray-300 focus:outline-none focus:ring-2 focus:ring-indigo-300">
                                        <button @click="addItem" class="px-4 bg-indigo-600 text-white rounded-r-lg hover:bg-indigo-700 transition disabled:opacity-50" :disabled="!newItemName.trim()">
                                            <PlusOutlined />
                                        </button>
                                    </div>
                                </div>

                                <!-- 细项列表 -->
                                <div class="flex-1 overflow-y-auto">

                                    <div v-for="(scoreColumn, index) in selectedCourse.scoreColumns" :key="index" class="p-4 mb-3 rounded-lg border border-gray-200 bg-white">
                                        <div class="flex items-start">
                                            <div class="mr-3 mt-1">
                                                <input type="checkbox" v-model="scoreColumn.completed" class="h-5 w-5 text-indigo-600 rounded focus:ring-indigo-500">
                                            </div>
                                            <div class="flex-1">
                                                <div :class="{'line-through text-gray-400': scoreColumn.completed}" class="font-medium">
                                                    {{ scoreColumn.column_letter }} {{ scoreColumn.field_label }}                                                    {{ scoreColumn.field_label }}
                                                </div>
                                                <div class="text-xs text-gray-500 mt-1">
                                                    <i class="far fa-calendar mr-1"></i> {{ scoreColumn.dueDate || '无截止日期' }}
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

                                <!-- 统计信息 -->
                                <div class="pt-4 border-t mt-4">
                                    <div class="flex justify-between text-sm">
                                        <div>
                                            <span class="text-gray-600">总细项:</span>
                                            <!-- <span class="font-medium ml-1">{{ selectedCourse.items.length }}</span> -->
                                        </div>
                                        <div>
                                            <span class="text-gray-600">已完成:</span>
                                            <span class="font-medium ml-1 text-green-600">
                                                {{ completedItemsCount }} ({{ completedPercentage }}%)
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- 完成状态提示 -->
                        <div class="flex-1 flex items-center justify-center" v-if="selectedCourse && currentSection === 3">
                            <div class="text-center max-w-md">
                                <div class="w-24 h-24 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-6">
                                    <i class="fas fa-check-circle text-4xl text-green-600"></i>
                                </div>
                                <h3 class="text-2xl font-bold text-gray-800 mb-2">细项管理完成</h3>
                                <p class="text-gray-600 mb-6">
                                    您已完成 {{ selectedCourse.name }} 科目的细项管理。
                                    当前完成率: <span class="font-bold text-green-600">{{ completedPercentage }}%</span>
                                </p>
                                <button class="px-6 py-3 bg-indigo-600 text-white rounded-lg hover:bg-indigo-700 transition">
                                    返回科目列表
                                </button>
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
                            <span class="font-medium ml-1">{{ classes.length }}</span>
                        </div>
                        <div class="text-sm">
                            <span class="text-gray-600">科目:</span>
                            <span class="font-medium ml-1">{{ totalSubjects }}</span>
                        </div>
                        <div class="text-sm">
                            <span class="text-gray-600">细项:</span>
                            <span class="font-medium ml-1">{{ totalItems }}</span>
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
    props: ['klasses', 'courses'],
    data() {
        return {
            currentSection: 1,
            classes: [{
                    id: 1,
                    name: '三年一班',
                    subjects: [{
                            id: 101,
                            name: '数学',
                            items: [{
                                    name: '代数基础',
                                    completed: false
                                },
                                {
                                    name: '几何概念',
                                    completed: true
                                },
                                {
                                    name: '概率统计',
                                    completed: false
                                }
                            ]
                        },
                        {
                            id: 102,
                            name: '语文',
                            items: [{
                                    name: '古诗词鉴赏',
                                    completed: true
                                },
                                {
                                    name: '现代文阅读',
                                    completed: false
                                }
                            ]
                        },
                        {
                            id: 103,
                            name: '英语',
                            items: [{
                                    name: '语法练习',
                                    completed: false
                                },
                                {
                                    name: '阅读理解',
                                    completed: false
                                },
                                {
                                    name: '口语训练',
                                    completed: true
                                }
                            ]
                        }
                    ]
                },
                {
                    id: 2,
                    name: '三年二班',
                    subjects: [{
                            id: 201,
                            name: '物理',
                            items: [{
                                    name: '力学实验',
                                    completed: true
                                },
                                {
                                    name: '电学基础',
                                    completed: false
                                }
                            ]
                        },
                        {
                            id: 202,
                            name: '化学',
                            items: [{
                                    name: '化学反应式',
                                    completed: false
                                },
                                {
                                    name: '实验安全',
                                    completed: true
                                }
                            ]
                        }
                    ]
                },
                {
                    id: 3,
                    name: '三年三班',
                    subjects: [{
                            id: 301,
                            name: '生物',
                            items: [{
                                    name: '细胞结构',
                                    completed: true
                                },
                                {
                                    name: '遗传学基础',
                                    completed: false
                                }
                            ]
                        },
                        {
                            id: 302,
                            name: '历史',
                            items: [{
                                name: '中国古代史',
                                completed: false
                            }]
                        },
                        {
                            id: 303,
                            name: '地理',
                            items: [{
                                    name: '世界地理',
                                    completed: true
                                },
                                {
                                    name: '气候类型',
                                    completed: true
                                }
                            ]
                        }
                    ]
                }
            ],
            selectedKlass: null,
            selectedCourse: null,
            newItemName: ''
        }
    },
    computed: {
        totalSubjects() {
            return this.classes.reduce((total, cls) => total + cls.subjects.length, 0);
        },
        totalItems() {
            return this.classes.reduce((total, cls) => {
                return total + cls.subjects.reduce((subTotal, subject) => {
                    return subTotal + subject.items.length;
                }, 0);
            }, 0);
        }
    },
    methods: {
        selectClass(cls) {
            this.selectedKlass = cls;
            this.selectedCourse = null;
        },
        selectCourse(course) {
            this.selectedCourse = course;
            
            axios.get(route('director.scoreColumn.getCourseScoreColumn',{course:this.selectedCourse.id}))
                .then(res=>{
                    this.selectedCourse.scoreColumns = res.data
                })
                .catch(err=>{
                    console.log(err);
                })

        },
        addItem() {
            if (this.newItemName.trim()) {
                this.selectedCourse.items.push({
                    name: this.newItemName.trim(),
                    completed: false
                });
                this.newItemName = '';
            }
        },
        deleteItem(index) {
            this.selectedCourse.items.splice(index, 1);
        }
    }
}
</script>

<style>
.horizontal-container {
    display: flex;
    height: calc(100vh - 120px);
    overflow-x: auto;
    overflow-y: hidden;
    scroll-behavior: smooth;
}

.section-container {
    min-width: 360px;
    width: 360px;
    border-right: 1px solid #e5e7eb;
    transition: all 0.3s ease;
}

.section-container:hover {
    box-shadow: 0 0 15px rgba(99, 102, 241, 0.1);
}

.active-section {
    background-color: #f0f9ff;
    border-left: 4px solid #3b82f6;
}

.course-item:hover .subject-actions {
    opacity: 1;
}

</style>
