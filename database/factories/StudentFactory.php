<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Student>
 */
class StudentFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition()
    {
        return [
            'name_c' => $this->faker->name,
            'name_p' => $this->faker->firstname,
            'sex' => $this->faker->randomElement(['M','F']),
            'b_date' => $this->faker->dateTimeBetween('2000-09-01','2015-09-01')->format('Y-m-d'),
            // 'id_type' => $this->faker->randomElement(['永久性澳門居民身份證','非永久性澳門居民身份證']),
            // 'id_no' => $this->faker->random(10000000,99999999),
            // 'i_place' => '澳門',
            // 'i_date' => $this->faker->dateTimeBetween('2000-09-01','2015-09-01')->format('Y-m-d'),
            // 'v_date' => $this->faker->dateTimeBetween('2000-09-01','2015-09-01')->format('Y-m-d'),
            // 's6_type' => $this->faker->randomElement([1,2,3]),     
        ];
    }
}
