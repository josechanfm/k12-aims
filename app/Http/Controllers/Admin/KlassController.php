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
use App\Models\Staff;
use App\Models\Topic;
use Illuminate\Support\Facades\Validator;

class KlassController extends Controller
{
    public function list(){
        $grade=Grade::with('year')->whereBelongsTo(Year::currentYear())->first();
        return redirect()->route('admin.grade.klasses.index',$grade);

    }
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Grade $grade){
        $grade->year;
        $grades=Grade::where('year_id',$grade->year_id)->get();
        $klasses=Klass::with('grade')->whereBelongsTo($grade)->get();
        $studies=Study::where('active',1)->get();
        return Inertia::render('Admin/GradeKlasses',[
            'yearTerms'=>Config::item('year_terms'),
            'grade'=>$grade,
            'grades'=>$grades,
            'klasses'=>$klasses,
            'klassLetters'=>Config::item('klass_letters'),
            'studyStreams'=>Config::item('study_streams'),
            'studies'=>$studies,
            'teachers'=>Staff::teachers()
        ]);        

        // if($request->gid){
        //     $grade=Grade::with('year')->find($request->gid);
        // }else{
        //     $grade=Grade::with('year')->whereBelongsTo(Year::currentYear())->first();
        // }
        // return redirect()->route('admin.grade.klasses',$grade);
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
    public function store(Grade $grade, Request $request)
    {
        Validator::make($request->all(), [
            'grade_id' => ['required'],
            'letter' => ['required'],
        ])->validate();
        $klass=new Klass;
        $klass->grade_id=$request->grade_id;
        $klass->letter=$request->letter;
        $klass->stream=$request->stream;
        $klass->study_id=Study::where('active',true)->where('grade_year',$grade->grade_year)->latest()->first()->id;
        $klass->room=$request->room;
        $klass->tag=Grade::find($request->grade_id)->tag.$request->letter;
        //$klass->study_id=$request->study_id;
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
    public function update(Grade $grade, Klass $klass, Request $request)
    {
       
        Validator::make($request->all(), [
            'grade_id' => ['required'],
            'letter' => ['required'],
        ])->validate();
        
        if($request->has('id')){
            $input=$request->all();
            $input['tag']=Grade::find($request->grade_id)->tag.$request->letter;
            $klass->update($input);
            // $klass->grade_id=$request->grade_id;
            // $klass->letter=$request->letter;
            // $klass->stream=$request->stream;
            // $klass->room=$request->room;
            // $klass->tag=Grade::find($request->grade_id)->tag.$request->letter;
            // $klass->klass_head_ids=$request->klass_head_ids;
            // $klass->save();
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

    public function courses(Klass $klass){
        //$klass=Klass::find($klassId);
        // $courses=Course::whereBelongsTo($klass)->with('staffs')->get();
        // return Inertia::render('Admin/KlassCourses',[
        //     'klass'=>$klass,
        //     'courses'=>$courses,
        //     'teachers'=>Staff::all()
        //     //'subjects'=>$subjects
        // ]);
    }
    // public function students(Klass $klass){
    //     $klassStudents=$klass->students;
    //     $courses=$klass->courses;
    //     $coursesStudents=$klass->coursesStudents;
    //     $dataTable=[];
    //     $dataColumns=[];

    //     //Create student course dataTable array table with initial value of false/0 and dataColumns header
    //     foreach($courses as $course){
    //         $dataColumns[]=[
    //             'title'=>$course->title_zh,
    //             'dataIndex'=>$course->id
    //         ];
    //         foreach($klassStudents as $student){
    //             $dataTable[$student->id]['student_name']=$student->name_zh;
    //             $dataTable[$student->id]['courses'][$course->id]=0;
    //         }
    //     }
    //     //Assign value (True/1) to dataTable array 
    //     foreach($coursesStudents as $course){
    //         foreach($course->students as $student){
    //             $dataTable[$student->id]['courses'][$course->id]=1;
    //         }
    //     }

    //     return Inertia::render('Admin/KlassStudents',[
    //         'dataTable'=>$dataTable,
    //         'dataColumns'=>$dataColumns,
    //         'klass'=>Klass::where('id',$klass->id)->with('courses')->first(),
    //         'students'=>$klass->students()->with('courses')->get(),
    //         'courses'=>$klass->courses
    //     ]);
    // }
    
    function syncGradeKlass(Request $request,$yearId){
        $klassLetters=Config::item('klass_letters');
        $year=Year::where('id',$yearId)->with(['grades','studies'])->first();
         foreach($year->grades as $grade){
             $studiesObj=[];
             if( $year->studies){
                $studiesObj=array_column(  $year->studies->toArray(),'id','grade_year');
            }
            foreach(  array_slice( $klassLetters,0,$grade->klass_count??0 ) as $letter ){
                 $grade->klasses()->updateOrCreate(
                    ['letter' =>$letter->label], 
                    [ 'study_id'=>$studiesObj[$grade->grade_year]??null ,
                        'tag'=>$grade->title_en.$letter->label, 'by_name'=>$grade->title_zh.$letter->value    ]
                );
            }
         }
         //delete klasses
        $year=Year::where('id',$yearId)->with(['grades','grades.klasses'])->first();
         foreach($year->grades as $grade ){
            foreach($grade->klasses as $klass){
                $letters= array_column(array_slice( $klassLetters,0,$grade->klass_count??0 ),'label' ) ;
                  if( !in_array( $klass->letter,$letters) && $klass->student_count==0){
                        $klass->delete();
                  }
            }
         }
    }
}
