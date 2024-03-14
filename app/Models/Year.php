<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class Year extends Model
{
    use HasFactory;
    use \Staudenmeir\EloquentHasManyDeep\HasRelationships;

    protected $fillable=['code','title','description','meta','start','end','current_term','active'];
    protected $appends=['grade_group'];
    
    public function getGradeGroupAttribute(){
        return Grade::where('year_id',$this->id)->groupBy('initial')->select('initial',DB::raw("count(*) as count"))->get();
    }
    public function kGrades(){
        return $this->hasMany(Grade::class)->where('grade_year','<=',3);        
    }
    public function grades(){
        return $this->hasMany(Grade::class);
    }
    public function klasses(){
        return $this->hasManyThrough(Klass::class, Grade::class);
    }
    public function gradesklasses(){
        return $this->hasMany(Grade::class)->with('klasses');
    }
    public static function nextYear($yearId){
        $year=Year::find($yearId);
        return Year::where('start','>',$year->start)->orderBy('start','ASC')->first();
    }
    public static function currentYear(){
        return Year::where('active',1)->orderBy('start','DESC')->first();
    }
    public static function currentTerm(){
        $yearTerms=array_column(Config::item('year_terms'),null,'value');
        return $yearTerms[Year::currentYear()->current_term];
    }
    public function courses(){
        return $this->hasManyThrough(Course::class, Klass::class);
    }
    public function students(){
        return $this->hasManyDeepFromRelations($this->klasses(),(new Klass())->students());
    }
    public function autoGenerate($data){
        $gradeLetters=array_column(Config::item('grade_letters'),null,'value');
        $kklass=$data['kklass'];
        $kgrade=$data['kgrade'];
        $pklass=$data['pklass'];
        $pgrade=$data['pgrade'];
        $sklass=$data['sklass'];
        $sgrade=$data['sgrade'];

        $gradeYear=1; 
        $letters=['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','W','X','Y','Z'];
        for($i=1;$i<=$kgrade;$i++){ //$i is going to transfer to letter
            //$grade=new Grade;
            $g['year_id']=$this->id;
            $g['initial']=$gradeLetters[$gradeYear]->initial;
            $g['grade_year']=$gradeYear++;
            $g['level']=$i;
            $g['tag']=$g['initial'].($i);
            $g['title_zh']=$g['initial'].($i).'班';
            $g['transcript_template_id']=Config::item('transcript_template');
            $g['behaviour_scheme']=json_encode(Config::item('behaviour_scheme'));
            $g['active']=1;
            $grade=Grade::create($g);
            $k=[];
            for($j=1;$j<=$kklass;$j++){
                $k['grade_id']=$grade->id;
                $k['letter']=$letters[$j-1];
                $k['tag']=$grade->tag.$letters[$j-1];
                $k['study_id']=Study::where('active',true)->where('grade_year',$grade->grade_year)->latest()->first()->id??1;
                Klass::create($k);
            }
        }
        $gradeYear=4;
        for($i=1;$i<=$pgrade;$i++){
            $g['year_id']=$this->id;
            $g['initial']=$gradeLetters[$gradeYear]->initial;
            $g['grade_year']=$gradeYear++;
            $g['initial']='P';
            $g['level']=$i;
            $g['tag']=$g['initial'].($i);
            $g['title_zh']=$g['initial'].($i).'班';
            $g['active']=1;
            $g['transcript_template_id']=Config::item('transcript_template');
            $g['behaviour_scheme']=json_encode(Config::item('behaviour_scheme'));
            $grade=Grade::create($g);
            $k=[];
            for($j=1;$j<=$pklass;$j++){
                $k['grade_id']=$grade->id;
                $k['letter']=$letters[$j-1];
                $k['tag']=$grade->tag.$letters[$j-1];
                $k['study_id']=Study::where('active',true)->where('grade_year',$grade->grade_year)->latest()->first()->id??1;
                Klass::create($k);
            }
        }
        $gradeYear=10;
        for($i=1;$i<=$sgrade;$i++){
            $g['year_id']=$this->id;
            $g['initial']=$gradeLetters[$gradeYear]->initial;
            $g['grade_year']=$gradeYear++;
            $g['level']=$i;
            $g['tag']=$g['initial'].($i);
            $g['title_zh']=$g['initial'].($i).'班';
            $g['active']=1;
            $g['transcript_template_id']=Config::item('transcript_template');
            $g['behaviour_scheme']=json_encode(Config::item('behaviour_scheme'));
            $grade=Grade::create($g);
            $k=[];
            for($j=1;$j<=$sklass;$j++){
                $k['grade_id']=$grade->id;
                $k['letter']=$letters[$j-1];
                $k['tag']=$grade->tag.$letters[$j-1];
                $k['study_id']=Study::where('active',true)->where('grade_year',$grade->grade_year)->latest()->first()->id??1;
                Klass::create($k);
            }
        }

    }


    
}
