<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Score extends Model
{
    use HasFactory;
    protected $fillable=['klass_student_id','score_column_id','point'];

    public function score_column(){
        return $this->belongsTo(ScoreColumn::class);
    }

    public function course(){
        return $this->belongsTo(Course::class);
    }

    public function student(){
        return $this->belongsToMany(Student::class,'klass_student','student_id','klass_id');
    }
    static function updateScore($data){
       
        foreach( $data as $i=>$d){
            if( is_null($d['point']) || $d['point']=='' ){ // unsert record if point value is empty
                unset($data[$i]);
            }
        }
        dd($data);
        Score::upsert(
            $data,
            ['course_student_id','score_column_id','student_id']
        );
        
        // check and proceed merge course scores
        // $course=ScoreColumn::find($data[0]['score_column_id'])->course;
        // Score::mergeCoursesScores($course);

        return count($data);
    }

    //for course scores the come from ther course(s), based on the merge column in score_column table
    static function mergeCoursesScores($course){
        $allCourses=\App\Models\Klass::where('id',$course->klass_id)->first()->courses;
        $mergeCourses=[];
        foreach($allCourses as $course){
            $merge=$course->scoreColumns->whereNotNull('merge');
            if($merge->count()>0){
                $mergeCourses[$course->id]=$merge;
            }
        }
        foreach($mergeCourses as $courseColumns){
            foreach($courseColumns as $column){
                $merges=json_decode($column->merge);
                $students=Course::find($column->course_id)->students;
                foreach($students as $student){
                    $point=0;
                    foreach($merges as $merge){
                        $point+=Score::where('score_column_id',$merge->score_column_id)
                                    ->where('student_id',$student->id)->first()->point * $merge->percentage / 100;
                    }
                    Score::where('score_column_id',$column->id)
                        ->where('student_id',$student->id)
                        ->update(['point'=>$point]);
                }
            }
        }

    }
}
