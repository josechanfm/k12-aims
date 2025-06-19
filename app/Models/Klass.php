<?php

namespace App\Models;

use App\Exports\KlassHabitExport;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use \Mpdf\Mpdf as PDF; 
use Illuminate\Support\Facades\Storage;

class Klass extends Model
{
    use \Staudenmeir\EloquentHasManyDeep\HasRelationships;

    use HasFactory;
    protected $fillable=['grade_id','letter','tag','stream','study_id',
    'name_zh','name_en',
    'byname','room','klass_head_ids','current_term','course_locked'];
    protected $casts=[
        'klass_head_ids'=>'json',
        'transcript_migrated'=>'boolean',
        'transcript_locked'=>'boolean',
        'course_locked'=>'boolean'
    ];
    protected $appends= [
        'klass_heads',
        'course_count',
        'student_count',
        'promoted_count',
        'year_code',
        'grade_year',
        'school_year'
    ];
    

    public function hasRight(){
        if(auth()->user()->hasRole('master') || auth()->user()->hasRole('admin')){
            return true;
        }
        return false;
    }
    public function isKlassHead(){
        if(empty(auth()->user()->staff)){
            return false;
        }
        if(is_array($this->klass_head_ids)){
            return in_array(auth()->user()->staff->id,$this->klass_head_ids);
        }else{
            return false;
        }
        
    }
    // public function klassStudents(){
    //     $this->students;
    //     return $this->hasMany(KlassStudent::class)->with('habits');
    // }
    public function getSchoolYearAttribute(){
        return $this->grade->year->code;
    }
    public function getKlassHeadsAttribute(){
        if(is_array($this->klass_head_ids)){
            return Staff::whereIn('id',$this->klass_head_ids)->get();
        };
        return [];
    }
    public function getGradeYearAttribute(){
        return Grade::find($this->grade_id)->grade_year;
    }
    public function getYearCodeAttribute(){
        return Grade::find($this->grade_id)->year->code;
    }
    public function getCourseCountAttribute(){
        return Course::where('klass_id',$this->id)->count();
    }
    public function getStudentCountAttribute(){
        return KlassStudent::where('klass_id',$this->id)->count();
    }
    public function getPromotedCountAttribute(){
        return KlassStudent::where('promote_to',$this->id)->count();
    }
    public function grade(){
        return $this->belongsTo(Grade::class);
    }
    public function students(){
        return $this->belongsToMany(Student::class)
                ->withPivot(['id as pivot_klass_student_id','student_number','stream','state','promote','promote_to']);
    }
    public function studentsWithAvatar(){
        $students=$this->belongsToMany(Student::class)
            ->withPivot(['id as pivot_klass_student_id','student_number','stream','state','promote','promote_to'])->get();
      
        foreach($students as $student){
            $student->avatar=KlassStudent::find($student->pivot->klass_student_id)->getMedia('avatar')->first();
            $student->klass_student_id=$student->pivot->klass_student_id;
            $student->full_tag=$this->tag.substr('00'.$student->pivot->student_number,-2);
        }
        return $students;
    }
    public function medicnotes(){
        return $this->belongsToMany(Student::class)->with('medicnote');
    }
    public function behaviours($actor='SUBJECT'){
        $students=$this->students;
        $terms=Config::item('year_terms');
        $data=[];
        foreach($students as $student){
            $data['students'][$student->pivot->klass_student_id]=$student;
            $data['scores'][$student->pivot->klass_student_id]=$student->getBehaviours($student->pivot->klass_student_id, $terms, $actor);
        }
        return $data;
        //return $students;
    }
    public function behaviourSummary(){
        $students=$this->students;
        $terms=Config::item('year_terms');
        $klass=$this;
        $data=[];
        //course teacher behaviours scores
        $actor='SUBJECT';
        foreach($students as $student){
            $data['students'][$student->pivot->klass_student_id]=$student;
            $tmpTerms=[];
            $tmp=[];
            foreach($this->courses as $course){
                $referenceId=$course->id;
                $tmp[$course->id]=array_column(
                    Behaviour::selectRaw('term_id, round(avg(score),0) as score_total')->where('klass_student_id',$student->pivot->klass_student_id)->where('actor',$actor)->where('reference_id',$course->id)->groupBy('term_id','reference_id')->get()->toArray(),
                    null,
                    'term_id'
                );
            };
            $data['subjects'][$student->pivot->klass_student_id]=$tmp;
            $student->courseTeachers=$tmp;
        }
        //Klass Head behaviours scores
        $actor='KLASS_HEAD';
        foreach($students as $student){
            $tmp=[];
            $data['klassHeads'][$student->pivot->klass_student_id]=array_column(
                Behaviour::selectRaw('term_id, round(avg(score),0) as score_total')->where('klass_student_id',$student->pivot->klass_student_id)->where('actor',$actor)->where('reference_id',$this->id)->groupBy('term_id','reference_id')->get()->toArray(),
                null,
                'term_id'
            );
            $student->klassHeads=array_column(
                Behaviour::selectRaw('term_id, round(avg(score),0) as score_total')->where('klass_student_id',$student->pivot->klass_student_id)->where('actor',$actor)->where('reference_id',$this->id)->groupBy('term_id','reference_id')->get()->toArray(),
                null,
                'term_id'
            );
        }
        //Director behaviours scores
        $actor='DIRECTOR';
        $referenceId=$this->id;
        $staff=auth()->user()->staff;
        foreach($students as $student){
            $data['director'][$student->pivot->klass_student_id]=$student->getBehaviours($student->pivot->klass_student_id, $staff, $terms, $referenceId , $actor);
            $student->director=$student->getBehaviours($student->pivot->klass_student_id, $staff, $terms, $referenceId , $actor);
        }
        //Director behaviours adjustment
        $actor='ADJUST';
        $referenceId=$this->id;
        $staff=auth()->user()->staff;
        foreach($students as $student){
            $data['adjust'][$student->pivot->klass_student_id]=$student->getBehaviours($student->pivot->klass_student_id, $staff, $terms, $referenceId , $actor);
            $student->adjust=$student->getBehaviours($student->pivot->klass_student_id, $staff, $terms, $referenceId , $actor);
        }
        
        foreach($data['students'] as $ksid=>$student){
            foreach($terms as $term){
                $coursesSum=0;
                $data['sumTerms'][$ksid][$term->value]=null;
                foreach($data['subjects'][$ksid] as $course){
                    if(isset($course[$term->value])){
                        $coursesSum+=$course[$term->value]['score_total'];
                    }
                }
                $data['sumCourse'][$ksid][$term->value]=$coursesSum;
                $data['sumTerms'][$ksid][$term->value]=$coursesSum;

                if(isset($data['klassHeads'][$ksid][$term->value])){
                    $data['sumKlassHeads'][$ksid][$term->value]=$data['klassHeads'][$ksid][$term->value]['score_total']*$this->grade->behaviour_scheme['KLASS_HEAD'];
                    $data['sumTerms'][$ksid][$term->value]+=$data['klassHeads'][$ksid][$term->value]['score_total']*$this->grade->behaviour_scheme['KLASS_HEAD'];
                }
                
                if(isset($data['director'][$ksid][$term->value])){
                    //dd($data['director'][$ksid][$term->value]->score);
                    $data['sumDirector'][$ksid][$term->value]=$data['director'][$ksid][$term->value]['score']*$this->grade->behaviour_scheme['DIRECTOR'];
                    $data['sumTerms'][$ksid][$term->value]+=$data['director'][$ksid][$term->value]['score']*$this->grade->behaviour_scheme['DIRECTOR'];
                }
                if(isset($data['adjust'][$ksid][$term->value])){
                    $data['sumAdjust'][$ksid][$term->value]=$data['adjust'][$ksid][$term->value]['score']*$this->grade->behaviour_scheme['ADJUST'];
                    $data['sumTerms'][$ksid][$term->value]+=$data['adjust'][$ksid][$term->value]['score']*$this->grade->behaviour_scheme['ADJUST'];
                }
             
            }
            
        }
        return $data;
    }
    public function promoteTo(){
        return $this->belongsToMany(Student::class,'klass_student','promote_to','student_id')->withPivot(['id as pivot_klass_student_id','student_number','stream','state','promote','promote_to','id as pivot_klass_id']);
    }
    public function courses(){
        return $this->hasMany(Course::class)->with('scoreColumns');
    }
    public function info(){
        return (object)["head"=>"123","subject_head"=>"567"];
    }

