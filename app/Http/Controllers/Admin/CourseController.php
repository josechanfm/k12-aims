<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Config;
use App\Models\Klass;
use App\Models\Course;
use App\Models\Staff;

class CourseController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Klass $klass) //don't use
    {   
        echo "non using...";
        // $courses=Course::whereBelongsTo($klass)->with('staffs')->get();
        // return Inertia::render('Admin/KlassCourses',[
        //     'yearTerms'=>Config::item('year_terms'),
        //     'klass'=>$klass,
        //     'courses'=>$courses,
        //     'teachers'=>Staff::all()
        //     //'subjects'=>$subjects
        // ]);

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
        //return response()->json($request->all());
        Course::upsert(
            $request->all(),
            ['klass_id','code'],
            ['title_zh','title_en','type','stream','elective']
        );

        Course::whereNotIn('code',array_column($request->all(),'code'))->where('klass_id',$id)->delete();
        return response()->json(["result"=>"done"]);
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

    // public function students(Course $course){

    //     return Inertia::render('Admin/CourseStudents',[
    //         'course'=>$course,
    //         'courses'=>$course->klass->courses()->get(),
    //         'students'=>$course->students()->with('courses')->get(),
    //     ]);
    // }

    public function updateCourseHeadTeachers(Course $course, Request $request){
        $course->subject_head_ids=$request->subject_head_ids;
        $course->save();
        $course->staffs()->sync($request->syncCourseTeachers);
        return redirect()->back();
    }
     public function updateCourseTeachers(Course $course, Request $request){
    
        $course->teachers()->sync($request->teacher_ids);
        return redirect()->back();
    }
    // public function updateCourseTeachers(Course $course, Request $request){
    //     $course->staffs()->sync($request->syncCourseTeacher);
    //     return redirect()->back();
    //     //return response()->json($request->syncCourseTeacher);
    // }

 
}
