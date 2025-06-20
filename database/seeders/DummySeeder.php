<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Config;
use App\Models\Year;
use App\Models\Course;

class DummySeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run($year=null)
    {
        $this->call([
            StudentSeeder::class,
        ]);
        $years=Year::all();
        foreach($years as $year){
            $this->call(GradeSeeder::class, false, ['year'=>$year]);
        }


    }
}