    public function coursesStudents(){
        return $this->hasMany(Course::class)->with('students');
    }
    public function coursesScores(){
        return $this->hasMany(Course::class)->with('allScores');
    }
    public function transcriptCoursesScores(){
        return $this->hasMany(Course::class)->where('in_transcript',1)->with('allScores');
        // return $this->hasMany(Course::class)->with('scores')->with('students');
    }
    
    public function transcriptsScores(){
        $students=$this->students;
        $yearTerms=Config::item('year_terms');
        $data=[];
        $data['courses']=$this->courses;
        foreach($students as $student){
            $data['students'][$student->pivot->klass_student_id]=$student;
            foreach($this->courses as $course){
                $std=$course->students->where('id',$student->id)->first();
                if(isset($std)){
                    $courseStudentId=$std->pivot->course_student_id;
                    if(isset($courseStudentId)){
                        foreach($course->scoreColumns as $column){
                            
                            $score=$course->allScores->where('course_student_id',$courseStudentId)->where('score_column_id',$column->id)->first();
                            $data['scores'][$student->pivot->klass_student_id][$course->id][$column->id]=$score;
                        }
                    }
                }else{
                    foreach($course->scoreColumns as $column){
                        $score=Score::make([
                            'course_student_id'=>'0',
                            'score_column_id'=>$column->id,
                            'student_id'=>$student->id,
                            'point'=>null
                        ]);
                        $data['scores'][$student->pivot->klass_student_id][$course->id][$column->id]=$score;
                    }
                }
                
            }
        }
        // dd($data['scores'][316][153][1051]);
        $data['behaviours']=$this->behaviourSummary()['sumTerms'];
        return $data;
        return [
            'students'=>$this->students,
            'behaviours'=>$this->behaviourSummary(),
            'courses'=>$this->courses,
            'scores'=>$this->coursesScores
        ];
         return $this->students;   
    }
    
