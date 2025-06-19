<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Klass;
use App\Models\Course;

class LockController extends Controller
{
    public function klassCourses($klass){
        Course::whereBelongsTo($klass)->update(['current_term',0]);
    }
    public function course($courseId, $termId){
        $course=Course::find($courseId);
        $klass=$course->klass;
        if($klass->course_locked){
            return redirect()->back()->withErrors(['message'=>'未具權限,整個班別的科目已被鎖定.']);
        }

        $course->current_term=$termId;
        $course->save();
        $count=$klass->courses->where('current_term',$termId)->count();
        if($klass->course_count==$count){
            $klass->current_term=$termId;
            $klass->save();
        }else{
            $klass->current_term=0;
            $klass->save();
        }
        return redirect()->back();
    }
    public function klass($klassId, $termId){
        
        $klass=Klass::find($klassId);
        if($termId!=0){ //班別下所有科目同時修改學段,同時更新班別current_term
            Course::whereBelongsTo($klass)->update(['current_term'=>$termId]);
            $klass->current_term=$termId;
            $klass->save();
        }else{//班別上鎖,科目不可以修改學段
            
            if($klass->course_locked){
                Course::whereBelongsTo($klass)->update(['current_term'=>$klass->current_term]);
            }else{
                Course::whereBelongsTo($klass)->update(['current_term'=>0]);
            }
            $klass->course_locked= !$klass->course_locked;
            $klass->save();
        }
        return redirect()->back();
    }
}
