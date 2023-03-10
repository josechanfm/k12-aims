<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Discipline;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Config;
use App\Models\Course;
use App\Models\Klass;
use App\Models\Year;
use App\Models\Grade;
use App\Models\Study;
use Illuminate\Support\Facades\Validator;

class KlassController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        if($request->gid){
            $grade=Grade::with('year')->find($request->gid);
        }else{
            $grade=Grade::with('year')->whereBelongsTo(Year::currentYear())->first();
        }
        return redirect('admin/klasses/grade/'.$grade->id);
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
        Validator::make($request->all(), [
            'grade_id' => ['required'],
            'letter' => ['required'],
        ])->validate();
        $klass=new Klass;
        $klass->grade_id=$request->grade_id;
        $klass->letter=$request->letter;
        $klass->stream=$request->stream;
        $klass->room=$request->room;
        $klass->tag=Grade::find($request->grade_id)->tag.$request->letter;
        $klass->study_id=$request->study_id;
        $klass->save();
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
        $data=Klass::find($id);
        return response()->json($data);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $studySubjects=Study::find(1)->subjects;
        echo json_encode($studySubjects);
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
        Validator::make($request->all(), [
            'grade_id' => ['required'],
            'letter' => ['required'],
        ])->validate();
        
        if($request->has('id')){
            $klass=Klass::find($id);
            $klass->grade_id=$request->grade_id;
            $klass->letter=$request->letter;
            $klass->stream=$request->stream;
            $klass->room=$request->room;
            $klass->tag=Grade::find($request->grade_id)->tag.$request->letter;
            $klass->save();
            return redirect()->back();
        }else{
            return redirect()->back();
        }
    }
    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $klass=Klass::find($id);
        if($klass){
            $klass->delete();
            return redirect()->back()
                ->with('message', 'Blog Delete Successfully');
        }
    }

    public function disciplines($klassId){
        $klass=Klass::find($klassId);
        $disciplines=$klass->subjects;
        // foreach($klass as $subject){
        //     echo $subject->subjects()->get();
        //     echo '<hr>';
        // }
        //return response()->json($klass);
        return Inertia::render('Admin/Klass_disciplines',[
            'klass'=>$klass,
            'disciplines'=>$disciplines,
        ]);
    }

    public function grade($gradeId){
        $grade=Grade::with('year')->find($gradeId);
        //if grade not found return some kind of error...
        $grades=Grade::where('year_id',$grade->year_id)->get();
        $klasses=Klass::with('courses')->whereBelongsTo($grade)->get();
        $studies=Study::all();
        return Inertia::render('Admin/KlassesGrade',[
            'klasses'=>$klasses,
            'grade'=>$grade,
            'grades'=>$grades,
            'klassLetters'=>Config::item('klass_letters'),
            'studyStreams'=>Config::item('study_streams'),
            'studies'=>$studies
        ]);

    }

}
