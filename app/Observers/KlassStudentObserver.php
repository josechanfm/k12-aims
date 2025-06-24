<?php

namespace App\Observers;
use App\Models\Config;
use App\Models\Study;
use App\Models\KlassStudent;
use App\Models\Klass;
use App\Models\Course;
use App\Models\ScoreColumn;
use App\Models\ThemeTemplate;
use App\Models\Theme;
use App\Models\Topic;

class KlassStudentObserver
{
    /**
     * Handle the Klass "created" event.
     *
     * @param  \App\Models\Klass  $klass
     * @return void
     */
    public function created(KlassStudent $klassStudent )
    {
        // dd($klassStudent);
       $student= $klassStudent->student;
       $klass_id=$klassStudent->klass_id;
       $courseIds = Course::where('klass_id', $klass_id)->pluck('id')->toArray();
       $student->courses()->syncWithoutDetaching($courseIds);
    }

    /**
     * Handle the Klass "updated" event.
     *
     * @param  \App\Models\Klass  $klass
     * @return void
     */
    public function updated(KlassStudent $klassStudent )
    {
        //
    }

    /**
     * Handle the Klass "deleted" event.
     *
     * @param  \App\Models\Klass  $klass
     * @return void
     */
    public function deleted(KlassStudent $klassStudent )
    {   
     
    }
    public function deleting (KlassStudent $klassStudent )
    {   
          $klassStudent->scores()->delete();
          $klassStudent->courseStudent()->delete();
       
    }
    /**
     * Handle the Klass "restored" event.
     *
     * @param  \App\Models\Klass  $klass
     * @return void
     */
    public function restored(KlassStudent $klassStudent )
    {
        
    }

    /**
     * Handle the Klass "force deleted" event.
     *
     * @param  \App\Models\Klass  $klass
     * @return void
     */
    public function forceDeleted(KlassStudent $klassStudent )
    {
        //
    }
}

