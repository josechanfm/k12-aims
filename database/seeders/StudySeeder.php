<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use App\Models\Year;
use App\Models\Study;
use App\Models\Subject;

class StudySeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run($year=null)
    {
        if($year==null){
            $year=Year::currentYear();
        }
        $data=[
            ['grade_year'=>'4','title_zh'=>'小一','stream'=>'ALL','version'=>1,'active'=>true],
            ['grade_year'=>'5','title_zh'=>'小二','stream'=>'ALL','version'=>1,'active'=>true],
            ['grade_year'=>'6','title_zh'=>'小三','stream'=>'ALL','version'=>1,'active'=>true],
            ['grade_year'=>'7','title_zh'=>'小四','stream'=>'ALL','version'=>1,'active'=>true],
            ['grade_year'=>'8','title_zh'=>'小五','stream'=>'ALL','version'=>1,'active'=>true],
            ['grade_year'=>'9','title_zh'=>'小六','stream'=>'ALL','version'=>1,'active'=>true],
            ['grade_year'=>'10','title_zh'=>'初一','stream'=>'ALL','version'=>1,'active'=>true],
            ['grade_year'=>'11','title_zh'=>'初二','stream'=>'ALL','version'=>1,'active'=>true],
            ['grade_year'=>'12','title_zh'=>'初三','stream'=>'ALL','version'=>1,'active'=>true],
            ['grade_year'=>'13','title_zh'=>'高一','stream'=>'ALL','version'=>1,'active'=>true],
            ['grade_year'=>'14','title_zh'=>'高二','stream'=>'ALL','version'=>1,'active'=>true],
            ['grade_year'=>'15','title_zh'=>'高三','stream'=>'ALL','version'=>1,'active'=>true],
        ];

        foreach($data as $d){
             $d['year_id']=$year->id;
            $study=Study::create($d);
            $subjectIds=array_column(Subject::get()->toArray(),'id');
            $study->subjects()->attach($subjectIds);
        }
    }
}
