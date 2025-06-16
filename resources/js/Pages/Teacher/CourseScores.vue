<template>
<AdminLayout :title="course.klass.tag+'科學分管理'" :breadcrumb="breadcrumb">
    <div class="flex gap-1 flex-col">
        <div class="flex flex-col gap-1">
            <div class="flex gap-1">
                <div class="capsule-outline">
                    <div class="capsule-label">學段狀態</div>
                    <div class="">{{ showCurrentTerm() }}</div>
                </div>
                <div class="capsule-outline">
                    <div class="capsule-label">科組長</div>
                    <!-- <div class="">{{  course.subject_heads.map(x=>x.name_zh).join(',') }}</div> -->
                </div>
                <div class="capsule-outline">
                    <div class="capsule-label">任教老師</div>
                    <!-- <div class="">{{ course.staffs.map(x=>x.name_zh).join(',') }}</div> -->
                </div>
                <div class="flex-1"></div>
                <a-button as="link" :href="route('director.klasses.show', course.klass_id)" size="small" type="info" >返回{{course.klass.tag}}科目列表</a-button>
                <a-button size="small" type="info"  @click="formularVisable=!formularVisable">分數欄展開</a-button>
                <a-button size="small" type="secondary" @click="onClickAddScoreColumn" :disabled="disabledByTerm()">新增學分欄</a-button>
            </div>
            <!--  -->
            <div class="flex gap-1 items-center">
                <div class="capsule-outline">
                    <div class="capsule-label">選項</div>
                    <!-- <a-button  :key="9"  @click="selectedTerm = 9" size="small" >9</a-button> -->
                    <a-button  :key="term" v-for="term in yearTerms" @click="selectedTerm = term.value" size="small" :type="selectedTerm == term.value ? 'active' : 'list'">{{ term.label }}</a-button>
                </div>
            </div>
        </div>
    </div>
    <Transition>
        <div class="bg-white p-2 rounded-lg sticky top-1" v-if="formularVisable">
            <div class="flex">
                    <div class="flex-1"></div>
                    <div @click="formularVisable=false" class="text-red-500 p-1 font-black">close</div>
            </div>
            <div class="mx-auto ">
                <div class="border border-solid border-stone-400 rounded-lg overflow-hidden">
                    <table class="itxst border-collapse " component='VueDraggableNext' animation="500" force-fallback="true" width="100%">
                        <thead>
                            <tr>
                                <th width="20px"></th>
                                <th>代號</th>
                                <th>學段</th>
                                <th>學分欄名稱</th>
                                <th>計算方式</th>
                                <th>成績表分數</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <draggable tag="tbody" class=" list-group w-full" :list="scoreColumns" @change="rowChange">
                            <transition-group name="list" v-for="(record, idx) in scoreColumns" :key="record.id">
                                <tr v-if="record.term_id == selectedTerm">
                                    <td>
                                        <HolderOutlined class="font-black"/>
                                    </td>
                                    <td>{{ record.column_letter }}</td>
                                    <td>{{ yearTerms.find(t => t.value == record.term_id).label }}</td>
                                    <td>{{ record.field_label }}</td>
                                    <td>{{ record.formular }}</td>
                                    <td><span v-if="record.for_transcript">是</span></td>
                                    <td class="w-fit">
                                        <a-button @click="onClickEditScoreColumn(record)" :disabled="disabledByTerm()" size="small" type="edit" >修改</a-button>
                                        <span v-if="record.for_transcript == 0">
                                            <a-popconfirm title="是否確定刪除？刪除後不可返回。" ok-text="Yes" cancel-text="No" @confirm="onClickDeleteScoreColumn(record.id)">
                                                <a-button :disabled="disabledByTerm()">刪除</a-button>
                                            </a-popconfirm>
                                        </span>
                                    </td>
                                </tr>
                            </transition-group>
                        </draggable>
                    </table>
                    <p class="float-right pr-5 font-black">學年總分計算方式：{{ yearFinalFormular() }}</p>
                </div>
            </div>
        </div>
    </Transition>
    
    <div class="mx-auto flex flex-col gap-1 ">
        
        <ScoreTable :column="scoreColumns" :score="Object.values(studentsScores)" @store="storeAllScores"/>
        
        <div class="flex">   
            <a-button type="primary" @click="storeAllScores" :disabled="disabledByTerm()">更新並保存</a-button>
            <a-button @click="sampleData" :disabled="disabledByTerm()">Sample Data</a-button>
        </div>
            
        <div class="bg-white p-1 rounded-lg shadow-lg">
            <div class="border border-solid border-stone-400 rounded-lg overflow-hidden">
                <table id="dataTable" ref="dataTable">
                    <thead>
                        <tr>
                            <th>學生編號</th>
                            <th>學生姓名</th>
                            <template v-for="(column, idx) in scoreColumns">
                                <th v-if="column.term_id == selectedTerm">
                                    <span :title="column.formular">
                                        ( {{ column.column_letter }} ) {{ column.field_label }}
                                        <span v-if="column.formular">*</span>
                                    </span>
                                </th>
                            </template>
                            <th>全年總平均分</th>
                        </tr>
                    </thead>
                    <tbody>
                        <template v-for="(student, sid) in studentsScores">
                            <tr>
                                <td class="text-center">{{ student.student_number }}</td>
                                <td>{{ student.student_name }}</td>
                                <template v-for="column in scoreColumns">
                                    <template v-for="(score, cid) in student.scores">
                                        <td v-if="column.term_id == selectedTerm && column.id == cid" class="text-center">
                                            <span v-if="column.merge || column.formular">
                                                {{ score.point }}
                                            </span>
                                            <span v-else>
                                                <a-input v-if="!disabledByTerm()" v-model:value="score.point" @focus="score.old_point = score.point" @blur="onTimeUpdate(score)" @keyup.arrow-keys="onKeypressed" />
                                                <span v-else>
                                                    {{score.point}}
                                                </span>
                                            </span>

                                        </td>
                                    </template>
                                </template>
                                <template v-for="column in scoreColumns">
                                    <td :key="column" v-if="column.term_id == 9" class="text-center">{{ student.scores[column.id].point }}</td>
                                </template>
                            </tr>
                        </template>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <a-modal v-model:open="modal.isOpen" :title="modal.title" @ok="handleScoreColumnChange">
        <a-form :model="modal.data" name="course_score" ref="modalScoreColumn" @finish="onModalFinish" :label-col="{span:6}">
            <a-form-item label="學段" :name="['term_id']">
                <a-select v-model:value="modal.data.term_id" :options="yearTerms" :disabled="true" />
            </a-form-item>
            <a-form-item label="學分欄名稱 " :name="['field_label']" :rules="[{ required: true, message: 'Please input score column name' }]">
                <a-input v-model:value="modal.data.field_label" />
            </a-form-item>
            <a-form-item label="序號" :name="['sequence']">
                <a-input v-model:value="modal.data.sequence" />
            </a-form-item>
            <a-form-item label="計算公式" :name="['formular']">
                <a-input v-model:value="modal.data.formular" @change="() => { modal.data.formular = modal.data.formular.toUpperCase() }" />
            </a-form-item>
            <a-form-item label="簡介" :name="['description']">
                <a-input v-model:value="modal.data.description" />
            </a-form-item>

            <div v-if="modal.data.can_merge">
                <a-divider style="height: 2px; background-color: #7cb305" />

                <label>分數合計欄</label>
                <ol class="ml-5">
                    <li :key="idx" v-for="(item, idx) in modal.data.merge" class="list-disc">
                        <div class="flow-root">
                            {{ mergeItem(item) }}
                            <a @click="deleteMerge(idx)" class="float-right" v-if="$page.props.currentUserRoles.includes('admin')">
                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="red" class="w-4 h-4">
                                    <path stroke-linecap="round" stroke-linejoin="round" d="M14.74 9l-.346 9m-4.788 0L9.26 9m9.968-3.21c.342.052.682.107 1.022.166m-1.022-.165L18.16 19.673a2.25 2.25 0 01-2.244 2.077H8.084a2.25 2.25 0 01-2.244-2.077L4.772 5.79m14.456 0a48.108 48.108 0 00-3.478-.397m-12 .562c.34-.059.68-.114 1.022-.165m0 0a48.11 48.11 0 013.478-.397m7.5 0v-.916c0-1.18-.91-2.164-2.09-2.201a51.964 51.964 0 00-3.32 0c-1.18.037-2.09 1.022-2.09 2.201v.916m7.5 0a48.667 48.667 0 00-7.5 0" />
                                </svg>
                            </a>
                        </div>
                    </li>
                </ol>
                <a-collapse v-if="$page.props.currentUserRoles.includes('admin')">
                    <a-collapse-panel key="1" header="新增分數合計">
                        <a-form-item label="科目">
                            <a-select v-model:value="merge.course_id" :options="klassCourses.map(c => ({ value: c.id, label: c.code + '-' + c.title_zh }))" @change="onChangeMergeCourse"></a-select>
                        </a-form-item>
                        <a-form-item label="分數欄">
                            <a-select v-model:value="merge.score_column_id" :options="modal.data.scoreColumnOptions"></a-select>
                        </a-form-item>
                        <a-form-item label="比例">
                            <a-input v-model:value="merge.percentage" />
                            <span>(%，百份比)</span>
                        </a-form-item>
                        <a-button @click="addMerge">Add</a-button>
                    </a-collapse-panel>
                </a-collapse>

            </div>

        </a-form>
    </a-modal>
