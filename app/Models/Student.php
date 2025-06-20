<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Spatie\MediaLibrary\HasMedia;
use Spatie\MediaLibrary\InteractsWithMedia;
use Spatie\MediaLibrary\MediaCollections\Models\Media;
use Spatie\Image\Manipulations;
use Illuminate\Support\Str;

class Student extends Model implements HasMedia
{
    use HasFactory;
    use InteractsWithMedia;
    protected $hidden = ['created_at','updated_at'];

    protected $fillable = [
        'stud_id',
        'code',
        'name_c',
        'name_p',
        'sex',
        'b_date', 
        'b_place',
        'id_type',
        'id_no',
        'i_place',
        'i_date',
        'v_date',
        's6_type',
        's6_idate',
        's6_vdate',
        'nation',
        'origin',
        'tel',
        'mobile',
        'area',
        'postal_code',
        'road',
        'address',
        'sleep_same',
        'r_area',
        'ra_desc',
        's_road',
        's_address',
        'father',
        'mother',
        'f_prof',
        'm_prof',
        'guard',
        'live_same',
        'ec_name',
        'ec_rel',
        'ec_tel',
        'ec_area',
        'ec_postal_code',
        'ec_road',
        'ec_address',
        's_code',
        'grade',
        'class',
        'c_no',
        'g_name',
        'g_relation',
        'g_profession',
        'g_area',
        'g_postal_code',
        'g_road',
        'g_address',
        'g_tel',
        'guardmobile' //
    ];
    
    // 建議添加的日期轉換和類型轉換
    protected $dates = [
        'n_date',
        'i_date',
        'v_date',
        's6_idate',
        's6_vdate'
    ];

    public static function boot(){
        parent::boot();
        self::creating(function($model){
            $model->stud_id=Str::uuid();
        });
        static::created(function($model){
            $num=substr('00000'.$model->id,-5);
            $model->stud_id=Config::item('suid_prefix').$num.'-'.$model->checkDigit($num);
            $model->save();
        });
    }
    private function checkDigit($num){
        $odd=(($num[0]+9)+($num[2]+8)+($num[4]+7)) % 11;
        $even=(($num[1]+6)*($num[3]+5)*($odd+4)) % 11;
        return ($odd+$even) % 10;
    }

    public function registerMediaConversions(Media $media = null): void
    {
        $this
            ->addMediaConversion('preview')
            ->fit(Manipulations::FIT_CROP, 300, 300)
            ->nonQueued();
    }
    public function registerMediaCollections(): void
    {
        $this->addMediaCollection('avatar')
            ->singleFile()
            ->useDisk('profile');
        $this->addMediaCollection('transcript')
            ->singleFile()
            ->useDisk('profile');
    }
    public function avatars(){
        $klassStudents=KlassStudent::where('student_id',$this->id)->orderBy('id','DESC')->get();
        $avatars=[];
        foreach($klassStudents as $i=>$ks){
            $avatars[]=[
                'full_tag'=>$ks->klass->tag.substr('00'.$ks->student_number,-2),
                'student_name'=>$ks->student->name_zh,
                'student_number'=>$ks->student_number,
                'klass_student_id'=>$ks->id,
                'avatar'=>$ks->getMedia('avatar')->first(),
            ];
        }
        return $avatars;
    }
    public function treatments(){
        return $this->hasMany(Treatment::class);
    }
    public function klasses(){
        return $this->belongsToMany(Klass::class)->withPivot('student_number')->orderBy('klass_student.created_at','DESC');
    }
    public function klassStudents(){
        return $this->hasMany(KlassStudent::class);
    }
    public function klassStudentWithAvatar(){
        $klassStudent=$this->hasOne(KlassStudent::class);
        return $klassStudent->getMedia('avatar')->first();
    }
    public function courses(){
        return $this->belongsToMany(Course::class,'course_student')->withPivot('id as course_student_id');
    }
    public function scores(){
        return $this->hasManyThrough(Score::class, CourseStudent::class, 'course_id','course_student_id');
        // return $this->belongsToMany(Student::class,'course_student')->withPivot('id as pivot_course_student_id');
    }

