<?php

namespace App\Http\Controllers\Director;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\ScoreColumn;
use App\Models\Score;
use App\Models\Course;
use App\Models\Klass;
use App\Models\Subject;
use App\Models\Grade;
use App\Models\Config;
use Illuminate\Database\Eloquent\Factories\Sequence;
use Illuminate\Support\Str;
use Inertia\Inertia;

class ScoreColumnController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return response('you are in score column controller index');
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
        
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */

    public function details(Course $course)
    {
        $klasses = Klass::all();
        $subjects = Subject::all();
        $grades = Grade::all();
        return Inertia::render('Director/ScoreColumnDetails', [
            'terms' => Config::item('year_terms'),
            'klasses' => $klasses,
            'subjects' => $subjects,
            'grades' => $grades,
        ]);
    }

    public function store(Course $course, Request $request)
    {
        $letter=ScoreColumn::where('course_id',$course->id)->orderBy('column_letter','DESC')->first()?->column_letter??'A';
        $data=$request->all();
        $data['field_name']=Str::uuid();
        $data['column_letter']=++$letter;
        $data['for_transcript']=false;
        $data['is_total']=false;

        $scoreColumn = $course->scoreColumns()->create($data);
        // ScoreColumn::create($data);

        $course->upsertMergeScoreColumn();

        return redirect()->back()->with('data',['id' => $scoreColumn->id ]);
    }

    public function batchStore(Request $request){
        $data=$request->all();
        
        foreach($data['course_ids'] as $key => $course_id ){
            
            $letter=ScoreColumn::where('course_id',$course_id)->orderBy('column_letter','DESC')->first()?->column_letter??'A';

            $data['field_name']=Str::uuid();
            $data['column_letter']=++$letter;
            $data['for_transcript']=false;
            $data['is_total']=false;

            $course = Course::find( $course_id);
            $scoreColumn = $course->scoreColumns()->create($data);
            $course->upsertMergeScoreColumn();
        }

        return redirect()->back()->with('data',['id' => 1]);
    }
    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Course $course, ScoreColumn $scoreColumn, Request $request)
    {
        $data=$request->all();
        //dd($data);
        //$scoreColumn=ScoreColumn::find($id);
        $scoreColumn->update($data);
        $scoreColumn->save();
        Course::find($scoreColumn->course_id)->upsertMergeScoreColumn();

        // $this->upsertMergeColumn(
        //     Course::find($scoreColumn->course_id),
        //     $scoreColumn
        // );

        return redirect()->back();
    }

    public function batchUpdate(Request $request){
        $data=$request->all();
        dd($data);
    }

    private function upsertMergeColumn($course,$scoreColumn){
        $tmp=[];
        foreach($course->students as $student){
            $tmp[$student->pivot->student_id]=[
                'course_student_id'=>$student->pivot->course_student_id,
                'score_column_id'=>$scoreColumn->id,
                'student_id'=>$student->pivot->student_id,
                'point'=>0
            ];
        };
        forEach($scoreColumn->merge as $merge){
            $StudentScores=Score::where('score_column_id',$merge['score_column_id'])->get();
            forEach($StudentScores as $score){
                $tmp[$score->student_id]['point']+=($score->point * $merge['percentage'])/100;
            }
        }
        Score::upsert($tmp,['course_student_id','student_id','score_column_id'],['point']);
        return true;
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy(Course $course, ScoreColumn $scoreColumn)
    {
        Score::where('score_column_id',$scoreColumn->id)->delete();
        $scoreColumn->delete();
        return redirect()->back();
    }

    public function course(Course $course){
        return $course->scoreColumns;
    }

    public function getKlassBySubject(Subject $subject){
        $study_subject = $subject->studySubject;
        $course = Course::whereIn('study_subject_id', $study_subject->pluck('id') )->get();
        $klass_id = $course->pluck('klass_id')->unique();
        return Klass::whereIn('id', $klass_id)->get();
    }

    public function getScoreColumn(Subject $subject, Klass $klass)
    {
        $study_subject = $subject->studySubject;
        $course = Course::whereIn('study_subject_id', $study_subject->pluck('id'))
            ->where('klass_id', $klass->id)->first();
        // $course->scoreColumns;
        return $course;
    }
    public function getGradeScoreColumn(Subject $subject, $grade_ids)
    {
        $study_subject = $subject->studySubject;
        $klass = Klass::whereIn('grade_id', explode(",", $grade_ids))->get();
        $course = Course::whereIn('study_subject_id', $study_subject->pluck('id'))
            ->whereIn('klass_id', array_column( $klass->toArray() , 'id'))->get();
        return $course;
    }

    public function reorder(Request $request){
        $records=$request->all();
        $x='A';
        foreach($records as $record){
            ScoreColumn::where('id',$record['id'])
                ->update([
                    'sequence'=>$record['sequence'],
                    'column_letter'=>$x++
                ]);
        }
        return redirect()->back();
    }
    public function update_is_total(Request $request){
        $records=$request->all();
        foreach($records as $record){
            ScoreColumn::where('id',$record['id'])
                ->update(['is_total'=>$record['is_total']]);
        }
        return redirect()->back();
    }
}
