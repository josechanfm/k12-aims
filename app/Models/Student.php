<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Student extends Model
{
    use HasFactory;
    protected $fillable=['name_zh','name_fn','gender','dob'];

    // public function klasses(){
    //     return $this->belongsToMany(Klass::class,'klass_students','student_id','klass_id');
    // }
    // public static function scores(){
    //     return $this->hasManyThrough(Score::class, KlassStudent::class);
    // }

    
    public function addresses(){
        return $this->morphMany(Address::class, 'addressable');
    }

    public function address(){
        return $this->morphOne(Address::class, 'addressable')->latestOfMany();
    }
    public function identity_document(){
        return $this->morphOne(IdentityDocument::class, 'identity_documentable')->latestOfMany();
    }
    public function bank(){
        return $this->morphOne(Bank::class, 'bankable')->latestOfMany();
    }
    public function detail(){
        return $this->hasOne(StudentDetail::class);
    }
    public function parent()
    {
        return $this->hasOne(Parental::class);
    }
    public function guardians()
    {
        return $this->hasMany(Guardian::class);
    }
    public function guardian()
    {
        return $this->hasOne(Guardian::class)->latestOfMany();
    }
    public function healthcare(){
        return $this->hasOne(Healthcare::class);
    }
}
