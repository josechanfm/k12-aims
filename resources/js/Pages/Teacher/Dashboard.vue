<template>
    <AdminLayout title="老師主控台">
        <div>
            <p>The collection of route "teacher" is for the general operation management such as serach and preview, which
                not included setup of year, class or subject etc.</p>
            <a-typography-title :level="4">{{ staff.name_zh }}</a-typography-title>
            <a-typography-title :level="4">任教科目</a-typography-title>
            <div class="ant-table">
                <div class="ant-table-container">
                    <div class="ant-table-content">
                        <table style="table-layout: auto;">
                            <thead class="ant-table-thead">
                                <tr>
                                    <th>班級代號</th>
                                    <th>科目名稱</th>
                                    <th>班主任</th>
                                    <th>科代表</th>
                                    <th>學生人數</th>
                                    <th>操作</th>
                                </tr>
                            </thead>
                            <tbody class="ant-table-tbody">
                                <template v-for="course in staff.courses">
                                <tr>
                                    <td>{{ course.klass.tag }}</td>
                                    <td>{{ course.code }}{{ course.title_zh }}</td>
                                    <td>
                                        <ol>
                                            <li v-for="head in course.klass.klass_heads">{{ head.name_zh }}</li>
                                        </ol>
                                    </td>
                                    <td>
                                        <ol>
                                            <li v-for="head in course.subject_heads">{{ head.name_zh }}</li>
                                        </ol>
                                    </td>
                                    <td>{{ course.student_count }}</td>
                                    <td>
                                        <inertia-link :href="route('teacher.course.behaviours.index',course.id)" class="ant-btn">操行</inertia-link>
                                        <inertia-link :href="route('director.course.scores.index',course.id)" class="ant-btn">學分</inertia-link>
                                        <a-button @click="course.operation=!course.operation">更多...</a-button>
                                    </td>
                                </tr>
                                <tr class="ant-table-expanded-row ant-table-expanded-row-level-1" :style="course.operation==true?'display:true':'display:none'">
                                    <td colspan="7" class="ant-table-cell text-right">
                                        <inertia-link :href="route('director.klass.students.index', course.klass.id)" class="ant-btn">學生名單</inertia-link>
                                        <inertia-link :href="route('director.klass.finalScores', course.klass.id)" class="ant-btn">期末成績</inertia-link>
                                        <inertia-link :href="route('director.klass.additive', [course.klass.id, 'attendance'])" class="ant-btn">考勤</inertia-link>
                                        <inertia-link :href="route('director.klass.additive', [course.klass.id, 'perform'])" class="ant-btn">功過</inertia-link>
                                        <inertia-link :href="route('director.klass.additive', [course.klass.id, 'conduct'])" class="ant-btn">操行</inertia-link>
                                        <inertia-link :href="route('director.klass.additive', [course.klass.id, 'comments'])" class="ant-btn">評語</inertia-link>
                                    </td>
                                </tr>
                                </template>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <a-divider/>
            <a-typography-title :level="4">班主任</a-typography-title>
            <div class="ant-table">
                <div class="ant-table-container">
                    <div class="ant-table-content">
                        <table style="table-layout: auto;">
                            <thead class="ant-table-thead">
                                <tr>
                                    <th>班級代號</th>
                                    <th>學生人數</th>
                                    <th>班主任</th>
                                    <th>科目數</th>
                                    <th>操作</th>
                                </tr>
                            </thead>
                            <tbody class="ant-table-tbody">
                                <template v-for="klass in staff.headKlasses">
                                <tr>
                                    <td>{{ klass.tag }}</td>
                                    <td>{{ klass.student_count}}</td>
                                    <td>
                                        <ol>
                                            <li v-for="staff in klass.klass_heads">
                                                {{staff.name_zh}}
                                            </li>
                                        </ol>
                                    </td>
                                    <td>{{ klass.course_count}}</td>
                                    <td>
                                        <template v-if="klassHeadBehaviour">
                                            <inertia-link :href="route('teacher.klass.behaviours',klass.id)" class="ant-btn">操行</inertia-link>
                                        </template>
                                    </td>
                                </tr>
                                </template>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <a-divider/>
            <a-typography-title :level="4">科代表</a-typography-title>
            <div class="ant-table">
                <div class="ant-table-container">
                    <div class="ant-table-content">
                        <table style="table-layout: auto;">
                            <thead class="ant-table-thead">
                                <tr>
                                    <th>班級代號</th>
                                    <th>科目名稱</th>
                                    <th>學生人數</th>
                                    <th>班主任</th>
                                    <th>任教老師</th>
                                    <th>操作</th>
                                </tr>
                            </thead>
                            <tbody class="ant-table-tbody">
                                <template v-for="course in staff.headSubjects">
                                <tr>
                                    <td>{{ course.klass.tag }}</td>
                                    <td>{{ course.code }} {{ course.title_zh }}</td>
                                    <td>{{ course.student_count }}</td>
                                    <td>
                                        <ol>
                                            <li v-for="staff in course.klass.klass_heads">
                                                {{staff.name_zh}}
                                            </li>
                                        </ol>
                                    </td>
                                    <td>
                                        <ol>
                                            <li v-for="staff in course.teaching">
                                                {{staff.name_zh}}
                                            </li>
                                        </ol>
                                    </td>
                                    <td>
                                        {{ klassHeadBehaviour }}
                                        <template v-if="klassHeadBehaviour">
                                            <inertia-link :href="route('teacher.klass.behaviours',course.klass.id)" class="ant-btn">操行</inertia-link>
                                        </template>
                                    </td>
                                </tr>
                                </template>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            
        </div>
    </AdminLayout>
</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';

export default {
    components: {
        AdminLayout
    },
    props: ['klassHeadBehaviour','subjectHeadBehaviour','staff'],
    data() {
        return {
            columns: [
                {
                    title: '班級代號',
                    dataIndex: 'klass_tag',
                }, {
                    title: '科目名稱',
                    dataIndex: 'course_title',
                }, {
                    title: '班主任',
                    dataIndex: 'klass_heads',
                }, {
                    title: '科代表',
                    dataIndex: 'subject_heads',
                }, {
                    title: '學生人數',
                    dataIndex: 'student_count',
                }, {
                    title: '操作',
                    dataIndex: 'operation',
                }
            ]

        }
    },
    methods: {
        onClickShowExpended(course){
            course.operation=true;
            console.log(course);
        }
    },
}
</script>

