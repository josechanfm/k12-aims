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
        Schema::create('grades', function (Blueprint $table) {
            $table->id();
            $table->foreignId('year_id')->constrained('years')->onDelete('restrict')->onUpdate('cascade');
            $table->integer('grade_year');
            $table->char('initial',2);
            $table->integer('level');           
            $table->integer('klass_count')->nullable(); 
            $table->string('tag',5)->nullable();
            $table->string('title_zh')->nullable();
            $table->string('title_en')->nullable();
            $table->text('description')->nullable();
            $table->foreignId('transcript_template_id');
            $table->text('behaviour_scheme')->nullable();
            $table->integer('version')->nullable();
            $table->boolean('transcript_locked')->default(false);
            $table->boolean('active')->default(true);
            $table->timestamps();
            $table->unique(['year_id', 'grade_year']);

        });

    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('grades');
    }
};
