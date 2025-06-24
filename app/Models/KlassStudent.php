<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\MorphMany;
use Spatie\MediaLibrary\HasMedia;
use Spatie\MediaLibrary\InteractsWithMedia;
use Spatie\MediaLibrary\MediaCollections\Models\Media;
use Spatie\Image\Manipulations;


class KlassStudent extends Model implements HasMedia
{
    use HasFactory;
    use InteractsWithMedia;
    protected $table='klass_student';
    protected $fillable=['promote_to','klass_id','student_id'];

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

    public function student(){
        return $this->belongsTo(Student::class);
    }

    public function behaviours(){
        return $this->hasMany(Behaviour::class);
    }
    public function klass(){
        return $this->belongsTo(Klass::class)->with('grade');
    }
    public function habits(){
        return $this->hasMany(Habit::class);
    }
    public function avatar(){
        return $this->getMedia('avatar');
    }

    public function archives(){
        return $this->morphMany(Archive::class, 'archivable');
    }

    public function courseStudent(){
       return $this->hasManyThrough(
                CourseStudent::class,
                Course::class,
                'klass_id',        // courses 表的外键
                'course_id',       // course_student 表的外键
                'klass_id',        // klass_student 表的本地键
                'id'               // courses 表的本地键
            )->where('course_student.student_id', $this->student_id);
    }
    public function scores(){
            return $this->hasManyThrough(
                Score::class,
                CourseStudent::class,
                'student_id',       // course_student 表中的外键(指向 students 表)
                'course_student_id', // scores 表中的外键(指向 course_student 表)
                'student_id',       // klass_student 表中的本地键(指向 students 表)
                'id'                // course_student 表中的本地键
            )->whereHas('courseStudent.course', function($query) {
                $query->where('klass_id', $this->klass_id);
            });
     }
}