    // public function outcomes(){
    //     return $this->hasManyThrough(Outcome::class, KlassStudent::class,'klass_id', 'klass_student_id')->with('student');
    // }
    public function students_abilities(){
        return $this->belongsToMany(Student::class)->with('abilities')->withPivot('id as pivot_klass_student_id');
    }

    public function themes(){
        return $this->hasMany(Theme::class)->with('topics');
        //return $this->belongsToMany(Theme::class,'grades','id','grade_year','grade_year','grade_year');
    }
    public function topics(){
        return $this->hasManyThrough(Topic::class, Theme::class);
    }

    public function finalScoresK(){
        $yearTerms=Config::item('year_terms');
        $students=$this->students;
        $habitColumns=array_column(Config::item('habit_columns'),'name');
        //dd($habitColumns);
        foreach($students as $student){
            $habitSum=0;
            $habitYearSum=0;
            $data['students'][$student->pivot->klass_student_id]=$student;
            foreach($yearTerms as $term){
                $habit=Habit::where('klass_student_id',$student->pivot->klass_student_id)->where('term_id',$term->value)->first();
                $data['habits'][$student->pivot->klass_student_id][$term->value]=0;
                if($habit){
                    foreach($habitColumns as $column){
                        $habitSum+=$habit[$column];
                    };
                    $data['habits'][$student->pivot->klass_student_id][$term->value]=$habitSum/count($habitColumns);
                    $habitYearSum+=$habitSum/count($habitColumns);;
                }
            }
            $data['habits'][$student->pivot->klass_student_id][9]=$habitYearSum/count($yearTerms);
            $data['abilities'][$student->pivot->klass_student_id]=array_column(Ability::selectRaw('avg(credit) as total')->where('klass_student_id',$student->pivot->klass_student_id)->get()->toArray(),'total');
        };

        return $data;

    }
    public function finalScores(){
        //passing score with reference_code "passing" in transcript_templates
        $passing=$this->grade->passingScore();
        $coursesScores = $this->transcriptCoursesScores; //all Courses in transcript with scores
        $students = $this->students; //all student in the klass
        $courses = $this->courses->where('in_transcript', 1); //all Courses in the klass with score_columns
        //rebuild all scores in an array, index with student_id, course_id and score_column_id
        $tmpScores = [];
        foreach ($coursesScores as $course) {
            foreach ($course->allScores as $score) {
                ///$tmpScores[$score->student_id][$course->id][$score->score_column_id] = $score->point;
                $tmpScores[$score->student_id][$course->code][$score->score_column_id] = $score->point;
            }
        }
        //generate student list with personal info required in transcript
        //loop all scores in term_id==9 in all courses and put it in student array list
        $data=[];
        foreach ($students as $student) {
            $data['students'][$student->pivot->klass_student_id]=$student;
            $data['scores'][$student->pivot->klass_student_id]['fail_units']=0;

            foreach ($courses as $course) {
                $scoreColumn = $course->scoreColumns->where('term_id', 9)->first();
                if (isset($tmpScores[$student->id][$course->code][$scoreColumn->id])) {
                    ///$data['scores'][$student->pivot->klass_student_id][$scoreColumn->id]['score']=$tmpScores[$student->id][$course->id][$scoreColumn->id];
                    //dd($scoreColumn->id);
                    //dd($tmpScores[$student->id][$course->code]);
                    // dd($course->code);
                    // dd($data['scores'][$student->pivot->klass_student_id]);
                    $data['scores'][$student->pivot->klass_student_id][$course->code]['score']=$tmpScores[$student->id][$course->code][$scoreColumn->id];
                    if($tmpScores[$student->id][$course->code][$scoreColumn->id]<=$passing){
                        $data['scores'][$student->pivot->klass_student_id]['fail_units']++;
                    }
                } else { //if the student is not in the course
                    ///$data['scores'][$student->pivot->klass_student_id][$scoreColumn->id]['score'] = '--';
                    $data['scores'][$student->pivot->klass_student_id][$course->code]['score'] = '--';
                }
                $scoreColumn['course_code'] = $course->code;
                $scoreColumn['course_title'] = $course->title_zh;
                $scoreColumn['course_unit'] = $course->unit;
                $scoreColumn['makeups']=$course->studentsMakeups();
                ///$data['score_columns'][$scoreColumn->id]=$scoreColumn;
                $data['score_columns'][$course->code]=$scoreColumn;
            }
        }
        return $data;
    }

