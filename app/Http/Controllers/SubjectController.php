<?php

namespace App\Http\Controllers;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Subject;
use Illuminate\Support\Facades\Validator;

class SubjectController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $data = Subject::paginate(5);
        //return response()->json($data);
        return Inertia::render('Master/Subjects',['subjects'=>$data]);
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
            'abbr' => ['required'],
            'title_zh' => ['required'],
            'title_en' => ['required'],
            'type' => ['required'],
        ])->validate();

        Subject::create($request->all());
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
        Validator::make($request->all(), [
            'abbr' => ['required'],
            'title_zh' => ['required'],
            'title_en' => ['required'],
            'type' => ['required'],
        ])->validate();
        
        if($request->has('id')){
            $subject=Subject::find($id);
            $subject->abbr=$request->abbr;
            $subject->title_zh=$request->title_zh;
            $subject->title_en=$request->title_en;
            $subject->type=$request->type?$request->type:'';
            $subject->description=$request->description?$request->title_zh:'';
            $subject->save();
            //return response()->json($subject);
            return redirect()->back();
            //return redirect()->back();
            //return redirect()->route('settings');
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
        $subject=Subject::find($id);
        if($subject){
            $subject->delete();
            return redirect()->back()
                ->with('message', 'Blog Delete Successfully');

        }
        
    }
}
