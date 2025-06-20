<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Year;
use App\Models\Grade;
use App\Models\Course;
use App\Services\StatisticService;

class StatisticController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $currentYear=Year::currentYear();
        $course=Course::find(1);
        $student=$course->students()->first();
        $statisticService=new StatisticService();
        $statisticService->studentCourse($student, $course);
        dd($course, $course->students()->first(), $course->studentsScores()[229]);
        return Inertia::render('Admin/Statistic/Dashboard',[
            'currentYear'=>$currentYear,
            'grades'=>Grade::with('klasses')->whereBelongsTo($currentYear)->get(),
        ]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}
