<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Year;
use App\Models\Grade;
use App\Models\Klass;
use App\Models\Config;

class GradeController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        $yearId=$request->input('yearId');
        if($yearId){
            $year=Year::find($yearId);
        }else{
            $year=Year::where('active',1)->orderBy('start','DESC')->first();
        }
        return redirect('admin/grades/year/'.$year->id);
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
        $grade=new Grade;
        $grade->year_id=$request->year_id;
        $grade->sequence=$request->sequence;
        $grade->initial=$request->initial;
        $grade->level=$request->level;
        $grade->tag=$request->initial.$request->level;
        $grade->title_zh=$request->title_zh;
        $grade->title_en=$request->title_en;
        $grade->description=$request->description;
        $grade->version=$request->version;
        $grade->active=$request->active;
        $grade->save();
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
        $grade=Grade::find($id);
        $klasses=Klass::whereBelongsTo(Grade::find($id))->get();
        echo json_encode($grade);
        echo json_encode($klasses);
        echo $klasses->count();
        if($klasses->count()>0){
            echo 'true';
        }else{
            echo 'false';
        };
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
        if($request->has('id')){
            $grade=Grade::find($id);
            $grade->year_id=1;
            // $grade->sequence=$request->sequence;
            // $grade->initial=$request->initial;
            // $grade->initial=$request->level;
            // $grade->tag=$request->initial.$request->level;
            $grade->title_zh=$request->title_zh;
            $grade->title_en=$request->title_en;
            $grade->description=$request->description;
            $grade->version=$request->version;
            $grade->active=$request->active;
            $grade->update($request->all());
        }
        return redirect()->back();
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        if(Klass::whereBelongsTo(Grade::find($id))->get()->count()>0){
            return redirect()->back()->withErrors(['message'=>'Could not delete, foreign key used in Klass table.']);
        }else{
            //Grade::destroy($id);
            return redirect()->back();    
        }
    }

    public function year($yearId){
        $year=Year::find($yearId);
        $grades=Grade::whereBelongsTo($year)->orderBy('sequence')->get();
        return Inertia::render('Admin/GradesYear',[
            'year'=>$year,
            'grades'=>$grades,
            'gradeCategories'=>Config::item('grade_categories'),
            'gradeLevels'=>Config::item('grade_levels'),
        ]);
    }
}
