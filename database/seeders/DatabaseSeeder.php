<?php

namespace Database\Seeders;

// use Illuminate\Database\Console\Seeds\WithoutModelEvents;

use App\Models\Extracurricular;
use App\Models\Manual;
use App\Models\Subject;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        $this->call([
            UserSeeder::class,
            AdminSeeder::class,
            GuardianSeeder::class,
            StaffSeeder::class,
            TeacherSeeder::class,

            ConfigSeeder::class,
            StudySeeder::class,
            ThemeTemplateSeeder::class,
            TopicTemplateSeeder::class,
            TranscriptTemplateSeeder::class,
            AdditiveTemplateSeeder::class,

            SupplierSeeder::class,
            LocationSeeder::class,
            YearSeeder::class,
            ManualSeeder::class
            // YearSeeder::class,
            // KlassSeeder::class,
            // ThemeSeeder::class,
            // ScoreColumnSeeder::class,

            //SubjectTemplateSeeder::class,
            //KlassStudentSeeder::class,
            //CourseSeeder::class,
            //TranscriptSeeder::class,
            
            //ScoreSeeder::class,
            //ProcedureSeeder::class,
            //ExtracurricularSeeder::class,
        ]);
        // \App\Models\User::factory(10)->create();

        // \App\Models\User::factory()->create([
        //     'name' => 'Test User',
        //     'email' => 'test@example.com',
        // ]);
    }
}