    // public function coursesScores(){
    //     return $this->belongsToMany(Course::class,'course_student')->with('scores');
    // }
    public function address(){
        return $this->morphOne(Address::class, 'addressable');
    }
    public function detail(){
        return $this->hasOne(Detail::class);
    }
    public function health(){
        return $this->hasOne(Health::class);
    }
    public function identity_documents(){
        $documents=$this->morphMany(IdentityDocument::class, 'identity_documentable')->get()->toArray();
        return array_column($documents,null,'document_type');
    }
    public function identity_document(){
        return $this->morphOne(IdentityDocument::class, 'identity_documentable')->latestOfMany();
    }
    public function bank(){
        return $this->morphOne(Bank::class, 'bankable');
    }
    public function parents()
    {
        return $this->hasMany(Relative::class)->whereIn('relation',['FATHER','MOTHER'])->orderBy('relation','DESC');
    }
    public function relatives(){
        return $this->hasMany(Relative::class)->orderBy('relation','DESC');
    }
    public function guardians()
    {
        return $this->hasMany(Relative::class)->whereIn('relation',['GUARDIAN']);
    }

    public function guardiansWithRelatives()
    {
        return $this->belongsToMany(Guardian::class)->with('students')->withPivot('relationship');
    }
    
    // public function guardian()
    // {
    //     return $this->hasOne(Guardian::class)->latestOfMany();
    // }
    public function medicnote(){
        return $this->hasOne(Medicnote::class);
    }
    public function abilities(){
        return $this->hasManyThrough(Ability::class, KlassStudent::class, 'student_id','klass_student_id')->with('topic');
    }
    public function archives(){
        $klassStudent=$this->hasOne(KlassStudent::class)->first();
        return $klassStudent->archives;
    }
    public function activities(){
        return $this->belongsToMany(Student::class);
    }
    public function klassStudent(){
        return $this->hasOne(KlassStudent::class)->latestOfMany();
    }
    public static function getBehaviours($klassStudentId, $terms,$actor='SUBJECT'){
        //dd('klassStudentId',$klassStudentId,'staff',$staff);
        $behaviours=[];
        $staff=auth()->user()->staff;
        
        foreach($terms as $term){
            $tmp=Behaviour::where('klass_student_id',$klassStudentId)
            ->where('term_id',$term->value)
            ->whereNot('actor','ADJUST')
            ->where('staff_id',$staff->id)->first();
            if(empty($tmp)){
                // dd('is empty'.$klassStudentId.$term->value);
                $tmp=Behaviour::make([
                    'klass_student_id'=>$klassStudentId,
                    'term_id'=>$term->value,
                    'staff_id'=>$staff->id,
                    'actor'=>$actor,
                    'score'=>null
                ]);
            }
            $adjust=Behaviour::where('klass_student_id',$klassStudentId)->where('term_id',$term->value)->where('actor','ADJUST')->first();
            if(empty($adjust)){
                // dd('is empty'.$klassStudentId.$term->value);
                $adjust=Behaviour::make([
                    'klass_student_id'=>$klassStudentId,
                    'term_id'=>$term->value,
                    'staff_id'=>$staff->id,
                    'actor'=>'ADJUST',
                    'score'=>null
                ]);
            }

            $behaviours[$term->value]['staff']=$tmp;
            $behaviours[$term->value]['all']=Behaviour::where('klass_student_id',$klassStudentId)->where('term_id',$term->value)->orderBy('created_at','DESC')->get();
            $behaviours[$term->value]['total']=Behaviour::where('klass_student_id',$klassStudentId)->where('term_id',$term->value)->sum('score');
            $behaviours[$term->value]['adjust']=$adjust;
        }
        return $behaviours;
    }

    public function siblings(){
        if($this->sibling_uuid){
            return Student::where('sibling_uuid',$this->sibling_uuid)->with('guardians')->with('klasses')->get();
        }
        return null;
        
    }

    public function newStudents(){
        return $this->klasses->count();
    }

 
    public static function excelKeys(){
        $studentKeys=[
            'suid','name_zh','name_fn','name_display','gender','dob','pob','pob_other','nationality','native','religion',
            'sid','id_num','id_type','id_type_other','id_issue','id_expired','hrc_num','hrc_issue','hrc_expired','dsedj_num','ssm_num',
            'entry_date','previour_school','previour_grade','start_klass',
            'phone','phone_sms','phone_home'
        ];
        $guardianKeys=['relation','kinship','name_zh','name_fn','birth_year','age','organization','occupation','mobile'];
        $studentKeys= array_map(function($v){return "students-".$v;},$studentKeys);
        $allGuardianKeys= [];
        foreach(['father','mother','guardian'] as $kinship){
            $allGuardianKeys=[...$allGuardianKeys,...array_map(function($v)use($kinship){return "relatives-"."$kinship-".$v;},$guardianKeys)];
        }
        //
        //
        $allKeys=[...$studentKeys,...$allGuardianKeys];
        return [ 'keys'=>[...$studentKeys,...$allGuardianKeys] ,
                'zh'=> array_map(function($v){return __($v);},$allKeys)
            ];
    }
}
