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
        Schema::create('courses', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('klass_id');
            $table->string('code');
            $table->string('title_zh');
            $table->string('title_en')->nullable();
            $table->string('type',6)->nullable();
            $table->string('stream',6)->nullable();
            $table->string('elective',6)->nullable();
            $table->string('score_column')->nullable();
            $table->text('description')->nullable();
            $table->bigInteger('subject_id')->nullable();
            $table->tinyInteger('active');
            $table->string('socre_scheme')->nullable();
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
        Schema::dropIfExists('courses');
    }
};
