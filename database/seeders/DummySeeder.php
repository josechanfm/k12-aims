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
    public function run()
    {

        $currentYear=date('Y');
        //Year::query()->update(['current_year'=>false]);
        $year=Year::where('code',$currentYear)->first();
        if(empty($year)){
            $year=Year::create([
                'code'=>$currentYear,
                'title'=>$currentYear.'-'.($currentYear+1),
                'start'=>$currentYear.'-09-01',
                'end'=>($currentYear+1).'-06-30',
                'current_year'=>1,
                'current_term'=>1,
                'active'=>1
            ]);
        };

        $this->call([
            StudentSeeder::class,
            GradeSeeder::class, 
            //KlassSeeder::class
        ]);


    }
}
