<template>
    <AdminLayout title="新增就診記錄" :breadcrumb="breadcrumb">
        <a-divider/>
        <a-row>
            <a-col :span="18">
                <a-card>
                    <a-form
                        :model="treatment"
                        layout="vertical"
                        name="Treatment"
                        ref="modalRef"
                        :rules="rules"
                        :validate-messages="validateMessages"
                        @finish="onFormSubmit"
                    >
                        <a-row :gutter="20">
                            <a-col :span="12">
                                <a-form-item label="姓名" name="patient_name" >
                                    <a-input v-model:value="treatment.patient_name" :readonly="this.treatment.student_id!=null"/>
                                </a-form-item>
                            </a-col>
                            <a-col :span="12">
                                <a-form-item label="性別" name="gender">
                                    <a-radio-group v-model:value="treatment.gender" button-style="solid" :disabled="this.treatment.student_id!=null" >
                                        <a-radio-button value="M" >男</a-radio-button>
                                        <a-radio-button value="F">女</a-radio-button>
                                    </a-radio-group>
                                </a-form-item>
                            </a-col>
                        </a-row>
                        <a-row :gutter="20">
                            <a-col :span="12">
                                <a-form-item label="分類" name="category">
                                    <a-select v-model:value="treatment.category" :options="medicalTreatments"/>
                                </a-form-item>
                            </a-col>
                            <a-col :span="12">
                                <a-form-item label="日期" name="date">
                                    <a-date-picker v-model:value="treatment.date" :format="dateFormat" :valueFormat="dateFormat"/>
                                </a-form-item>
                            </a-col>
                        </a-row>
                        <a-form-item label="主題" name="title">
                            <a-input v-model:value="treatment.title"/>
                        </a-form-item>
                        <a-form-item label="診斷記錄" name="description">
                            <quill-editor
                                v-model:value="treatment.description"
                                style="min-height:200px"
                            />
                        </a-form-item>
                        <div>
                            <a-button type="default" html-type="submit">新增</a-button>
                        </div>
                    </a-form>
                    <a-divider/>
                    <p class="ant-descriptions-title">就診記錄</p>
                     <a-collapse>
                        <template v-for="treat in medicalRecord.treatments">
                            <a-collapse-panel :header="treat.title">
                                <template #extra>{{ treat.category }} @ {{ treat.date }}</template>
                                {{ treat.description }}
                            </a-collapse-panel>
                        </template>
                    </a-collapse>
                    <a-divider/>
                    <a-descriptions title="個人資訊" bordered>
                    <a-descriptions-item v-for="(health, field) in medicalRecord.healthcare" :label="field">{{health}}</a-descriptions-item>
                    </a-descriptions>
                </a-card>
            </a-col>
            <a-col :span="6">
                <a-card>
                    <div class="py-5">
                        <a-radio-group v-model:value="selectedGradeId" button-style="solid">
                            <template v-for="grade in grades">
                                <a-radio-button :value="grade.id">{{ grade.tag }}</a-radio-button>
                            </template>
                        </a-radio-group>
                        <a-divider/>
                        <a-radio-group v-model:value="selectedKlassId" button-style="solid" @change="onChangeKlass">
                            <template v-for="klass in grades.find(g=>g.id==selectedGradeId).klasses">
                                <a-radio-button :value="klass.id">{{ klass.tag }}</a-radio-button>
                            </template>
                        </a-radio-group>
                    </div>
                    <ol>
                        <li v-for="student in students" @click="onSelectStudent(student)">{{ student.pivot.student_number }} : {{ student.name_zh }}</li>
                    </ol>
                </a-card>
            </a-col>
        </a-row>

    </AdminLayout>
</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { affixProps } from 'ant-design-vue/lib/affix';
import dayjs from 'dayjs';
import { quillEditor } from 'vue3-quill';

export default {
    components: {
        AdminLayout,
        dayjs,
        quillEditor
    },
    props: ['grades','medicalTreatments'],
    data() {
        return {
            breadcrumb:[
                {label:"健康狀況" ,url:route('medical')},
                {label:"就診記錄" ,url:route('medical.treatments.index')},
                {label:"新增就診記錄" ,url:null},
            ],
            dateFormat: 'YYYY-MM-DD',
            treatment:{},
            // selectedGrade:{},
            // selectedKlass:{},
            selectedGradeId:0,
            selectedKlassId:0,
            students:{},
            medicalRecord:{},
            columns: [
                {
                    title: 'Student',
                    dataIndex: 'student_id',
                }, {
                    title: 'klass',
                    dataIndex: 'current_klass',
                }, {
                    title: 'Category',
                    dataIndex: 'category',
                }, {
                    title: '日期',
                    dataIndex: 'date',
                }, {
                    title: 'Title',
                    dataIndex: 'title',
                }, {
                    title: 'Operation',
                    dataIndex: 'operation',
                }
            ],
            rules:{
                patient_name:{required:true,},
                gender:{required:true,},
                date:{required:true,},
                category:{required:true,},
                title:{required:true,}
            },
            validateMessages:{
                required: '${label} is required!',
                types: {
                    email: '${label} is not a valid email!',
                    number: '${label} is not a valid number!',
                },
                number: {
                    range: '${label} must be between ${min} and ${max}',
                },
            },

        }
    },
    created() {
        //this.selectedGrade=this.grades.find(g=>g.grade_year==4)
        //this.selectedKlass=this.grades.find(g=>g.id==this.selectedGrade.id).klasses
        this.selectedGradeId=this.grades.find(g=>g.grade_year==4).id
        // this.selectedKlassId=this.grades.find(g=>g.id==this.selectedGradeId).klasses
    },
    mounted(){

    },
    methods: {
        createRecord(){
            
        },
        onSubmit(){

        },
        onChangeKlass(){
            axios.get(route('api.klassStudents',this.selectedKlassId))
                .then(resp=> {
                    this.students=resp.data.students;
                    }
                );
        },
        onSelectStudent(student){
            var selectedKlass=this.grades.find(g=>g.id==this.selectedGradeId).klasses.find(k=>k.id==this.selectedKlassId)
            this.treatment.student_id=student.id
            axios.get(route('api.studentMedicalRecords',student.id))
                .then(resp=> {
                    this.medicalRecord=resp.data
                    this.treatment.patient_name=this.medicalRecord.name_zh +" ,"+ selectedKlass.tag + " (" + student.pivot.student_number + ")"
                    this.treatment.gender=student.gender
                }
            );

        },
        onFormSubmit(){
            this.$inertia.post(route("medical.treatments.store"), this.treatment, {
                onSuccess: (page) => {
                    console.log(page);
                        console.log("approved")
                    },
                    onError: (error) => {
                        console.log(error);
                    }
            })

            console.log(this.treatment);
        },
        changeSelectedKlass(){
            console.log('klass changed');
        }
    },
}
</script>
