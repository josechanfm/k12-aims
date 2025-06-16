<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CourseStaff extends Model
{
    use HasFactory;
    protected $fillable=['staff_id','course_id','behavior'];
}
