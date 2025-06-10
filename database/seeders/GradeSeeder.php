<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Config;
use App\Models\Year;
use App\Models\Grade;
use App\Models\Klass;

class GradeSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $studentId=1;
        $currentYear=date('Y');
        $year=Year::where('code',$currentYear)->first();
        $initial=array_column(Config::item('klass_letters'),'label');
        $initial=array_slice($initial,0,4);
        //Kindergarten
        for($i=1;$i<=3;$i++){
            $grade=Grade::firstOrCreate([
                    'title_zh'=>'K'.$i,
                    'title_en'=>'K'.$i,
                    'year_id'=>$year->id,
                    'grade_year'=>$i,
                    'initial'=>'K',
                    'level'=>$i,
                    'tag'=>'K'.$i,
                    'version'=>1,
                    'klass_count'=>3,
                    'transcript_template_id'=>2,
                    'behaviour_scheme'=>["SUBJECT"=>0.3,"KLASS_HEAD"=>0.2,"DIRECTOR"=>0.5,"ADJUST"=>1],
                    'active'=>1
            ]);
            foreach($initial as $ini){
                $klass=$grade->klasses()->create([
                    'letter'=>$ini,
                    'tag'=>$grade->tag.$ini,
                    'study_id'=>1,
                    'klass_head_ids'=>null
                ]);
                $klassStudents=[];
                for($j=1; $j<20; $j++){
                    $klassStudents[$studentId++]= [
                        'student_number'=>$j,
                    ];
                }
                $klass->students()->sync($klassStudents);
                //enrol all klass student to all klass courses
                $courses=$klass->courses;
                foreach($courses as $c=>$course){
                    $course->staffs()->attach(rand(1,50));
                    $students=$klass->students->pluck('id')->toArray();
                    $course->students()->sync($students);
                }
            };

        }
        //primary
        for($i=4;$i<=9;$i++){
            $grade=Grade::firstOrCreate([
                    'year_id'=>$year->id,
                    'grade_year'=>$i,
                    'initial'=>'P',
                    'level'=>$i-3,
                    'tag'=>'P'.$i-3,
                    'version'=>1,
                    'transcript_template_id'=>1,
                    'behaviour_scheme'=>["SUBJECT"=>0.3,"KLASS_HEAD"=>0.2,"DIRECTOR"=>0.5,"ADJUST"=>1],
                    'active'=>1
            ]);
            foreach($initial as $ini){
                $klass=$grade->klasses()->create([
                    'letter'=>$ini,
                    'tag'=>$grade->tag.$ini,
                    'study_id'=>1,
                    'klass_head_ids'=>[rand(1,50)]
                ]);
                $klassStudents=[];
                for($j=1; $j<20; $j++){
                    $klassStudents[$studentId++]= ['student_number'=>$j];
                }
                $klass->students()->sync($klassStudents);
                $courses=$klass->courses;
                foreach($courses as $c=>$course){
                    $course->staffs()->attach(rand(1,50));
                    $students=$klass->students->pluck('id')->toArray();
                    $course->students()->sync($students);
                }

            };

        }
        //secondary junior
        for($i=10;$i<=12;$i++){
            $grade=Grade::firstOrCreate([
                    'year_id'=>$year->id,
                    'grade_year'=>$i,
                    'initial'=>'SC',
                    'level'=>$i-9,
                    'tag'=>'SC'.$i-9,
                    'version'=>1,
                    'transcript_template_id'=>1,
                    'behaviour_scheme'=>["SUBJECT"=>0.3,"KLASS_HEAD"=>0.2,"DIRECTOR"=>0.5,"ADJUST"=>1],
                    'active'=>1
            ]);
            foreach($initial as $ini){
                $klass=$grade->klasses()->create([
                    'letter'=>$ini,
                    'tag'=>$grade->tag.$ini,
                    'study_id'=>1,
                    'klass_head_ids'=>[rand(1,50)]
                ]);
                $klassStudents=[];
                for($j=1; $j<20; $j++){
                    $klassStudents[$studentId++]= ['student_number'=>$j];
                }
                $klass->students()->sync($klassStudents);
                $courses=$klass->courses;
                foreach($courses as $c=>$course){
                    $course->staffs()->attach(rand(1,50));
                    $students=$klass->students->pluck('id')->toArray();
                    $course->students()->sync($students);
                }

            };
        }
        //secondary senior
        for($i=13;$i<=15;$i++){
            $grade=Grade::firstOrCreate([
                    'year_id'=>$year->id,
                    'grade_year'=>$i,
                    'initial'=>'SG',
                    'level'=>$i-12,
                    'tag'=>'SG'.$i-12,
                    'version'=>1,
                    'transcript_template_id'=>1,
                    'behaviour_scheme'=>["SUBJECT"=>0.3,"KLASS_HEAD"=>0.2,"DIRECTOR"=>0.5,"ADJUST"=>1],
                    'active'=>1
            ]);
            foreach($initial as $ini){
                $klass=$grade->klasses()->create([
                    'letter'=>$ini,
                    'tag'=>$grade->tag.$ini,
                    'study_id'=>1,
                    'klass_head_ids'=>[rand(1,50)]
                ]);
                $klassStudents=[];
                for($j=1; $j<20; $j++){
                    $klassStudents[$studentId++]= ['student_number'=>$j];
                }
                $klass->students()->sync($klassStudents);
                $courses=$klass->courses;
                foreach($courses as $c=>$course){
                    $course->staffs()->attach(rand(1,50));
                    $students=$klass->students->pluck('id')->toArray();
                    $course->students()->sync($students);
                }
            };

        }
    }
}
