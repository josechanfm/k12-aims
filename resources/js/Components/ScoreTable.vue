

<template>
<!-- {{ props.score[0] }} -->
<!-- {{ columns }} -->
<!-- {{ nonEditableData }} -->
<div class="tabulator-container p-6">
    <div ref="ScoreTable" id="example-table" class="tabulator-theme "></div>
</div>
</template>

  
<script setup>
import { ref, onMounted } from 'vue';
import { TabulatorFull as Tabulator } from 'tabulator-tables';
import '/resources/css/tabulator.css';

const props = defineProps({
    column: { type: Array },
    score: { type: Object },
});

// Config
// ----------
const nonEditable = ['student_id', 'student_number', 'student_name']; // 不允许更改的欄
const nonEditableKey = 'student_id'

const FontRedThreshold = 50

const columns = [
    { title:"學生編號", field:"student_number" },
    { title:"學生姓名", field:"student_name" },
]
// -----------

var table = ref(null)

const emit = defineEmits(["store"]);

const ScoreTable = ref(null);
let nonEditableData = []; // 不允许更改的數據

// 加 dynamic column
props.column.forEach((col)=>{
    columns.push( {
        title: "( " + col.column_letter +  " )" + col.field_label ,
        field: col.id.toString(),
        validator: ["numeric"], // 验证必须是数字且必填
        formatter:function(cell){
            if( !cell.getValue() ) return; // 如果不是空值
            const value = parseFloat(cell.getValue()) ;
            const color = value < FontRedThreshold ? "red" : "inherit";
            return `<span style="color:${color}">${value}</span>`;
        },
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
    console.log(props)
    // 留一份不允許更改欄的值
    nonEditableData = score.map(obj => 
        nonEditable.reduce((acc, key) => {
            if (key in obj) acc[key] = obj[key];
            return acc;
        }, {})
    );
    table = new Tabulator(ScoreTable.value, {
        data:score,

        history:true,
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

    // 撤销功能
    const undo = () => {
        table.undo();
        storeScore()
    };
    // 重做功能
    const redo = () => {
        table.redo();
        storeScore()
    };

    // 键盘事件处理
    const handleKeyDown = (e) => {
        // Ctrl+Z 撤销
        if (e.ctrlKey && e.key === 'z') {
            undo();
        }
        // Ctrl+Y 重做
        if (e.ctrlKey && e.key === 'y') {
            redo();
        }
    };

    // 监听键盘事件
    window.addEventListener('keydown', handleKeyDown);

    table.on("clipboardPasted", function(pasteData, columns, rows){
        window.x = columns 
        window.y = rows 
        console.log( pasteData )

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
        // -------------

        storeScore()
    }); 
    table.on("cellEdited", function(cell, d){
        const field = cell.getField();
        // const rowId = cell.getRow().getData().id;
        // const oldValue = cell._cell.oldValue; // 直接访问内部属性
        const newValue = cell.getValue();
        
        // 如果修改的是name，则恢复原值
        if ( nonEditable.includes(field) ) {
            cell.restoreOldValue();
            return false; // 阻止修改
        }

        storeScore()
    }); 
    
});

const updateStoreScores = (data) =>{
    // 遍历第一层的分数字段
    for (const [scoreColumnId, pointValue] of Object.entries(data)) {
        // 跳过非数字键的字段（如 student_id, student_name 等）
        if (isNaN(scoreColumnId)) continue;
        
        // 检查对应的 scores 对象是否存在该 score_column_id
        if (data.scores && data.scores[scoreColumnId]) {
            // 更新 point 值
            data.scores[scoreColumnId].point = pointValue;
        }
    }
    return data;
}

const storeScore = () => {
    
    score.forEach( (col)=>{
        col = updateStoreScores(col)
    })

    console.log('Store Score');
    // console.log(score); return ;
    emit('store', score);
}
</script>


<style >

/* 表头样式 */
.tabulator-theme{
    @apply bg-gray-200
}
.tabulator-theme .tabulator-header .tabulator-col {
    @apply bg-blue-600 text-white;
}
.tabulator-theme .tabulator-col:hover {
    @apply bg-blue-700
}
.tabulator .tabulator-header .tabulator-col.tabulator-range-highlight {
    @apply bg-blue-800 text-white
}
/* 行悬停效果 */
.tabulator-theme .tabulator-row:hover {
    @apply bg-blue-50/70;
}
.tabulator-col-title {
    @apply h-12 flex items-center ;
}
.tabulator-editable {
    @apply text-lg;
}
.tabulator-row .tabulator-cell.tabulator-editing input{
    @apply text-lg !important;
}

</style>

