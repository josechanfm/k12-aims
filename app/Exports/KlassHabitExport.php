<?php

namespace App\Exports;

use App\Models\Habit;
use Maatwebsite\Excel\Concerns\Exportable;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;
use App\Models\Config;
use Illuminate\Support\Collection;

class KlassHabitExport implements FromCollection, WithHeadings
{
    use Exportable;
    protected $klass;
    protected $termId;
    
    function __construct($klass,$termId)
    {
        $this->klass = $klass;
        $this->termId=$termId;
        //$this->headers = $headers;
        // dd($this->headers);
    }
    public function headings(): array
    {
        $habitColumns=array_column(Config::item('habit_columns'),'short');
        array_unshift($habitColumns,'學生姓名');
        array_unshift($habitColumns,'學號');
        array_unshift($habitColumns,'控制欄');
        return $habitColumns;
    }

    /**
    * @return \Illuminate\Support\Collection
    */
    public function collection()
    {
        $studentHabits=$this->klass->studentsHabits();
        $habitColumns=array_column(Config::item('habit_columns'),'name');
        $data=new Collection();
        foreach($studentHabits as $student){
            $habit=$student->habits[$this->termId];
            $tmp=[];
            $tmp['klass_student_id']=substr('0000000000'.$student->pivot->klass_student_id,-10);
            $tmp['student_number']=$student->pivot->student_number;
            $tmp['student_name']=$student->name_zh;
            foreach($habitColumns as $column){
                $tmp[$column]=$habit->{$column};
            }
            $data->push($tmp);
        }
        return $data;
        //return Habit::all();
    }
}
