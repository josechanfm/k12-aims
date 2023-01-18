<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use App\Models\Year;

class SubjectSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $year=Year::currentYear();
        DB::table('subjects')->insert([
            'grade_id'=>$year->id,
            'code'=>'CHN',
            'title_zh'=>'中文',
            'title_en'=>'Chinese',
            'type'=>'',
            'stream'=>'ART',
            'elective'=>0,
            'active'=>1
        ]);
        DB::table('subjects')->insert([
            'grade_id'=>$year->id,
            'code'=>'ENG',
            'title_zh'=>'英文',
            'title_en'=>'English',
            'type'=>'',
            'stream'=>'ART',
            'elective'=>0,
            'active'=>1
        ]);
        DB::table('subjects')->insert([
            'grade_id'=>$year->id,
            'code'=>'MAT',
            'title_zh'=>'數學',
            'title_en'=>'Mathematic',
            'type'=>'',
            'stream'=>'SCI',
            'elective'=>0,
            'active'=>1
        ]);
        DB::table('subjects')->insert([
            'grade_id'=>$year->id,
            'code'=>'PHY',
            'title_zh'=>'物理',
            'title_en'=>'Physics',
            'type'=>'',
            'stream'=>'SCI',
            'elective'=>1,
            'active'=>1
        ]);
        DB::table('subjects')->insert([
            'grade_id'=>$year->id,
            'code'=>'GEN',
            'title_zh'=>'常識',
            'title_en'=>'General',
            'type'=>'',
            'stream'=>'ART',
            'elective'=>1,
            'active'=>1
        ]);
    }
}
