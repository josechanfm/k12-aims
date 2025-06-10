<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Spatie\Permission\Models\Role;
use Spatie\Permission\Models\Permission;
use App\Models\Guardian;
use App\Models\Team;

class GuardianSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
      
        $guardian=Guardian::create([
            'username'=>'guardian',
            'name' => 'Guardian',
            'email' => 'guardian@example.com',
            'password' => Hash::make('password'),
        ]);
        // $guardian->ownedTeams()->save(Team::forceCreate([
        //     'user_id' => $guardian->id,
        //     'name' => explode(' ', $guardian->name, 2)[0]."'s Team",
        //     'personal_team' => true,
        // ]));

    }
}
