<?php

namespace App\Observers;
use App\Models\Config;
use App\Models\Study;
use App\Models\Klass;
use App\Models\Course;
use App\Models\ScoreColumn;
use App\Models\ThemeTemplate;
use App\Models\Theme;
use App\Models\Topic;

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
        //幼稚園一至三年級
        if($klass->grade->grade_year <= 3){
            $themeTemplates=ThemeTemplate::select('term_id','sequence','title','description')->where('grade_year',$klass->grade->grade_year)->orderBy('term_id')->orderBy('sequence')->get();
            foreach($themeTemplates as $themeTemplate){
                $theme=$klass->themes()->create($themeTemplate->toArray());
                // $theme=Theme::create([
                //     'klass_id'=>$klass->id,
                //     'term_id'=>$themeTemplate->term_id,
                //     'sequence'=>$themeTemplate->sequence,
                //     'title'=>$themeTemplate->title,
                //     'description'=>$themeTemplate->description
                // ]);
                $topicTemplates=$themeTemplate->topicTemplates;
                foreach($topicTemplates as $topicTemplate){
                    $theme->topics()->create($topicTemplate->toArray());
                    // Topic::create([
                    //     'theme_id'=>$theme->id,
                    //     'sequence'=>$topicTemplate->sequence,
                    //     'ability_code'=>$topicTemplate->ability_code,
                    //     'ability'=>$topicTemplate->ability,
                    //     'abbr'=>$topicTemplate->abbr,
                    //     'title'=>$topicTemplate->title,
                    //     'description'=>$topicTemplate->description
                    // ]);
                }
            }
            return true;
        }
        //如果沒有學習計劃
        if(empty($klass->study_id)){
            return false;
        };
        //小學至中學學習計劃,
        $subjects=Study::find($klass->study_id)->subjects;
        $fields=[];
        $data=[];
        foreach($subjects as $subject){
            $fields['klass_id']=$klass->id;
            $fields['study_subject_id']=$subject->pivot->id;
            $fields['active']=true;
            $data[]=$fields;
        }
        Course::upsert(
            $data,
            ['klass_id','code'],
            []
        );
        $courses=Course::whereBelongsTo($klass)->get();
        $scoreTemplate=json_decode(Config::where('key','score_template')->first()->value);
        
        foreach($courses as $course){
            // if(property_exists($scoreTemplate,$course->score_column_template)){
                //foreach($scoreTemplate->{$course->score_column_template} as $score){
                $x='A';
                foreach($scoreTemplate->term as $i=>$score){
                    $score_column = new ScoreColumn;
                    $score_column->term_id=$score->term_id;
                    $score_column->course_id=$course->id;
                    $score_column->sequence=$i+1;
                    $score_column->column_letter=$x++;
                    $score_column->field_name=$score->value;
                    $score_column->field_label=$score->label;
                    $score_column->is_total=$score->is_total;
                    $score_column->for_transcript=true;
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

