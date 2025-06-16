<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Course extends Model
{
    use HasFactory;
    protected $fillable=['klass_id','code','title_zh','title_en','type','stream','elective','description','score_column','score_scheme','in_transcript','unit','active','transcript_locked'];
    protected $appends=['student_count','subject_heads','teacher_ids','teaching','study_subject'];
    // protected $casts=['subject_head_ids'=>'array'];

      public function studySubject()
    {
        return $this->belongsTo(StudySubject::class);
    }
    public function getStudySubjectAttribute()
    {
        return $this->studySubject()->with('subject')->first();
    }

    public function getTeacherIdsAttribute(){
        return $this->staffs->pluck('id');
        
    }
    public function getTeachingAttribute(){
        return $this->staffs;
        
    }
    public function getStudentCountAttribute(){
        return $this->students->count();
    }
    public function getSubjectHeadsAttribute(){
        if(is_array($this->study_subject->subject_head_ids)){
            return Staff::whereIn('id',$this->study_subject->subject_head_ids)->get();
        };
        return null;
    }
    public function isTeacher(){
        if(empty(auth()->user()->staff)){
            return false;
        }
        return in_array(auth()->user()->staff->id,$this->staffs->pluck('id')->toArray());
    }
    public function isSubjectHead(){
        if(empty(auth()->user()->staff)){
            return false;
        }
        
        return in_array(auth()->user()->staff->id,$this->study_subject->subject_head_ids);
    }
    public function isKlassHead(){
        if(empty(auth()->user()->staff)){
            return false;
        }
        return in_array(auth()->user()->staff->id,$this->klass->klass_head_ids);
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
        return $this->belongsToMany(Staff::class,'course_staff','course_id','staff_id')->withPivot(['behaviour','behaviour_exception']);
    }
    public function staffs(){
        return $this->belongsToMany(Staff::class)->withPivot(['behaviour','behaviour_exception']);
    }

    // public function studentsBehaviours(){
    //     return $this->belongsToMany(Student::class,'course_student')->withPivot('id as pivot_course_student_id');
    //     //return $this->hasMany(Behaviour::class);
    // }
    public function behaviours(){
        $terms=Config::item('year_terms');
        $staff=auth()->user()->staff;
        $students=$this->students;
        $actor="SUBJECT";
        $referenceId=$this->id;
        $data=[];
        foreach($students as $student){
            $klassStudent=KlassStudent::where('klass_id',$this->klass_id)->where('student_id',$student->id)->first();
            $student->pivot->student_number=$klassStudent->student_number;
            $data['students'][$klassStudent->id]=$student;
            $data['scores'][$klassStudent->id]=$student->getBehaviours($klassStudent->id, $staff, $terms, $referenceId , $actor);
        }
        return $data;
        //return $students;
    }
    public function studentsScores(){

        $students=$this->students;
        $scores=$this->allScores;
        $scoreColumns=$this->scoreColumns;
        $table=[];
        foreach($students as $student){
            $tmp=[];
            $tmp['student_id']=$student->id;
            $tmp['student_name']=$student->name_c;
            $tmp['course_student_id']=$student->pivot->course_student_id;
            $tmp['student_number']=KlassStudent::where('klass_id',$this->klass_id)->where('student_id',$student->id)->pluck('student_number')->first();

            foreach($scoreColumns as $column){
                $tmp['scores'][$column->id]=[];
                foreach($scores as $score){
                    if($score->course_student_id==$tmp['course_student_id'] && $score->score_column_id==$column->id){
                        // $score['column_letter']=$column->column_letter;
                        // $score['old_point']=$score->point;
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
        //dd($table[316]);
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

    public function upsertMergeScoreColumn(){
        forEach($this->scoreColumns as $scoreColumn){
            if($scoreColumn->can_merge && $scoreColumn->merge){
                $tmp=[];
                foreach($this->students as $student){
                    $tmp[$student->pivot->student_id]=[
                        'course_student_id'=>$student->pivot->course_student_id,
                        'score_column_id'=>$scoreColumn->id,
                        'student_id'=>$student->pivot->student_id,
                        'point'=>0
                    ];
                };
                forEach($scoreColumn->merge as $merge){
                    $StudentScores=Score::where('score_column_id',$merge['score_column_id'])->get();
                    forEach($StudentScores as $score){
                        $tmp[$score->student_id]['point']+=($score->point * $merge['percentage'])/100;
                    }
                }
                Score::upsert($tmp,['course_student_id','student_id','score_column_id'],['point']);
       
            }
        }

        return true;

    }
}
