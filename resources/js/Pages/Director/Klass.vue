<template>
    <AdminLayout title="班別管理" :breadcrumb="breadcrumb">
        <!--  -->
        <div class="flex flex-wrap font-bold text-sm gap-1">
                <div class=" capsule-outline ">
                    <div class="capsule-label ">學年</div>
                    <div class=" "> 
                       {{ klass.grade.year.title }}    
                    </div>
                </div>
                <div class="capsule-outline">
                    <div class="capsule-label ">年級</div>
                    <div class=" ">{{ klass.grade.tag  }}</div>
                </div>
                <div class="capsule-outline">
                    <div class="capsule-label ">學段</div>
                    <div class=" ">{{ currentTerm.label  }}</div>
                </div>
                <div class="capsule-outline">
                    <div class="capsule-label ">學生人數</div>
                    <div class=" ">{{ klass.student_count  }}</div>
                </div>
                <div class="flex-1"></div>
            </div>
        <!--  -->

        <a-button as="link" :href="route('teacher.selected.students', {model:'klass',id:klass})" class="ant-btn">學生名單</a-button>
        <a-button as="link" :href="route('teacher.klass.avatars',klass.id)" class="ant-btn ant-btn-default">學生照片</a-button>
        <template v-if="klass.grade_year<=3">
            <!-- <a-button as="link" :href="route('director.klass.students.index', klass.id)" class="ant-btn">學生名單</a-button> -->
            <a-button as="link" :href="route('director.pre.klass.habits', klass.id)" class="ant-btn">生活習摜</a-button>
            <a-button as="link" :href="route('director.pre.klass.abilities', klass.id)" class="ant-btn">學習主題</a-button>
            <a-button as="link" :href="route('director.pre.klass.finalScores', klass.id)" class="ant-btn">期末成績</a-button>
        </template>
        <template v-else>
            <!-- <a-button as="link" :href="route('director.klass.students.index', klass.id)" class="ant-btn">學生名單</a-button> -->
            <a-button as="link" :href="route('teacher.klass.finalScores', klass.id)" class="ant-btn">期末成績</a-button>
            <a-button as="link" :href="route('director.klass.transcripts', {'klass':klass.id,'type':'summary'})" class="ant-btn">成績總表</a-button>
            <a-button as="link" :href="route('director.klass.transcripts', klass.id)" class="ant-btn">成績大表</a-button>
        </template>
        <a-divider type="vertical" />
            <a-button as="link" :href="route('teacher.selected.behaviours', {model:'klass',id:klass.id})" class="ant-btn">操行分數2</a-button>
            <a-button as="link" :href="route('director.klass.behaviours.index', klass.id)" class="ant-btn">操行分數</a-button>
            <a-button as="link" :href="route('director.klass.behaviour.adjust', klass.id)" class="ant-btn">操行調整</a-button>
        <a-divider type="vertical" />
        <template v-if="additiveStyle=='default'">
            <template v-for="group in additiveGroups">
                <a-button as="link" :href="route('director.klass.additive',[klass.id,group.category.toLowerCase()])" class="ant-btn">{{group.label}}</a-button>
            </template>
        </template>
        <template v-else-if="additiveStyle=='direct'">
            <a-button as="link" :href="route('director.klass.additive.direct', klass.id)" class="ant-btn">紀律行為</a-button>
        </template>
        <template v-else-if="additiveStyle=='page'">
            <a-button as="link" :href="route('director.klass.additive.page', klass.id)" class="ant-btn">紀律行為</a-button>
        </template>
        <a-divider type="vertical" />
        <a-button as="link" :href="route('director.klass.promotes.index',klass.id)" class="ant-btn">升留班預處理</a-button>

        <p>&nbsp;</p>

        <div class="relative overflow-x-auto">
            <table class="w-full text-sm text-left rtl:text-right text-gray-500 ">
                <thead class="text-xs text-gray-700 uppercase bg-gray-50 ">
                    <tr>
                        <th scope="col" class="px-6 py-3">科目代號</th>
                        <th scope="col" class="px-6 py-3">科目名稱</th>
                        <th scope="col" class="px-6 py-3">專業方向</th>
                        <th scope="col" class="px-6 py-3">選修／必修</th>
                        <th scope="col" class="px-6 py-3">科目單位</th>
                        <th scope="col" class="px-6 py-3">班主任</th>
                        <th scope="col" class="px-6 py-3">任教老師</th>
                        <th scope="col" class="px-6 py-3">現學段</th>
                        <th scope="col" class="px-6 py-3">操作</th>
                    </tr>
                </thead>
                <tbody>
                    <template v-for="(course, courseKey) in klass.courses" :course_id="course.id">
                        <tr class="bg-white ">
                            <!-- {{ course }} -->
                            <td class="px-6 py-4">{{ course.code }}</td>
                            <td class="px-6 py-4">{{ course.title_zh }}</td>
                            <td class="px-6 py-4">{{ course.stream }}</td>
                            <td class="px-6 py-4">{{ course.elective }}</td>
                            <td class="px-6 py-4">{{ course.unit }}</td>
                            <td class="px-6 py-4">
                                <ol>
                                    <li v-for="staff in course.subject_heads">{{ staff.name_zh }}</li>
                                </ol>
                            </td>

                            <td class="px-6 py-4">
                                <div v-if="editingTeachingStaffs.course_id == course.id">
                                    <a-select  v-model:value="editingTeachingStaffs.staff_ids" class="!min-w-32 !w-64" placeholder="請選擇..."
                                        max-tag-count="responsive" :options="teachers" mode="multiple"
                                        :field-names="{ value: 'id', label: 'name_zh'  }"></a-select>
                                    <a-button class="bg-green-300" size="small" @click="saveTeachingStaffs">保存</a-button>    
                                    <a-button size="small" @click="editingCancel()">取消</a-button>    
                                </div>
                                <div class="flex gap-2 items-center " v-else>
                                    <!-- {{ course.staffs }} -->
                                    <div v-for="staff in course.staffs">{{ staff.name_zh }}</div>
                                    <a-button size="small" @click="editTeachingStaffs(course)">修改</a-button>
                                </div>
                            </td>
                            <td class="px-6 py-4">{{ course.current_term }}</td>
                            <th scope="col" class="px-6 py-3">
                                <a-button as="link" :href="route('teacher.course.scores.index', course.id)"
                                    class="ant-btn">學分</a-button>
                                <a-button as="link" :href="route('director.course.makeups', course.id)"
                                    class="ant-btn">補考</a-button>
                            </th>
                        </tr>
                    </template>
                </tbody>
            </table>
        </div>

    </AdminLayout>
