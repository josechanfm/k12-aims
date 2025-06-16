<?php

namespace App\Http\Controllers\Director;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Config;
use App\Models\Year;
use App\Models\Klass;
use App\Models\Student;
use App\Models\Transcript;
use App\Models\Staff;
use App\Models\AdditiveTemplate;

class KlassController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */

    public function index()
    {
        $klass = Klass::with('courses')->find(1);
        //$teacher = Teacher::with('courses')->find(1);
        return response()->json($klass);
        //return response($klass);
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
    public function show(Klass $klass)
    {
        $klass->grade;
        $klass->courses;
        $klass->students;
        return Inertia::render('Director/Klass', [
            'yearTerms'=>Config::item('year_terms'),
            'currentTerm'=>Year::currentTerm(),
            'klass' => $klass,
            'additiveTemplates'=>AdditiveTemplate::all(),
            'additiveStyle'=>Config::item('additive_styles'),
            'additiveGroups'=>Config::item('additive_groups'),
            'teachers'=>Staff::teachers()
        ]);
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
    public function update(Request $request, $id)
    {
        //
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
/*    
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
        return Inertia::render('Director/KlassFinalScores', [
            'year'=>$year,
            'klass' => $klass,
            'transcriptTemplates' => $klass->grade->transcriptTemplates(),
            'finalScores' => $klass->finalScores()
        ]);
    }
*/

    //}
}
