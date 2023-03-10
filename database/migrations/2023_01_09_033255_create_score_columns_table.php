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
        Schema::create('score_columns', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('term_id');
            $table->bigInteger('course_id')->on('courses')->onDelete('restrict')->onUpdate('cascade');
            $table->integer('sequence')->nullable();
            $table->string('field_name');
            $table->string('field_label');
            $table->string('type')->nullable();
            $table->string('scheme')->nullable();
            $table->string('description')->nullable();
            $table->boolean('for_transcript')->default(false);
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
        Schema::dropIfExists('score_columns');
    }
};
