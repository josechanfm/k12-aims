<?php

namespace App\Http\Controllers\Director;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Year;
use App\Models\Grade;
use App\Models\Klass;
use App\Models\Course;
use App\Models\CourseScore;

class GradeController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */

    public function index(Request $request)
    {
        $year=Year::where('active',1)->orderBy('start','DESC')->first();
        if($request->gradeScope){
            switch($request->gradeScope){
                case 'kindergarten':
                    $grades=Grade::where('year_id',$year->id)->where('grade_year','<=',3)->with('klasses')->get();
                    break;
                case 'primary':
                    $grades=Grade::where('year_id',$year->id)->whereBetween('grade_year',[4,9])->with('klasses')->get();
                    break;
                case 'secondary':
                    $grades=Grade::where('year_id',$year->id)->where('grade_year','>',9)->with('klasses')->get();
                    break;
                default:
                $grades=Grade::where('year_id',$year->id)->with('klasses')->get();
            }
        }else{
            $grades=Grade::where('year_id',$year->id)->with('klasses')->get();
        }

        return Inertia::render('Director/Grades',[
            'year'=>$year,
            'grades'=>$grades,
        ]);
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

}