    public function additives($category=null,$termId=null){
        $students=$this->students;
        if($category==null){
            $templates=AdditiveTemplate::all();
        }else{
            $templates=AdditiveTemplate::where('category',$category)->get();
        }
        
        $data=[];
        foreach($students as $student){
            $ksid=$student->pivot->klass_student_id;
            $data['students'][$ksid]['name_zh']=$student->name_zh;
            $data['students'][$ksid]['klass_student_id']=$ksid;
            $data['students'][$ksid]['student_number']=$student->pivot->student_number;
            foreach($templates as $template){
                $data['additives'][$student->pivot->klass_student_id][$template->reference_code]=null;
            }
            $additives=Additive::where('klass_student_id',$ksid)
                                ->whereIn('reference_code',array_keys($data['additives'][$ksid]))
                                ->get();
            $data['records'][$ksid]=$additives;
            foreach($templates as $template){
                foreach(Config::item('year_terms') as $term){
                    $data['additives'][$ksid][$template->reference_code][$term->value]=null;
                }
            }
            foreach($additives as $additive){
                    //$data['students'][$student->pivot->klass_student_id]['additives'][$additive->reference_code]+=$additive->value;
                    foreach(Config::item('year_terms') as $term){
                        $abc=Additive::selectRaw('sum(value) as value')
                            ->where('klass_student_id',$ksid)
                            ->where('reference_code',$additive->reference_code)
                            ->where('term_id',$term->value)
                            ->groupBy('term_id')->groupBy('reference_code')
                            ->first();
                        $data['additives'][$ksid][$additive->reference_code][$term->value]=$abc?$abc->value:null;
                    }
            }
        };
        $data['templates']=array_column($templates->toArray(),null,'reference_code'); 
        return $data;
    }

