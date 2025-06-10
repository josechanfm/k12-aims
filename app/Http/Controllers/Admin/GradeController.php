<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Year;
use App\Models\Grade;
use App\Models\Klass;
use App\Models\Config;
use App\Models\Study;
use App\Models\Staff;
use App\Models\Topic;
use App\Models\Additive;

class GradeController extends Controller
{
    public function list(){
        return redirect()->route('admin.year.grades.index',Year::currentYear());
    }
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Year $year, Request $request)
    {
        if($request->gradeScope){
            switch($request->gradeScope){
                case 'kindergarten':
                    $grades=Grade::whereBelongsTo($year)->where('grade_year','<=',3)->orderBy('grade_year')->get();
                    break;
                case 'primary':
                    $grades=Grade::whereBelongsTo($year)->whereBetween('grade_year',[4,9])->orderBy('grade_year')->get();
                    break;
                case 'secondary':
                    $grades=Grade::whereBelongsTo($year)->where('grade_year','>',9)->orderBy('grade_year')->get();
                    break;
                default:
                    $grades=Grade::whereBelongsTo($year)->whereBetween('grade_year',[4,9])->orderBy('grade_year')->get();
            }
        }else{
            $grades=Grade::whereBelongsTo($year)->with(['klasses'])->orderBy('grade_year')->get();
        }
        ///
        ///
        return Inertia::render('Admin/YearGrades',[
            'years'=>Year::where('active',true)->get(),
            'year'=>$year,
            'grades'=>$grades,
            'gradeYears'=>Config::item('grade_years'),
            'klassLetters'=>Config::item('klass_letters')
        ]);

        // $yearId=$request->input('yearId');
        // if($yearId){
        //     $year=Year::find($yearId);
        // }else{
        //     $year=Year::where('active',1)->orderBy('start','DESC')->first();
        // }
        // return redirect()->route('admin.year.grades',$year);
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
    public function store(Year $year, Request $request)
    {
        $grade=new Grade;
        $grade->year_id=$request->year_id;
        $grade->grade_year=$request->grade_year;
        $grade->klass_count=$request->klass_count;
        $grade->initial=$request->initial;
        $grade->level=$request->level;
        $grade->tag=$request->initial.$request->level;
        $grade->title_zh=$request->title_zh;
        $grade->title_en=$request->title_en;
        $grade->description=$request->description;
        $grade->transcript_template_id=$request->transcript_template_id;
        $grade->behaviour_scheme=json_encode(Config::item('behaviour_scheme'));
        $grade->version=$request->version;
        $grade->active=$request->active??false;
        $grade->save();
        return redirect()->back();
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show(Year $year, Grade $grade)
    {
       
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
    public function update(Year $year, Grade $grade, Request $request)
    {
        if($request->has('id')){
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
    public function destroy(Year $year, Grade $grade)
    {
        // dd($grade->klasses);
        // dd(Klass::whereBelongsTo($grade)->get());
        //dd($year);
        if(Klass::whereBelongsTo($grade)->get()->count()!==0){
            return redirect()->back()->withErrors(['message'=>'Could not delete, foreign key used in Klass table.']);
        }else{
            $grade->delete();
            return redirect()->back();    
        }
    }



}
