<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use App\Models\Year;
use App\Models\Study;
use App\Models\Subject;

class SubjectSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run($year=null)
    {
        if($year==null){
            $year=Year::currentYear();
        }
        $data=[
            ['code'=>'NAT', 'title_zh'=>'科學', 'title_en'=>'Nature Science',   'in_transcript'=>'1',   'active'=>'1', 'version'=> '1'],
            ['code'=>'MAN', 'title_zh'=>'普通話', 'title_en'=>'Mandarin',   'in_transcript'=>'1',   'active'=>'1', 'version'=> '1'],
            ['code'=>'HIS', 'title_zh'=>'歷史', 'title_en'=>'History',   'in_transcript'=>'1',   'active'=>'1', 'version'=> '1'],
            ['code'=>'GEO', 'title_zh'=>'地理', 'title_en'=>'Geography',   'in_transcript'=>'0',  'active'=>'1', 'version'=> '1'],
            ['code'=>'RED', 'title_zh'=>'閱讀', 'title_en'=>'Reading',   'in_transcript'=>'0',  'active'=>'1', 'version'=> '1'],
            ['code'=>'VAR', 'title_zh'=>'視覺藝術', 'title_en'=>'Visual Art',   'in_transcript'=>'1',   'active'=>'1', 'version'=> '1'],
            ['code'=>'MUS', 'title_zh'=>'音樂', 'title_en'=>'Music',   'in_transcript'=>'1',   'active'=>'1', 'version'=> '1'],
            ['code'=>'MAT', 'title_zh'=>'數學', 'title_en'=>'mathematic',   'in_transcript'=>'1',   'active'=>'1', 'version'=> '1'],
            ['code'=>'ENG', 'title_zh'=>'英語', 'title_en'=>'English',   'in_transcript'=>'1',   'active'=>'1', 'version'=> '1'],
            ['code'=>'PED', 'title_zh'=>'體育', 'title_en'=>'Physical Education',   'in_transcript'=>'1',   'active'=>'1', 'version'=> '1'],
            ['code'=>'REL', 'title_zh'=>'宗教', 'title_en'=>'Religious Education',   'in_transcript'=>'1',   'active'=>'1', 'version'=> '1'],
            ['code'=>'CED', 'title_zh'=>'公民', 'title_en'=>'Civic Education',   'in_transcript'=>'1',   'active'=>'1', 'version'=> '1'],
            ['code'=>'CHI', 'title_zh'=>'中國語文', 'title_en'=>'Chinese Literature',   'in_transcript'=>'1',   'active'=>'1', 'version'=> '1'],
            ['code'=>'ICT', 'title_zh'=>'資訊科技', 'title_en'=>'Information and Communication Technology',   'in_transcript'=>'1',   'active'=>'1', 'version'=> '1']
        ];
        foreach($data as $d){
            Subject::create($d);
        }

    }
}