</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';


export default {
    components: {
        AdminLayout
    },
    props: ['currentTerm','klass','additiveTemplates','additiveStyle','additiveGroups', 'teachers'],
    data() {
        return {
            breadcrumb:[
                {label:"主控台", url:route('director.dashboard')},
                {label:"年級班別", url:route('director.grades.index',{'type':'secondary'})},
                {label:this.klass.grade.initial+'年級' ,url:null},
            ],
            course: {},
            editingTeachingStaffs:{},
        }
    },
    mounted() {
        this.editingCancel()
    },
    methods: {
        showModal(){
            console.log('showmodal')
            this.modal.isOpen=true
        },
        editingCancel(){
            this.editingTeachingStaffs = {}
            this.editingTeachingStaffs.staff_ids = []
        },
        editTeachingStaffs(course){
            // Reset
            this.editingCancel()
            this.editingTeachingStaffs.staff_ids = course.staffs.map( x => x.id ) ?? []
            this.editingTeachingStaffs.course_id = course.id 
        },
        saveTeachingStaffs(){

            this.$inertia.post(route('director.courseStaff.store'), this.editingTeachingStaffs, {
                preserveScroll: true,
                preserveState: true,    
                onSuccess: (page) => {
                    this.editingCancel()
                },
                onError: (err) => {
                    this.editingCancel()
                }
            });
        },
        handleOk() {

        }
    },
}
</script>




