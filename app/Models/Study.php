<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Study extends Model
{
    use HasFactory;
    protected $fillable=['grade_year','version','sequence','title_zh','title_en','stream','active','description'];

    public function subjects(){
        return $this->belongsToMany(Subject::class)
        ->orderBy('sort_num', 'ASC')
        ->withPivot(['id','subject_head_ids','unit','main','type','stream','is_letter','elective','sort_num']);
    }
    static function versions(){
        //$versions=Study::select('version as value','version as label')->groupBy('version')->get();
        $versions=Study::select('version as value')->groupBy('version')->get();
        $versions[]=["value"=>$versions->count()+1];
        return $versions;
    }
}
