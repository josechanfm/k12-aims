<?php

namespace App\Http\Controllers\Director;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Klass;
use App\Models\Course;
use App\Models\Staff;
use App\Models\Config;
use Inertia\Inertia;

class CourseController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
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
        echo 'show';
        return ;
        $courseId=1;
        $course=Course::find($courseId);
        $students=Course::gather_scores($courseId);
        echo $course;
        echo '<hr>';
        echo '*****<br>';
        foreach($students as $student){
            echo  $student;
            echo '<hr>';
        }
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

    // public function getByKlassId($klassId){
    //     //$courses=Klass::find($klassId)->courses;
    //     $courses=Course::where('klass_id',$klassId)->where('type','SUB')->with('teachers')->get();
    //     echo $courses;
    // }

    // public function byKlass(Klass $klass){
    //     dd($klass);
    // }

    public function klass(Klass $klass){
        return $klass->courses;
    }

    public function makeups(Course $course){
        // dd($course->studentsMakeups());
        $course->klass; 
        return Inertia::render('Director/CourseMakeups',[
            'course' => $course,
            'students_makeups'=>$course->studentsMakeups()
        ]);

    }

}


