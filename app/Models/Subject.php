<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Subject extends Model
{
    use \Staudenmeir\EloquentHasManyDeep\HasRelationships;

    use HasFactory;
    
  
    public function studys(){
        return $this->belongsToMany(Study::class)->withPivot('subject_head_ids');
    }

    public function studySubject(){
        return $this->hasMany( StudySubject::class);
    }
}
