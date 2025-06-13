<template>
<!-- {{ score[0] }} -->
<!-- {{ props.column }} -->
<!-- {{ nonEditableData }} -->
<div class="tabulator-container">
    <div ref="ScoreTable" id="example-table" class="tabulator-excel"></div>
</div>
</template>

  
<script setup>
import {
    ref,
    onMounted
} from 'vue';
import {
    TabulatorFull as Tabulator
} from 'tabulator-tables';
import '/resources/css/tabulator.css';

const props = defineProps({
    column: { type: Array },
    score: { type: Object },
});
// Config
// ----------
const nonEditable = ['student_id', 'student_number', 'student_name']; // 不允许更改的欄
const nonEditableKey = 'student_id'

const columns = [
    {title:"學生編號", field:"student_number"},
    {title:"學生姓名", field:"student_name"},
]
// -----------

const ScoreTable = ref(null);
let nonEditableData = []; // 不允许更改的數據

props.column.forEach((col)=>{
    columns.push( {
        title: "( " + col.column_letter +  " )" + col.field_label ,
        field: col.id.toString(),
    })
})
let score = props.score
score.forEach((sco)=>{
    let row = Object.values(sco.scores)
    row.map( r => {
        sco[r.score_column_id] = r.point
    }) 
})

onMounted(() => {
    // 留一份不允許更改欄的值
    nonEditableData = score.map(obj => 
        nonEditable.reduce((acc, key) => {
            if (key in obj) acc[key] = obj[key];
            return acc;
        }, {})
    );
    var table = new Tabulator(ScoreTable.value, {
        data:score,

        //enable range selection
        selectableRange:1,
        selectableRangeColumns:true,
        selectableRangeRows:true,
        selectableRangeClearCells:true,
  
        //change edit trigger mode to make cell navigation smoother
        editTriggerEvent:"click",

        //configure clipboard to allow copy and paste of range format data
        clipboard:true,
        clipboardCopyStyled:false,
        clipboardCopyConfig:{
            rowHeaders:false,
            columnHeaders:false,
        },
        clipboardCopyRowRange:"range",
        clipboardPasteParser:"range",
        clipboardPasteAction:"range",

        rowHeader:{ 
            resizable: false, 
            frozen: true, 
            width:40, 
            hozAlign:"center", 
            formatter: "rownum", 
            cssClass:"range-header-col", 
            editor:true
        },

        //setup cells to work as a spreadsheet
        columnDefaults:{
            headerSort:false,
            headerHozAlign:"center",
            editor:"input",
            resizable:"header",
            width:100,
        },
        columns:columns,
    });

    // table.on("clipboardCopied", function(clipboard){
    //     console.log(clipboard);
    // });

    table.on("clipboardPasted", function(pasteData, rowData, rows){
        // 过滤掉 nonEditable 字段的修改
        // 將不可更改的值重新覆蓋
        score =  score.map(DataItem => {
            // 在 nonEditableData 中找到相同 id 的物件
            const rawItem = nonEditableData.find(item => item[nonEditableKey] === DataItem[nonEditableKey]);
            
            if (rawItem) {
                return { ...DataItem, ...rawItem }; // 用 rawItem 的值覆蓋 DataItem 的值
            }
            
            return { ...DataItem };
        });
        table.setData(score);
    }); 
    table.on("cellEdited", function(cell, d){
        const field = cell.getField();
        // const rowId = cell.getRow().getData().id;
        // const oldValue = cell._cell.oldValue; // 直接访问内部属性
        // const newValue = cell.getValue();
        
        // 如果修改的是name，则恢复原值
        if ( nonEditable.includes(field) ) {
            cell.restoreOldValue();
            return false; // 阻止修改
        }
    }); 
});
</script>

