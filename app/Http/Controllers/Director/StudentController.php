<?php

namespace App\Http\Controllers\Director;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Student;
use App\Models\StudentDetail;
use App\Models\Klass;
use App\Models\Course;
use App\Models\Config;
use App\Models\Relative;
use App\Models\Year;
use App\Models\Grade;
use Illuminate\Support\Str;
use PDO;

class StudentController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function finder(){
        return Inertia::render('Director/StudentFinder',[
            'students'=>Student::all()
        ]);
    }
    public function search(Request $request){
        switch($request->column){
            case 'name_zh':
                $students=Student::whereRaw(
                    "{$request->column} LIKE '%{$request->content}%'"
                )->with('klasses')->with('guardians')->with('guardiansWithRelatives')->get();
                break;
            case 'name_fn':
                $students=Student::whereRaw(
                    "UPPER({$request->column}) LIKE '%".strtoupper($request->content)."%'"
                )->with('klasses')->with('guardians')->get();
                break;
            case 'id_num':
                $students=Student::whereRaw(
                    "UPPER({$request->column}) LIKE '%".strtoupper($request->content)."%'"
                )->with('klasses')->with('guardians')->get();
                break;
            default:
                $students=[];
            }
        return response()->json($students);
        
    }
    // public function selected($model, $id){
    //     if($model=='course'){
    //         $students=Course::find($id)->students;
    //     }
    //     if($model=='klass'){
    //         $students=Klass::find($id)->students;
    //     }
    //     //dd($model, $students);

    //     return Inertia::render('Director/SelectedStudents',[
    //         'students'=>$students
    //     ]);
    // }


    public function index(Klass $klass, Request $request)
    {
        if($klass->id==null){
            //$klass=Klass::whereBelongsTo(Grade::whereBelongsTo(Year::currentYear())->where('grade_year',4)->first())->first();
            return to_route('director.klass.students.index',Klass::whereBelongsTo(Grade::whereBelongsTo(Year::currentYear())->where('grade_year',4)->first())->first());
        };

        return Inertia::render('Director/KlassStudents', [
            'klass' => $klass,
            'students' => $klass->studentsWithAvatar(),
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
    public function show(Student $student)
    {
        //$student->with('address')->with('identity_document')->with('bank')->with('detail')->with('parent')->with('guardian');
        $student->detail;
        $student->address;
        $student->health;
        $student->identity_document;
        $student->bank;
        $student->relatives;
        //$student->guardians;
        //$student->archives=$student->archives();
        $student->medias=$student->klassStudent?$student->klassStudent->media->all():null;
        $student->avatars=$student->avatars();
        $student->siblings=$student->siblings();
        
        return Inertia::render('Director/StudentProfile',[
            'student' => $student,
            'nations' => Config::item('nations'),
            'places' => Config::item('places'),
            'areas' => Config::item('areas'),
            'id_list' => Config::item('id_list'),
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
    public function update(Request $request, Student $student)
    {  
        // if($student->id != $request->id){
        //     return redirect()->back()->withErrors(['code'=>'match','message'=>'Student Id not match.']);
        // }
        // $student->update($request->all());
        // //
        // foreach($request->relatives as $relative){
        //     $student->relatives()->updateOrCreate(['relation'=>$relative['relation']],$relative);
        // }
        // //
     
        // if(isset($request->address['id'])){
        //     $student->address->update($request->address);
        // }else{
        //     $student->address()->create($request->address);
        // }
        // if(isset($request->bank['id'])){
        //     $student->bank->update($request->bank);
        // }else{
        //     $student->bank()->create($request->bank);
        // }
        

        // if(isset($request->detail['id'])){
        //     $student->detail->update($request->detail);
        // }else{
        //     $student->detail()->create($request->detail);
        // }
        // if(isset($request->health['id'])){
        //     $student->health->update($request->health);
        // }else{
        //     $student->health()->create($request->health);
        // }
       
        // return redirect()->back();
        // dd($request->all());
        $student->update($request->all());

        return redirect()->back()->with([
            'student' => $student->fresh(),
            'success' => '學生信息已更新'
        ]);
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

    public function getByKlassId(Klass $klass){
        $students=$klass->students;
        foreach($students as $i=>$student){
            $students[$i]->klass=$student->klasses()->latest()->first();
        }
        return response()->json($students);
    }

    public function getByNames(Request $request){
        //$students=Student::whereIn('name_zh',$request->all())->get();
        //return response()->json($request->all());
        $tmpStudents=Year::currentYear()->students->whereIn('name_zh',$request->all());
        //dd($students);
        foreach($tmpStudents as $std){
            $students[]=$std;
        }
        foreach($students as $i=>$student){
            $students[$i]->klass=$student->klasses()->latest()->first();
        }
        return response()->json($students);
    }

    public function siblings(Student $student){
        $student->klasses;
        return Inertia::render('Director/Siblings',[
                'student'=>$student,
                'siblings'=>$student->siblings()
        ]);
    }

    public function joinSibling(Student $student, Request $request){
        // dd($student->sibling_uuid);
        // dd(Student::find($request->id));
        // dd($request->all());
        if(empty($student->uuid)){
            $student->sibling_uuid=Str::uuid();
            $student->save();
        }
        Student::where('id',$request->id)->update(['sibling_uuid'=>$student->sibling_uuid]);
        return redirect()->back();
    }

}
