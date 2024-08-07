<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Config;
use App\Models\Klass;
use App\Models\Topic;

class TopicController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $abilities=array_column(Config::item('topic_abilities'),'label','value');
        dd($abilities['health']);
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
    public function store(Klass $klass, Request $request)
    {
        
        $data=$request->all();
        $data['sequence']=Topic::where('theme_id',$request->theme_id)->get()->count()+1;
        
        $abilities=array_column(Config::item('topic_abilities'),'label','value');
        $data['ability']=$abilities[$request->ability_code];
        Topic::create($data);
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
    public function update(Klass $klass, Topic $topic, Request $request)
    {   
        $topic->update($request->all());
        return redirect()->back();
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy(Klass $klass, Topic $topic)
    {
        if($topic->abilities->count()>0){
            return redirect()->back()->withErrors(['message'=>'The selected topic had been associated, could not delete.']);
        }else{
            $topic->delete();
            return redirect()->back();
        }

    }
}
