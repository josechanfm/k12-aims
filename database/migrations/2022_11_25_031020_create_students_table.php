<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('students', function (Blueprint $table) {
            $table->id();

            $table->string('stud_id')->unique();
            $table->string('code')->nullable();
            $table->string('name_c')->nullable();
            $table->string('name_p')->nullable();
            $table->string('sex')->nullable();
            $table->date('b_date')->nullable();
            $table->integer('b_place')->nullable();
            $table->string('id_type')->nullable();
            $table->string('id_no')->nullable();
            $table->integer('i_place')->nullable();
            $table->date('i_date')->nullable();
            $table->date('v_date')->nullable();
            $table->integer('s6_type')->nullable();
            $table->date('s6_idate')->nullable();
            $table->date('s6_vdate')->nullable();
            $table->integer('nation')->nullable();
            $table->string('origin')->nullable();
            $table->string('tel')->nullable();
            $table->string('mobile')->nullable();
            $table->string('area')->nullable();
            $table->string('postal_code')->nullable();
            $table->string('road')->nullable();
            $table->string('address')->nullable();
            $table->integer('sleep_same')->nullable();
            $table->string('r_area')->nullable();
            $table->string('ra_desc')->nullable();
            $table->string('s_road')->nullable();
            $table->string('s_address')->nullable();
            $table->string('father')->nullable();
            $table->string('mother')->nullable();
            $table->string('f_prof')->nullable();
            $table->string('m_prof')->nullable();
            $table->string('guard')->nullable();
            $table->boolean('live_same')->nullable();
            
            // 緊急聯絡人
            $table->string('ec_name')->nullable();
            $table->string('ec_rel')->nullable();
            $table->string('ec_tel')->nullable();
            $table->string('ec_area')->nullable();
            $table->string('ec_postal_code')->nullable();
            $table->string('ec_road')->nullable();
            $table->string('ec_address')->nullable();
            
            $table->string('s_code')->nullable();
            $table->string('grade')->nullable();
            $table->string('class')->nullable();
            $table->string('c_no')->nullable();

            //當 guard=‘O’時，第 43-45 項需具資料
            $table->string('g_name')->nullable();
            $table->string('g_relation')->nullable();
            $table->string('g_profession')->nullable();
            
            //當 live_same=0 時，第 46-51 必具資料。
            $table->string('g_area')->nullable();
            $table->string('g_postal_code')->nullable();
            $table->string('g_road')->nullable();
            
            $table->string('g_address')->nullable();
            $table->string('g_tel')->nullable();
            $table->string('guardmobile')->nullable(); 
            
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('students');
    }
};
