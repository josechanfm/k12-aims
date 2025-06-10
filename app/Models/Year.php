<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;
use App\Models\Config;

class Year extends Model
{
    use HasFactory;
    use \Staudenmeir\EloquentHasManyDeep\HasRelationships;

    protected $fillable=['code','title','description','meta','start','end','current_year','current_term','active'];
    protected $casts=['current_year'=>'boolean','active'=>'boolean'];
    protected $appends=['grade_group'];
    
    public static function currentYear(){
        return Year::where('current_year',true)->orderBy('start','DESC')->first();
    }
    public static function nextYear($yearId=null){
        if($yearId==null){
            $year=self::currentYear();
        }else{
            $year=Year::find($yearId);
        }
        return Year::where('start','>',$year->start)->orderBy('start','ASC')->first();
    }
    public static function currentTerm(){
        $yearTerms=array_column(Config::item('year_terms'),null,'value');
        return $yearTerms[Year::currentYear()->current_term];
    }
    public function getGradeGroupAttribute(){
        return Grade::where('year_id',$this->id)->groupBy('initial')->select('initial',DB::raw("count(*) as count"))->get();
    }
    public function studies(){
        return $this->hasMany(study::class);        
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
    public function gradesKlasses(){
        return $this->hasMany(Grade::class)->with('klasses');
    }
    public function courses(){
        return $this->hasManyThrough(Course::class, Klass::class);
    }
    public function students(){
        return $this->hasManyDeepFromRelations($this->klasses(),(new Klass())->students());
    }
    public function autoGenerate($data){
        $gradeLetters=array_column(Config::item('grade_years'),null,'value');
        $klass_letter_map=array_column(Config::item('klass_letters'),'value','label');
        
        $kklass=$data['kklass'];
        $kgrade=$data['kgrade'];
        $allKlass=$data['pklass'];
        $allGrade=$data['pgrade'];
        $sklass=$data['sklass'];
        $sgrade=$data['sgrade'];

        $letters=['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','W','X','Y','Z'];
        $klassLetters=array_column(Config::item('klass_letters'),'label');
        //幼稚園一至三年級
        //如果沒有相應學習計劃，study_id設為0
       
        $gradeYear=4;
        for($i=1;$i<=$allGrade;$i++){
            $g['year_id']=$this->id;
            $g['initial']=$gradeLetters[$gradeYear]->initial;
            $g['grade_year']=$gradeYear++;
            $g['initial']='P';
            $g['level']=$i;
            $g['tag']=$g['initial'].($i);
            $g['title_zh']=$g['initial'].($i);
            $g['active']=1;
            $g['transcript_template_id']=Config::item('transcript_template');
            $g['behaviour_scheme']=json_encode(Config::item('behaviour_scheme'));
            $grade=Grade::create($g);
            $k=[];
            for($j=1;$j<=$allKlass;$j++){
                $letter=$klassLetters[$j-1];
                $k['grade_id']=$grade->id;
                $k['letter']=$klassLetters[$j-1];
                $k['tag']=$grade->tag.$klassLetters[$j-1];
                $k['stream']='ALL';
                $k['byname']= $g['title_zh']. $klass_letter_map->$letter??$letter;
                $k['study_id']=Study::where('active',true)->where('grade_year',$grade->grade_year)->latest()->first()->id??0;
                Klass::create($k);
            }
        }
    
    }  
}
