<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Course;

class DummyScoreSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $courses=Course::all();
        foreach($courses as $course){
            $students=$course->students()->get();
            $scoreColumns=$course->scoreColumns()->get();
            // dd($students[0]->courses->pluck('course_student_id'), $scoreColumns->pluck('id'));
            foreach($students as $student){
                $studentCourses=$student->courses()->get();
                foreach($studentCourses as $sc){
                    foreach($scoreColumns as $col){
                        $student->scores()->create([
                            'course_student_id'=>$sc->course_student_id,
                            'student_id'=>$student->id,
                            'score_column_id'=>$col->id,
                            'point'=>rand(30,100)
                        ]);

                    }
                }
                
            }
        }

    }
}