    public function habits(){
        return $this->hasManyThrough(Habit::class,KlassStudent::class,'klass_id','klass_student_id');
    }
    public function studentsHabits(){
        $students=$this->students;
        $yearTerms=Config::item('year_terms');
        $habits=[];
        foreach($this->habits as $habit){
            $habits[$habit->klass_student_id][$habit->term_id]=$habit;
        }
        foreach($students as $student){
            foreach($yearTerms as $term){
                $student->habits=$habits[$student->pivot->klass_student_id];
            };
        }
        return $students;
    }
    public function habitsScores(){
        $students=$this->students;
        $yearTerms=Config::item('year_terms');
        $habitColumns=array_fill_keys(array_column(Config::item('habit_columns'),'name'),null);
       
        $data=[];
        foreach($students as $student){
            $data['students'][$student->pivot->klass_student_id]=$student;
            foreach($yearTerms as $term){
                $score=Habit::where('klass_student_id',$student->pivot->klass_student_id)->where('term_id',$term->value)->first();
                if($score){
                    $data['scores'][$student->pivot->klass_student_id][$term->value]=Habit::where('klass_student_id',$student->pivot->klass_student_id)->where('term_id',$term->value)->first();
                }else{
                    //dd($student->pivot->klass_student_id);
                    $habitColumns['klass_student_id']=$student->pivot->klass_student_id;
                    $habitColumns['term_id']=$term->value;
                    $data['scores'][$student->pivot->klass_student_id][$term->value]=Habit::forceCreate($habitColumns);
                }
            }
        }
        return $data;
    }
    public function abilities(){
        return $this->hasManyThrough(Ability::class,KlassStudent::class,'klass_id','klass_student_id');
    }

    public function abilitiesScores(){
        $students=$this->students;
        $themes=$this->themes;
        $topics=$this->topics;
        $abilities=[];
        $data=[];
        foreach($students as $student){
            $data['students'][$student->pivot->klass_student_id]=$student;
                foreach($topics as $topic){
                    $data['scores'][$student->pivot->klass_student_id][$topic->id]=Ability::firstOrCreate([
                        'klass_student_id'=>$student->pivot->klass_student_id,
                        'topic_id'=>$topic->id,
                        'term_id'=>$topic->theme->term_id
                    ]);
                }
        }

    //    dd($data['abilities'][1]);
       return $data;
    }

    public function reportAbilities(){
        $documentFileName = "fun.pdf";
 
        // Create the mPDF document
        $document = new PDF( [
            'mode' => 'utf-8',
            'format' => 'A4',
            'margin_header' => '3',
            'margin_top' => '20',
            'margin_bottom' => '20',
            'margin_footer' => '2',
        ]);     
 
        // Set some header informations for output
        $header = [
            'Content-Type' => 'application/pdf',
            'Content-Disposition' => 'inline; filename="'.$documentFileName.'"'
        ];
 
        // Write some simple Content
        $document->WriteHTML('<h1 style="color:blue">TheCodingJack</h1>');
        $document->WriteHTML('<p>Write something, just for fun!</p>');
        // Save PDF on your public storage 
        Storage::disk('public')->put($documentFileName, $document->Output($documentFileName, "S"));
         
        // Get file back from storage with the give header informations
        //return ['fileName'=>$documentFileName,'document'=>$document,'header'=>$header];
        return Storage::disk('public')->download($documentFileName, 'Request', $header); 
    }

    public function healthcares(){
        return $this->hasMany(Healthcare::class);
    }
}