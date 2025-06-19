<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Student;
use App\Models\Klass;
use App\Models\Course;

class StudentController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    /*
    public function course(Course $course){
        return Inertia::render('Admin/CourseStudents',[
            'course'=>$course,
            'courses'=>$course->klass->courses()->get(),
            'students'=>$course->students()->with('courses')->get(),
        ]);
    }
    */
    /*
    public function klass(Klass $klass){
        // $klass=Klass::find($id);
        $klassStudents=$klass->students;
        $courses=$klass->courses;
        $coursesStudents=$klass->coursesStudents;
        $dataTable=[];
        $dataColumns=[];
        //Create student course dataTable array table with initial value of false/0 and dataColumns header
        foreach($courses as $course){
            $dataColumns[]=[
                'title'=>$course->title_zh,
                'dataIndex'=>$course->id
            ];
            foreach($klassStudents as $student){
                $dataTable[$student->id]['student_name']=$student->name_zh;
                $dataTable[$student->id]['courses'][$course->id]=0;
            }
        }
        //Assign value (True/1) to dataTable array 
        foreach($coursesStudents as $course){
            foreach($course->students as $student){
                $dataTable[$student->id]['courses'][$course->id]=1;
            }
        }

        return Inertia::render('Admin/KlassStudents',[
            'dataTable'=>$dataTable,
            'dataColumns'=>$dataColumns,
            'klass'=>Klass::where('id',$klass->id)->with('courses')->first(),
            'students'=>$klass->students()->with('courses')->get(),
            'courses'=>$klass->courses
        ]);
    
    }
    */


    /*
    public function index2 ($type=null, $id=null){
        if($type==null || $id==null){
            return 'error';
        }
        if($type=='course'){
            $course=Course::find($id);
            return Inertia::render('Admin/CourseStudents',[
                'course'=>$course,
                'courses'=>$course->klass->courses()->get(),
                'students'=>$course->students()->with('courses')->get(),
            ]);
        }else{
            $klass=Klass::find($id);
            $klassStudents=$klass->students;
            $courses=$klass->courses;
            $coursesStudents=$klass->coursesStudents;
            $dataTable=[];
            $dataColumns=[];
    
            //Create student course dataTable array table with initial value of false/0 and dataColumns header
            foreach($courses as $course){
                $dataColumns[]=[
                    'title'=>$course->title_zh,
                    'dataIndex'=>$course->id
                ];
                foreach($klassStudents as $student){
                    $dataTable[$student->id]['student_name']=$student->name_zh;
                    $dataTable[$student->id]['courses'][$course->id]=0;
                }
            }
            //Assign value (True/1) to dataTable array 
            foreach($coursesStudents as $course){
                foreach($course->students as $student){
                    $dataTable[$student->id]['courses'][$course->id]=1;
                }
            }
    
            return Inertia::render('Admin/KlassStudents',[
                'dataTable'=>$dataTable,
                'dataColumns'=>$dataColumns,
                'klass'=>Klass::where('id',$klass->id)->with('courses')->first(),
                'students'=>$klass->students()->with('courses')->get(),
                'courses'=>$klass->courses
            ]);
    
            // $students=Student::paginate(request('per_page'));
            // return Inertia::render('Admin/Student',[
            //     'students'=>$students
            // ]);
    
        }

    }
    */

    public function index(){
        return Inertia::render('Admin/Students',[
            'students'=>Student::paginate()
        ]);
    }
    /*
    public function index(Klass $klass)
    {
        $klassStudents=$klass->students;
        $courses=$klass->courses;
        $coursesStudents=$klass->coursesStudents;
        $dataTable=[];
        $dataColumns=[];

        //Create student course dataTable array table with initial value of false/0 and dataColumns header
        foreach($courses as $course){
            $dataColumns[]=[
                'title'=>$course->title_zh,
                'dataIndex'=>$course->id
            ];
            foreach($klassStudents as $student){
                $dataTable[$student->id]['student_name']=$student->name_zh;
                $dataTable[$student->id]['courses'][$course->id]=0;
            }
        }
        //Assign value (True/1) to dataTable array 
        foreach($coursesStudents as $course){
            foreach($course->students as $student){
                $dataTable[$student->id]['courses'][$course->id]=1;
            }
        }

        return Inertia::render('Admin/KlassStudents',[
            'dataTable'=>$dataTable,
            'dataColumns'=>$dataColumns,
            'klass'=>Klass::where('id',$klass->id)->with('courses')->first(),
            'students'=>$klass->students()->with('courses')->get(),
            'courses'=>$klass->courses
        ]);

        // $students=Student::paginate(request('per_page'));
        // return Inertia::render('Admin/Student',[
        //     'students'=>$students
        // ]);
    }
*/
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
    public function update(Request $request, Student $student)
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

    public function syncCourses(Request $request){
        $student=Student::find($request->student_id);
        $student->courses()->sync($request->courses);
        return redirect()->back();
    }

}
