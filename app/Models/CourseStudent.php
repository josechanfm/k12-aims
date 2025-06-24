<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CourseStudent extends Model
{
    use HasFactory;
    protected $table='course_student';

    
    public function scores()
    {
        return $this->hasMany(Score::class, 'course_student_id');
    }

    public function course(){
        return $this->belongsTo(Course::class);
    }
}
