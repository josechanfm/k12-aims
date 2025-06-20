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

            $table->string('stud_id')->unique()->comment('學校內學生代號');
            $table->string('code')->nullable()->comment('學生代碼');
            $table->string('name_c')->nullable()->comment('中文姓名');
            $table->string('name_p')->nullable()->comment('葡文姓名');
            $table->string('sex')->nullable()->comment('性別');
            $table->date('b_date')->nullable()->comment('出生日期');
            $table->integer('b_place')->nullable()->comment('出生地代碼');
            $table->string('id_type')->nullable()->comment('證件類型');
            $table->string('id_no')->nullable()->comment('證件號碼');
            $table->integer('i_place')->nullable()->comment('發證地點代碼');
            $table->date('i_date')->nullable()->comment('發證日期');
            $table->date('v_date')->nullable()->comment('證件有效期');
            $table->integer('s6_type')->nullable()->comment('逗留許可');
            $table->date('s6_idate')->nullable()->comment('逗留許可發出日期');
            $table->date('s6_vdate')->nullable()->comment('學逗留許可有效日期');
            $table->integer('nation')->nullable()->comment('國籍代碼');
            $table->string('origin')->nullable()->comment('籍貫');
            $table->string('tel')->nullable()->comment('電話號碼');
            $table->string('mobile')->nullable()->comment('手機號碼');
            $table->string('area')->nullable()->comment('居住區域代碼');
            $table->string('postal_code')->nullable()->comment('郵遞區號');
            $table->string('road')->nullable()->comment('住址街名');
            $table->string('address')->nullable()->comment('住址門牌、大廈、層數、座');
            $table->integer('sleep_same')->nullable()->comment('課日晚上於同一地址住宿？（0/1）');
            $table->string('r_area')->nullable()->comment('夜間住宿區域代碼');
            $table->string('ra_desc')->nullable()->comment('夜間住宿地區');
            $table->string('s_road')->nullable()->comment('夜間住宿的街道名稱');
            $table->string('s_address')->nullable()->comment('夜間住宿的門牌、大廈、樓、座');
            $table->string('father')->nullable()->comment('父親姓名');
            $table->string('mother')->nullable()->comment('母親姓名');
            $table->string('f_prof')->nullable()->comment('父親職業');
            $table->string('m_prof')->nullable()->comment('母親職業');
            $table->string('guard')->nullable()->comment('與監護人關係（O=其他監護人）');
            $table->boolean('live_same')->nullable()->comment('監護人同住標記（0=不同住）');

            // 緊急聯絡人
            $table->string('ec_name')->nullable()->comment('緊急聯絡人姓名');
            $table->string('ec_rel')->nullable()->comment('緊急聯絡人與學生之關係');
            $table->string('ec_tel')->nullable()->comment('緊急聯絡人電話號碼');
            $table->string('ec_area')->nullable()->comment('緊急聯絡人居住地區');
            $table->string('ec_postal_code')->nullable()->comment('緊急聯絡人郵遞區號');
            $table->string('ec_road')->nullable()->comment('緊急聯絡人住址街名');
            $table->string('ec_address')->nullable()->comment('緊急聯絡人住址門牌、大廈、層數、座');

            $table->string('s_code')->nullable()->comment('學校代碼');
            $table->string('grade')->nullable()->comment('年級');
            $table->string('class')->nullable()->comment('班級');
            $table->string('c_no')->nullable()->comment('座號');

            // 當 guard=‘O’時需填寫
            $table->string('g_name')->nullable()->comment('監護人姓名');
            $table->string('g_relation')->nullable()->comment('監護關係');
            $table->string('g_profession')->nullable()->comment('監護人職業');

            // 當 live_same=0 時需填寫
            $table->string('g_area')->nullable()->comment('監護人區域');
            $table->string('g_postal_code')->nullable()->comment('監護人郵遞區號');
            $table->string('g_road')->nullable()->comment('監護人道路名稱');
            $table->string('g_address')->nullable()->comment('監護人詳細地址');
            $table->string('g_tel')->nullable()->comment('監護人電話');
            $table->string('guardmobile')->nullable()->comment('監護人手機號碼');
            
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
