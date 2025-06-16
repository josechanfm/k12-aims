<?php

namespace App\Http\Controllers\Director;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\ScoreColumn;
use App\Models\Score;
use App\Models\Course;
use Illuminate\Database\Eloquent\Factories\Sequence;
use Illuminate\Support\Str;

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
    public function store(Course $course, Request $request)
    {
        // dd($request->all());
        $letter=ScoreColumn::where('course_id',$request->course_id)->orderBy('column_letter','DESC')->first()->column_letter;
        $data=$request->all();
        $data['field_name']=Str::uuid();
        $data['column_letter']=++$letter;
        $data['for_transcript']=false;
        $data['is_total']=false;
        ScoreColumn::create($data);
        Course::find($data['course_id'])->upsertMergeScoreColumn();

        return redirect()->back();
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
