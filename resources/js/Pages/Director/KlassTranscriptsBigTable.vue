<template>
    <AdminLayout title="成績大表" :breadcrumb="breadcrumb">
        <a-button @click="migrateTranscripts" :disabled="klass.transcript_migrated == 9">
            <span v-if="klass.transcript_migrated == 1">重新轉換成績表分數</span>
            <span v-else>轉換成績表分數</span>
        </a-button>

        <div class="py-5">
            <KlassSelector routePath="director.klass.transcripts" :param="[]" :currentKlass="klass" />
        </div>
        <div class="py-12">
            <div class="mx-auto sm:px-6 lg:px-8">
                <div class="bg-white overflow-auto shadow-xl">
                    <table width="100%" border="1" id="bigTable">
                        <thead>
                            <tr>
                                <td rowspan="3">Student Name</td>
                                <td v-for="course in transcriptsScores['courses']" :colspan="course.score_columns.length" class="text-center">
                                    {{ course.title_zh }}
                                </td>
                                <td colspan="2">
                                    操行
                                </td>
                            </tr>
                            <tr>
                                <template v-for="course in transcriptsScores['courses']">
                                    <td v-for="term in year_terms" :colspan="3" class="text-center">
                                        {{ term.label }}
                                    </td>
                                    <td></td>
                                </template>
                                <td v-for="term in year_terms" rowspan="2" class="text-center">
                                    {{ term.label}}
                                </td>
                            </tr>
                            <tr>
                                <template v-for="course in transcriptsScores['courses']">
                                    <td v-for="column in course.score_columns"  class="text-center">
                                        {{ column.field_label }}
                                    </td>
                                </template>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="(student,ksid) in transcriptsScores['students']">
                                <td>{{ student.name_zh}}</td>
                                <template v-for="course in transcriptsScores['courses']">
                                    <td v-for="column in course.score_columns"  class="text-center">
                                        <span v-if="transcriptsScores['scores'][ksid][course.id]">
                                            <span v-if="transcriptsScores['scores'][ksid][course.id][column.id]==null">
                                                --
                                            </span>
                                            <span v-else>
                                                {{ transcriptsScores['scores'][ksid][course.id][column.id].point}}
                                            </span>
                                        </span>
                                    </td>
                                </template>
                                <template v-for="term in year_terms">
                                    <td>
                                        {{ transcriptsScores['behaviours'][ksid][term.value] }}
                                    </td>
                                </template>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

    </AdminLayout>
</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import ButtonLink from '@/Components/ButtonLink.vue';
import KlassSelector from '@/Components/KlassSelector.vue';

export default {
    components: {
        AdminLayout, ButtonLink, KlassSelector
    },
    props: ['year', 'klass','year_terms', 'transcriptsScores', 'students_courses_scores', 'courses', 'scores', 'behaviours'],
    data() {
        return {
            breadcrumb:[
                {label:"主控台", url:route('director.dashboard')},
                {label:"年級班別", url:route('director.grades.index',{'type':'secondary'})},
                {label:this.klass.tag+'年級' ,url:route('director.klasses.show', this.klass.id)},
                {label:'成績大表' ,url:null}
            ],
            columns: [
                {
                    title: 'Staff #',
                    dataIndex: 'staff_code',
                }, {
                    title: 'Name',
                    dataIndex: 'name_zh',
                }, {
                    title: 'Subject',
                    dataIndex: 'subject_ara',
                }, {
                    title: 'Courses',
                    dataIndex: 'courses',
                }, {
                    title: 'Operation',
                    dataIndex: 'operation',
                }
            ]
        }
    },
    mounted() {
    },

    methods: {
        migrateTranscripts() {
            if (this.klass.transcript_migrated == 1) {
                if (!confirm('成績表分數已經轉換，是不確定重新轉換？')) {
                    return false;
                }
            } else {
                if (!confirm('是不確定轉換成績表分數？')) {
                    return false;
                }
            }
            this.$inertia.get(route("director.klass.transcripts.migrate",this.klass.id), {
                onSuccess: (page) => {
                        this.modal.isOpen=false;
                        console.log('Cancelled')
                    },
                    onError: (error) => {
                        console.log(error);
                    }
            })
        },

    },
}
</script>

<style>
#bigTable,
#bigTable td,
#bigTable tr {
    border: 1px solid;
}
</style>