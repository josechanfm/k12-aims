<?php

namespace App\Observers;
use App\Models\Config;
use App\Models\Klass;
use App\Models\Study;
use App\Models\Course;
use App\Models\ScoreColumn;
use App\Models\ScoreTemplate;

class KlassObserver
{
    /**
     * Handle the Klass "created" event.
     *
     * @param  \App\Models\Klass  $klass
     * @return void
     */
    public function created(Klass $klass)
    {
        //$subjects=Subject::where('grade_id',$klass->grade_id)->get();
        if(empty($klass->study_id)){
            return false;
        };
        $subjects=Study::find($klass->study_id)->subjects;
        $fields=[];
        $data=[];
        foreach($subjects as $subject){
            $fields['klass_id']=$klass->id;
            $fields['code']=$subject->code;
            $fields['title_zh']=$subject->title_zh;
            $fields['title_en']=$subject->title_en;
            $fields['type']=$subject->type;
            $fields['stream']=$subject->pivot->stream;
            $fields['elective']=$subject->pivot->elective;
            $fields['active']=true;
            $data[]=$fields;
        }
        Course::upsert(
            $data,
            ['klass_id','code'],
            ['title_zh','title_en','type','stream','elective','active']
        );

        $courses=Course::whereBelongsTo($klass)->get();
        $scoreTemplate=json_decode(Config::where('key','score_template')->first()->value);
        foreach($courses as $course){
            // if(property_exists($scoreTemplate,$course->score_column_template)){
                //foreach($scoreTemplate->{$course->score_column_template} as $score){
                foreach($scoreTemplate->term as $i=>$score){
                    $score_column = new ScoreColumn;
                    $score_column->term_id=$score->term_id;
                    $score_column->course_id=$course->id;
                    $score_column->sequence=$i;
                    $score_column->field_name=$score->value;
                    $score_column->field_label=$score->label;
                    $score_column->save();
                }
            //}
        }
    }

    /**
     * Handle the Klass "updated" event.
     *
     * @param  \App\Models\Klass  $klass
     * @return void
     */
    public function updated(Klass $klass)
    {
        //
    }

    /**
     * Handle the Klass "deleted" event.
     *
     * @param  \App\Models\Klass  $klass
     * @return void
     */
    public function deleted(Klass $klass)
    {
        Course::where('klass_id',$klass->id)->delete();
    }

    /**
     * Handle the Klass "restored" event.
     *
     * @param  \App\Models\Klass  $klass
     * @return void
     */
    public function restored(Klass $klass)
    {
        
    }

    /**
     * Handle the Klass "force deleted" event.
     *
     * @param  \App\Models\Klass  $klass
     * @return void
     */
    public function forceDeleted(Klass $klass)
    {
        //
    }
}

