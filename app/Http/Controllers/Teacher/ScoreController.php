<?php

namespace App\Http\Controllers\Teacher;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Config;
use App\Models\Year;
use App\Models\Course;
use App\Models\Klass;
use App\Models\Score;
use App\Models\ScoreColumn;


class ScoreController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function byCourse(Course $course){

        $studentsScores=$course->studentsScores();
        $scoreColumns=$course->scoreColumns;
        // dd($scoreColumns);
        $course=Course::with('klass')->with('teachers')->find($course->id);
        return Inertia::render('Director/Score',[
            'yearTerms'=>Config::item('year_terms'),
            'course'=>$course,
            'scoreColumns'=>$scoreColumns,
            'studentsScores'=>$studentsScores
        ]);

    }
    public function index(Course $course)
    {
        $this->authorize('scores',$course);
        $klassCourses=Klass::find($course->klass_id)->courses;
        $course=Course::with('klass')->find($course->id);
        //dd($course, $klassCourses, $course->scoreColumns,$course->studentsScores());
        return Inertia::render('Teacher/CourseScores',[
            'yearTerms'=>Config::item('year_terms'),
            'course'=>$course,
            'scoreColumns'=>$course->scoreColumns,
            'studentsScores'=>$course->studentsScores(),
            'klassCourses'=>$klassCourses
        ]);
        return redirect()->back();
        //return redirect()->route('director.course.score',$request->cid);
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
    public function store(Request $request)
    {
        //
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
    public function update(Course $course, Score $score, Request $request)
    {
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }

    public function batchUpdate(Course $course, Request $request){
        $data = $request->all();
        // dd($data);
        foreach( $data as $student){
            // dd($student['scores']);
            $updatedCount=Score::updateScore($student['scores']);
        }
        // $updatedCount=Score::updateScore($data);
        // $course->upsertMergeScoreColumn();
        return redirect()->back();

    }

    public function finalScoresK(Klass $klass){
        $year=Year::find(Year::currentYear()->id);
        $year->klasses;
        $year->grades;
        //  dd($klass->finalScoresK());
        return Inertia::render('Director/KlassFinalScoresK', [
            'yearTerms'=>Config::item('year_terms'),
            'year'=>$year,
            'klass' => $klass,
            'transcriptTemplates' => $klass->grade->transcriptTemplates(),
            'finalScoresK' => $klass->finalScoresK()
        ]);
    }
    public function finalScores(Klass $klass)
    {
        if($klass->grade->grade_year<=3){
            return redirect()->route('director.klass.finalScoresK',$klass);
        }
        $year=Year::find(Year::currentYear()->id);
        $year->klasses;
        $year->grades;
        //dd($klass, $year, $klass->grade->transcriptTemplates(), $klass->finalScores());
        return Inertia::render('Director/KlassFinalScores', [
            'year'=>$year,
            'klass' => $klass,
            'transcriptTemplates' => $klass->grade->transcriptTemplates(),
            'finalScores' => $klass->finalScores()
        ]);
    }


}
