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
        Schema::create('scores', function (Blueprint $table) {
            $table->id();
            $table->foreignId('course_student_id');
            $table->foreignId('score_column_id')->constrained('score_columns')->onUpdate('cascade')->onDelete('restrict');
            $table->foreignId('student_id');
            $table->string('point')->nullable();
            $table->string('remark')->nullable();
            $table->timestamps();
            $table->unique(['course_student_id','score_column_id'],'student_score');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('scores');
    }
};
