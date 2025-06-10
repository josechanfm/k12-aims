<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Staff extends Model
{
    use HasFactory;
    protected $table='staffs';
    
    public function courses(){
        return $this->belongsToMany(Course::class)->with('klass');
    }
    public function headKlasses(){
        return Klass::whereJsonContains('klass_head_ids',$this->id)->get();
        //return Klass::whereRaw('json_contains(klass_head_ids,'.$this->id.')')->get();
    }
    public function headSubjects(){
        return Course::whereJsonContains('subject_head_ids',$this->id)->with('klass')->get();
        //return Klass::whereRaw('json_contains(klass_head_ids,'.$this->id.')')->get();
    }

    public function coursesBehaviours(){
        return $this->belongsToMany(Course::class)->with('studentsBehaviours');
        //return $this->belongsToMany(Course::class)->with('students')->with('behaviours');
    }

    public static function teachers(){
        return Staff::where('is_teacher', true)->get();
    }

}
