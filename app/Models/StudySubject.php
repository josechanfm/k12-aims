<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class StudySubject extends Model
{
    use HasFactory;
    protected $orderBy = 'order_num';
    protected $orderDirection = 'asc';

    protected $table='study_subject';
    protected $fillable = ['is_letter', 'elective', 'main','stream','type', 'unit','in_transcript','order_num'];
    protected $casts=['subject_head_ids'=>'array'];
    
   function subject(){
        return $this->belongsTo(Subject::class);
   }
}
