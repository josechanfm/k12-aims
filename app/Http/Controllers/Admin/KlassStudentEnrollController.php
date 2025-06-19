<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Candidate;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Year;
use App\Models\Student;
use App\Models\Klass;

class KlassStudentEnrollController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {   
        $years=Year::get();   
        $yearCode=$_GET['code']??false;
        if($yearCode==false){
            $year=Year::currentYear();    
        }else{
            $year=Year::where('code',$yearCode)->first();    
        }
        $klasses=$year->klasses()->get();
        // $klass_student =$klass_student ;
        $students= Student::get();
        return Inertia::render(
            'Admin/KlassStudentEnroll',[
                'years'=>$years,'klasses'=>$klasses
            ]
        );
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create(Request $request)
    {
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
       
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show(Student $student)
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

    public function studentFinder(Request $request){
        $vailData=$request->validate([
            'yearCode'=>'',
            'klassId'=>'',
            'text'=>'',
        ]);
        $codeList= preg_split('/\n|\r\n?/', $vailData['text']);
        $codeList = array_filter($codeList, function ($d) {
            return $d != '';
        });
        // $codeList=['S00001-4'];
        $yearCode=$vailData['yearCode'];
        $year=Year::where('code',$yearCode)->first();
        $students= Student::select('id','name_c','id_no','stud_id')-> where(function ($query) use ($codeList) {
                                $query->whereIn('id_no', $codeList)
                                    ->orWhereIn('stud_id', $codeList);
                            })
                            ->with(['klasses'=>function($v)use($year){
                                return $v->whereHas('grade',function($grade_q)use($year){
                                    return $grade_q->where('year_id',$year->id);
                                } );
                            }])->get();
        $idnos=array_column( $students->toArray(),'id_no');
        $studIds=array_column( $students->toArray(),'stud_id');
        $codeList=array_filter($codeList,function($v)use($idnos, $studIds){ 
            return !(in_array($v,$idnos)|| in_array($v,$studIds))  ;
         } );
          $codeList=array_values( $codeList);
        return redirect()->back()->with('data',['students'=> $students,'noFoundCodes'=>$codeList]);
    }

    function enrollStudents(Request $request){
        $passStudents=$request->passStudents;
        $yearCode=$request->yearCode;
        $klassId=$request->klassId;
        $klass=Klass::find($klassId);
        $student_ids = Student::whereHas('klasses.grade.year', function ($q) use ($yearCode) {
        $q->where('code', $yearCode);
            })->get()->toArray();
        foreach($passStudents  as $student){
            if( in_array($student['id'],$student_ids)){
                continue;
            }
             $klass->students()->attach([$student['id']]);
        }
        // $year=Year::where('code',$yearCode)->with(['grades','grades.klasses','grades.klasses.students'])->first();
        //dd( $students->toArray());
    }
}
