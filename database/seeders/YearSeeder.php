<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use App\Models\Year;

class YearSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $firstYear=date('Y')-12;
        $lastYear=date('Y');
        for($y=$firstYear; $y<$lastYear; $y++){
            $year=Year::create([
                'code'=>$y,
                'title'=>$y.'-'.($y+1),
                'start'=>$y.'-09-01',
                'end'=>($y+1).'-06-30',
                'current_year'=>0,
                'current_term'=>1,
                'active'=>0
            ]);
            $this->call(StudySeeder::class, false, ['year'=>$year]);

        }
        $year->update([
            'current_year'=>true,
            'active'=>true
        ]);

        return true;

    }
}