</AdminLayout>
</template>

<script>
import { ref, computed } from 'vue';
import AdminLayout from '@/Layouts/AdminLayout.vue';
import ScoreTable from '@/Components/ScoreTable.vue';
import {
    ContactsOutlined,HolderOutlined
} from '@ant-design/icons-vue';
import {
    defaultsDeep
} from 'lodash';
import {
    VueDraggableNext
} from 'vue-draggable-next'

export default {
    components: {
        ScoreTable,
        AdminLayout,HolderOutlined,
        draggable: VueDraggableNext,
    },
    props: ['yearTerms', 'course', 'scoreColumns', 'studentsScores', 'klassCourses'],
    data() {
        return {
            formularVisable:false,
            breadcrumb: [{
                    label: "主控台",
                    url: route('director.dashboard')
                },
                {
                    label: "年級班別",
                    url: route('director.grades.index', {
                        'type': 'secondary'
                    })
                },
                {
                    label: this.course.klass.tag + '科學分管理',
                    url: null
                },
            ],
            merge: {
                course_id: null,
                score_column_id: null,
                percentage: null,
            },
            selectedTerm: 1,
            keypressed: "",
            modal: {
                mode: null,
                isOpen: false,
                title: 'Score Column',
                data: {}
            },
            tableCell: {
                row: 0,
                col: 0,
                maxRow: this.studentsScores.length,
                maxCol: this.scoreColumns.length
            },
            scores: [],
            columns: [{
                title: 'Lette',
                dataIndex: 'letter',
            }, {
                title: '學段',
                dataIndex: 'term_id',
            }, {
                title: '學分欄名稱',
                dataIndex: 'field_label',
            }, {
                title: '分類',
                dataIndex: 'type',
            }, {
                title: '計算方式',
                dataIndex: 'formular',
            }, {
                title: '排序',
                dataIndex: 'sequence',
            }, {
                title: '操作',
                dataIndex: 'operation',
            }]

        }
    },
    created() {

    },
    mounted() {
        window.a=this
        //add Click EventListenter to dataTable
        this.$refs.dataTable.addEventListener('click', (e) => {
            this.tableCell.row = e.target.closest('tr')?.rowIndex??0;
            this.tableCell.col = e.target.closest('td')?.cellIndex??0;
        })
        //add KeyDown (ArrowKeys) EventListenter to dataTable
        this.$refs.dataTable.addEventListener('keydown', (e) => {
            let isActive= ['ArrowUp','ArrowDown','ArrowLeft','ArrowRight','Enter'].includes(e.key)
            switch (e.key) {
                case 'ArrowUp':
                    this.tableCell.row > 1 ? this.tableCell.row-- : '';
                    break;
                case 'ArrowDown':
                    this.tableCell.row < (this.$refs.dataTable.rows.length - 1) ? this.tableCell.row++ : '';
                    //this.tableCell.row<this.tableCell.maxRow?this.tableCell.row++:'';
                    break;
                case 'ArrowLeft':
                    this.tableCell.col > 1 ? this.tableCell.col-- : '';
                    break;
                case 'ArrowRight':
                    this.tableCell.col < (this.$refs.dataTable.rows[0].cells.length - 1) ? this.tableCell.col++ : '';
                    break;
                case 'Enter':
                    this.tableCell.row < (this.$refs.dataTable.rows.length - 1) ? this.tableCell.row++ : '';
                    break;
            }
            let inputElements= this.$refs.dataTable.rows[this.tableCell.row]
            let tdElements=inputElements.getElementsByTagName("td")
            let isInput=tdElements[ this.tableCell.col]?.children[0]?.children[0]?.tagName??'--'=="INPUT"
            if(!isInput){
                this.tableCell?(e.key=="ArrowLeft"? this.tableCell.col++:this.tableCell.col--):''
            }
            var input = this.$refs.dataTable.rows[this.tableCell.row].cells[this.tableCell.col].getElementsByTagName("input");
            if (input.length > 0 && isActive) {
                setTimeout(_=>{  input[0].select();},10) 
            }
        })
    },
    methods: {
        onTimeUpdate(score){
            if(score.old_point===undefined|| score.old_point!=score.point){
                this.storeAllScores()
            }
        },
        onKeypressed(event) {
            this.keypressed = event.keyCode;
        },
        onClickAddScoreColumn() {
            this.modal.data = {};
            this.modal.data.course_id = this.course.id;
            this.modal.data.type = 'SUB';
            this.modal.data.term_id = this.selectedTerm;
            this.modal.data.merge = null;
            this.modal.title = "Add Score Column";
            this.modal.mode = 'ADD';
            this.modal.isOpen = true;
        },
        onClickEditScoreColumn(record) {
            this.modal.data = record;
            if (record.merge == null || record.merge == '') {
                // merge default
                this.modal.data.merge = null;
            } else if (!Array.isArray(record.merge)) {
                this.modal.data.merge = record.merge;
            }
            this.modal.title = "Edit Score Column";
            this.modal.mode = 'EDIT';
            this.modal.isOpen = true;
        },
        onClickDeleteScoreColumn(recordId) {
            this.$inertia.delete(route("director.course.scoreColumns.destroy", {
                course: this.course.id,
                score_column: recordId
            }), {
                onSuccess: (page) => {
                    console.log(page)
                },
                onError: (error) => {
                    console.log(error);
                }
            });

            console.log("Need to check if the column id already use in score table. need to double confirm or shows the existing score record again.");
            console.log(recordId);
        },
        createScoreColumn(data) {
            this.$inertia.post(route("director.course.scoreColumns.store", this.course), data, {
                onSuccess: (page) => {
                    this.modal.mode = null;
                    this.modal.isOpen = false;
                },
                onError: (error) => {
                    console.log(error);
                }
            });
        },
        updateScoreColumn(data) {
            //this.$inertia.put('/director/score_column/'+data.id, data, {
            console.log(data);
            this.$inertia.put(route("director.course.scoreColumns.update", {
                course: this.course,
                score_column: data.id
            }), data, {
                onSuccess: (page) => {
                    this.modal.mode = null;
                    this.modal.isOpen = false;
                    this.storeAllScores();
                },
                onError: (error) => {
                    console.log(error);
                }
            });
        },
        onModalFinish() {
            console.log("modal finish");
        },
        storeAllScores(score) {
            
            var data = [];
            // Object.entries(this.studentsScores).forEach(([sid, student]) => {
            //     this.onScoreCellChange(student);
            //     Object.entries(student.scores).forEach(([cid, score]) => {
            //         data.push({
            //             course_student_id: score.course_student_id,
            //             score_column_id: score.score_column_id,
            //             student_id: student.student_id,
            //             point: score.point
            //         })
            //     })
            // })
            // console.log(data);return ;
            
            this.$inertia.post(route("teacher.course.scores.batchUpdate", this.course), score, {
                preserveScroll:true,
                preserveState:true,
                onSuccess: (page) => {
                    // console.log("update " + page)
                },
                onError: (error) => {
                    console.log(error);
                }

            })
        },
        handleScoreColumnChange() {
            this.$refs.modalScoreColumn.validateFields().then(() => {
                if (this.modal.mode == 'ADD') {
                    this.createScoreColumn(this.modal.data);
                    this.modal.mode = null;
                } else if (this.modal.mode == 'EDIT') {
                    this.updateScoreColumn(this.modal.data);
                }

            }).catch(err => {
                console.log(err);
            })

        },
        onScoreCellChange(student) {
            var fields = [];
            //change year total formular formular
            var termTotals = [];
            this.scoreColumns.forEach((column, idx) => {
                if (column.is_total == 1) {
                    termTotals.push(column.column_letter);
                }
                if (column.term_id == 9) {
                    termTotals.forEach((t, i) => {
                        if (column.formular) {
                            column.formular = column.formular.replace('T' + (i + 1), termTotals[i])
                        }

                    })
                }
            })

            this.scoreColumns.forEach(column => {
                var formular = '';
                fields[column.id] = {
                    'point': '',
                    'letter': column.column_letter
                };
                if (column.formular !== null) {
                    formular = column.formular;
                    Object.entries(student.scores).forEach(([columnId, score]) => {
                        formular = formular.replace(score.column_letter, score.point);
                    })
                    try {
                        formular = formular.replace("=", "");
                        student.scores[column.id].point = Math.round(eval(formular) * 100) / 100
                    } catch (error) {
                        console.log('error');
                    }
                }
            })

            //init column letters
            //this.runFormular(this.score_columns, this.scores[key], key);
        },
        runFormular(columns, row, courseStudentId) {
            //console.log(this.studentsScores);
            var fields = {};
            var termTotals = [];
            //init column letters
            columns.forEach(column => {
                if (row.scores[column.id] === undefined) {
                    fields[column.column_letter] = '';
                } else {
                    fields[column.column_letter] = row.scores[column.id];
                }
            })

            //change year total formular formular
            columns.forEach((column, idx) => {
                if (column.is_total == 1) {
                    termTotals.push(column.column_letter);
                }
                if (column.term_id == 9) {
                    termTotals.forEach((t, i) => {
                        //column.formular=column.formular.replace('T'+(i+1),termTotals[i])
                    })
                }
            })

            //loop through all score columns
            columns.forEach((column, idx) => {
                //if column formular is not empty, meaning with formular
                if (column.formular != null) {
                    var fieldName = column.id;
                    var formular = column.formular;
                    //remove "=" from the origianl formular
                    formular = formular.replace("=", "");
                    //replace round as Math.round in the formular
                    formular = formular.replace("ROUND", "Math.round");
                    //replace values to formular, according to the fields values
                    Object.entries(fields).forEach(([key, value]) => {
                        if (value == '') value = 0; //escape formular calculation if any field is empty
                        formular = formular.replace(key, value);
                    });
                    try {
                        row.scores[fieldName] = eval(formular);
                    } catch (error) {
                        console.log("(" + courseStudentId + ")" + row.student_name + ", formular incurrect");
                        console.log(formular);
                    }
                }
            });
        },
        rowChange(event) {
            let i = 1;
            this.scoreColumns.forEach(column => {
                column.sequence = i++
            })
            this.$inertia.post(route("teacher.course.scoreColumn.reorder", this.course), this.scoreColumns, {
                onSuccess: (page) => {
                    console.log(page);
                },
                onError: (error) => {
                    console.log(error);
                }
            });
        },
        sampleData() {
            const total = this.scoreColumns
            Object.entries(this.studentsScores).forEach(([sid, student]) => {
                this.scoreColumns.forEach(column => {
                    student.scores[column.id]['point'] = Math.floor(Math.random() * 100) + 1
                })
            })
            this.storeAllScores();
        },
        getYearAverage(row) {
            return row.scores[this.scoreColumns.find(c => c.term_id == 9).id]
        },
        addMerge() {
            console.log(this.modal.data)
            console.log(this.merge)
            if (this.merge.course_id === null || this.merge.score_column_id === null || this.merge.percentage === null) {
                alert("Please also select Score item and input percentage")
                return false
            }

            this.modal.data.merge.push({
                ...this.merge
            })
        },
        deleteMerge(idx) {
            const selected = this.klassCourses.find(c => c.id == this.modal.data.merge[idx].course_id).title_zh;
            if (confirm('Are you sure to delete: ' + selected)) {
                this.modal.data.merge.splice(idx, 1)
            }
        },
        onChangeMergeCourse(courseId) {
            console.log(this.merge);
            console.log(this.klassCourses)
            this.merge.score_column_id = null;
            var course = this.klassCourses.find(c => c.id == this.merge.course_id)
            if (course) {
                this.modal.data.scoreColumnOptions = course.score_columns.map(sc => ({
                    value: sc.id,
                    label: sc.field_label
                }))
            } else {
                this.modal.data.scoreColumnOptions = []

            }
        },
        mergeItem(item) {
            var course = this.klassCourses.find(c => c.id == item.course_id)
            if (course) {
                var scoreFieldLabel = course.score_columns.find(sc => sc.id == item.score_column_id).field_label
                return course.title_zh + ": " + scoreFieldLabel + " : " + item.percentage;
            }
            return 'NaN';
        },
        yearFinalFormular() {
            const yearFinal = this.scoreColumns.find(c => c.term_id == 9)
            return yearFinal ? yearFinal.formular : 'No year final formular';
        },
        disabledByTerm() {
            return !(this.selectedTerm == this.course.current_term);
        },
        showCurrentTerm() {
            if (this.course.current_term == 0) {
                return '已上鎖';
            } else {
                return this.yearTerms.find(t => t.value == this.course.current_term).label;
            }
        }

    },

}
</script>

