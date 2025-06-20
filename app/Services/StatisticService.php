<?php
namespace App\Services;

class StatisticService
{
    public function studentCourse($student, $course)
    {
        $klasses=$student->klasses;
        dd($klasses[0]->year_code);
        dd($student->klasses, $course);
    }
}