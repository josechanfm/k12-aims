<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Course extends Model
{
    use HasFactory;
    protected $appends=['student_count','subject_heads','teacher_ids'];
    protected $casts=['subject_head_ids'=>'array'];

    public function getTeacherIdsAttribute(){
        return $this->teachers->pluck('id');
        
    }
    public function getStudentCountAttribute(){
        return $this->students->count();
    }
    public function getSubjectHeadsAttribute(){
        if(is_array($this->subject_head_ids)){
            return Staff::whereIn('id',$this->subject_head_ids)->get();
        };
        return null;
    }
    public function klass(){
        return $this->belongsTo(Klass::class);
    }
    public function allScores(){
        return $this->hasManyThrough(
            Score::class,
            CourseStudent::class,
            'course_id',
            'course_student_id',
            'id',
            'id'
        );
    }
    public function scores(){
        return $this->belongsToMany(Student::class,'course_student')->withPivot('id as pivot_course_student_id');
    }
    public function scoreColumns(){
        return $this->hasMany(ScoreColumn::class)->orderBy('term_id')->orderByRaw('-sequence DESC');
    }

    // public function students2(){
    //     return $this->belongsToMany(Student::class)->with('scores');
    // }
    public function students(){
        return $this->belongsToMany(Student::class,'course_student')->withPivot('id as pivot_course_student_id');
    }
    public function teachers(){
        return $this->belongsToMany(Staff::class,'course_teacher','course_id','staff_id');
    }
    // // public function subject(){
    // //     return $this->belongsTo(Subject::class);
    // // }
    // // public static function gather_scores($courseId){
    // //     $students=Course::find($courseId)->students;
    // //     foreach($students as $student){
    // //         $student->scores=Score::where('klass_student_id',$student->pivot->klass_student_id)->get();
    // //     }
    // //     return $students;
    // // }

    // //public static function students_scores($cid){
    // public function students_scores(){
    //     //$students=Course::find($this->id)->students;
    //     $students=$this->students;
    //     foreach($students as $student){
    //         $student->scores=Score::where('course_student_id',$student->pivot->course_student_id)->get();
    //     }
    //     return $students;
    // }

    public function studentsScores(){
        $students=$this->students;
        $scores=$this->allScores;
        // dd($scores[2]);
        $scoreColumns=$this->scoreColumns;
        $table=[];

        foreach($students as $student){
            $tmp=[];
            $tmp['student_id']=$student->id;
            $tmp['student_name']=$student->name_zh;
            $tmp['course_student_id']=$student->pivot->course_student_id;
            foreach($scoreColumns as $column){
                $tmp['scores'][$column->id]=[];
                foreach($scores as $score){
                    if($score->course_student_id==$tmp['course_student_id'] && $score->score_column_id==$column->id){
                        $score['column_letter']=$column->column_letter;
                            $tmp['scores'][$score->score_column_id]=$score;
                    }
                }
                if(empty($tmp['scores'][$column->id])){
                    $tmp['scores'][$column->id]=(object)[
                        "course_student_id"=>$student->pivot->course_student_id,
                        "score_column_id"=>$column->id,
                        "student_id"=>$student->id,
                        "point"=>'',
                    ];
                }

            }
            $table[$student->id]=$tmp;
            //array_push($table, $tmp);
        }
        return $table;
    }

    public function makeups(){
        return $this->hasManyThrough(
            Makeup::class,
            CourseStudent::class,
            'course_id',
            'course_student_id',
            'id',
            'id'
        );
    }

    public function studentsMakeups(){
        $students=$this->students;
        $makeups=$this->makeups;
        $table=[];

        foreach($makeups as $makeup){
            foreach($students as $student){
                if($makeup->course_student_id==$student->pivot->course_student_id){
                    $table[$student->id]['student_id']=$student->id;
                    $table[$student->id]['student_name']=$student->name_zh;
                    $table[$student->id]['course_student_id']=$student->pivot->course_student_id;
                    $table[$student->id]['point']=$makeup->point;
                }
            }
        }
        return $table;
    }

    public function studentMakeup(Student $student){
        $s=$this->students->where('id',$student->id)->first();
        return Makeup::where('course_student_id',$s->pivot->course_student_id)->first();
    }

    // public static function students_outcomes($kid){
    //     return Course::where('klass_id',$kid)->whereNot('type','SUB')->get();
    // }
}