<style>


table#dataTable {
    @apply  text-center bg-slate-100 w-full text-2xl
}
table#dataTable th {
    @apply border-solid border border-collapse
        border-t-0 border-r-0 text-lg font-black 
        border-slate-400   text-slate-500/90
}
table#dataTable td {
    @apply  border-solid border border-collapse border-t-0 border-r-0
       font-black text-sky-600/90
       border-slate-400  
}
table#dataTable td:first-child {
    @apply  border-l-0 
}
table#dataTable th:first-child {
    @apply  border-l-0 
}
table#dataTable td {
    @apply bg-sky-100 
}

table#dataTable input {
    @apply font-black text-center  text-xl
}
table#dataTable input:focus {
    @apply border-4 border-indigo-600
}

/*  */
table.itxst {
    @apply  text-center bg-slate-100
}
table.itxst th {
    @apply cursor-move border-solid border border-collapse
        border-t-0 border-r-0 text-lg font-black 
        border-slate-400   text-slate-500/90
}
table.itxst td {
    @apply cursor-move border-solid border border-collapse border-t-0 border-r-0
        text-lg font-black text-sky-600/90
       border-slate-400  
}
table.itxst td:first-child {
    @apply  border-l-0 
}
table.itxst th:first-child {
    @apply  border-l-0 
}
table.itxst td {
    @apply bg-sky-100 
}
table.itxst td.move:hover {
    cursor: move;
}

</style>
