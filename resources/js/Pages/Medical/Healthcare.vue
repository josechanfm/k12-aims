<template>
    <AdminLayout title="體檢測量" :breadcrumb="breadcrumb">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                健康記錄
            </h2>
        </template>
        <!-- <p>Klass: {{healthcare.klass.tag}}</p> -->
        <p>Title: {{healthcare.title}}</p>
        <p>Data: {{healthcare.date}}</p>
        <div>
            Fields: 
            <span v-for="column in healthcare.bodycheck_columns">{{ columnLabel(column) }}, </span>
        </div>
        <!-- <a-button @click="sampleData">Sample Data</a-button>
        Min: <input v-model="random.min"/>
        Max: <input v-model="random.max"/> -->
        <a-button @click="clickSaveRecords" class="ant-btn ant-btn-primary float-right">存保內容</a-button>
        <a-button @click="sampleData" class="ant-btn float-right">Sample Data</a-button>
        <a-radio-group v-model:value="selectedKlass" @click="onClickKlass" button-style="solid">
            <template v-for="klass in healthcare.klasses">
                <a-radio-button :value="klass.id">{{ klass.tag }}</a-radio-button>
            </template>
        </a-radio-group>
        
        <a-card>
            <table id="dataTable" ref="dataTable">
                <thead>
                    <tr>
                        <td>klass id</td>
                        <template v-for="column in healthcare.bodycheck_columns">
                            <td>{{ columnLabel(column) }}</td>
                        </template>
                    </tr>
                </thead>
                <template v-for="student in students">
                    <tr>
                        <td>{{ student.name_zh }}</td>
                        <template v-for="column in healthcare.bodycheck_columns">
                            <td>
                                <a-input v-model:value="student.bodychecks[column].value" @change="onScoreChange"/>
                            </td>
                        </template>
                    </tr>
                </template>
            </table>
        </a-card>

    </AdminLayout>
</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import dayjs from 'dayjs';
import KlassSelector from '@/Components/KlassSelector.vue';
import axios from 'axios';
import { ExclamationCircleOutlined } from '@ant-design/icons-vue';
import { createVNode } from 'vue';
import { Modal } from 'ant-design-vue';

export default {
    components: {
        AdminLayout,
        dayjs,
        KlassSelector
    },
    props: ['healthcare','bodycheck_columns'],
    data() {
        return {
            breadcrumb:[
                {label:"健康狀況" ,url:route('medical')},
                {label:"體檢測量" ,url:null},
            ],
            valueChanged:false,
            students:[],
            selectedKlass:null,
            previousKlass:null,
            random:{
                min:10,
                max:30
            },
            dateFormat: 'YYYY-MM-DD',
            tableCell: {
                row: 0,
                col: 0,
                //maxRow: this.healthcare.klass.students.length,
                //maxCol: this.healthcare.data_fields.length
            },

        }
    },
    created() {
    },
    mounted(){
        //add Click EventListenter to dataTable
        this.$refs.dataTable.addEventListener('click', (e) => {
            this.tableCell.row = e.target.closest('tr').rowIndex;
            this.tableCell.col = e.target.closest('td').cellIndex;
        })
        //add KeyDown (ArrowKeys) EventListenter to dataTable
        this.$refs.dataTable.addEventListener('keydown', (e) => {
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
            }
            var input = this.$refs.dataTable.rows[this.tableCell.row].cells[this.tableCell.col].getElementsByTagName("input");
            if (input.length > 0) {
                input[0].focus();
            }
        })
        //onclick of input box, calebrate the row, col values
        //only apply for multiple table in the same page
        const inputs = this.$refs.dataTable.getElementsByTagName("input");
        for (var i = 0; i < inputs.length; i++) {
            inputs[i].addEventListener("focus", (e) => {
                this.tableCell.row = e.target.closest('tr').rowIndex;
                this.tableCell.col = e.target.closest('td').cellIndex;
            })
        }
    },
    methods: {
        columnLabel(column){
            return this.bodycheck_columns.find(c=>c.value==column).label
        },
        onKeypressed(event) {
            this.keypressed = event.keyCode;
        },
        onScoreChange(){
            this.valueChanged=true;
        },
        clickSaveRecords(){
            var bodychecks=[];
            this.students.forEach(s=>{
                Object.values(s.bodychecks).forEach((p)=>{
                    delete p['klass_student']
                     bodychecks.push(p)
                })
            })
            this.$inertia.put(route("medical.bodychecks.update",0), bodychecks, {
                onSuccess: (page) => {
                    this.valueChanged=false
                },
                onError: (error) => {
                    console.log(error);
                }
            })

        },
        sampleData(){
            console.log(this.random);
            this.students.forEach(s=>{
                Object.values(s.bodychecks).forEach(b=>{
                    b.value=this.randomBetween(parseInt(this.random.min),parseInt(this.random.max))
                })
            })
        },
        randomBetween(min, max){
            return Math.floor(Math.random() * (max - min + 1) + min)
        },
        onClickKlass(e){
            if(e.target.value==undefined){
                return true;
            }
            if(this.selectedKlass==null){
                this.getBodychecks(e.target.value);
                return true;
            }
            if(this.valueChanged==false){
                this.getBodychecks(e.target.value);
                return true;
            }
            this.previousKlass=this.selectedKlass;
            this.selectedKlass=e.target.value
            
            Modal.confirm({
                title: '內容有變更但未保存，是否確定轉換班別？',
                icon: createVNode(ExclamationCircleOutlined),
                content: '體檢內容有所修改，但未進行保存，直接轉換班別，會導至所修改的內容永久流失。',
                okText:'確定轉換',
                cancelText:'放棄並反回',
                onOk: () => {
                    this.getBodychecks(this.selectedKlass);
                    this.valueChanged=false
                },
                onCancel:()=>{
                    this.selectedKlass=this.previousKlass
                }
            });
        },

        getBodychecks(klass){
            axios.post(route('medical.healthcare.getBodychecks',{healthcare:this.healthcare,klass:klass}))
                .then(response=>{
                    //console.log(response.data);
                    this.students=response.data
                })
                .catch(error=>{
                    console.log(error);
                })

        }
    },
}
</script>

<style>
#dataTable, #dataTable td, #dataTable th {
  border: 1px solid;
}

#dataTable {
  width: 100%;
  border-collapse: collapse;
}
#dataTable input{
    text-align: center; 
}
        /*定义要拖拽元素的样式*/
        table.itxst {
            color: #333333;
            border: #ddd solid 1px;
            border-collapse: collapse;
        }

            table.itxst th {
                border: #ddd solid 1px;
                padding: 8px;
                background-color: #fafafa;
            }

            table.itxst td {
                border: #ddd solid 1px;
                padding: 8px;
                background-color: #ffffff;
            }

            table.itxst tr {
                cursor: pointer;
            }

            table.itxst td.move:hover {
                cursor: move;
            }
</style>
