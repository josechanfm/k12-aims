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
        Schema::create('klasses', function (Blueprint $table) {
            $table->id();
            $table->foreignId('grade_id')->on('grades')->onDelete('restrict')->onUpdate('cascade');
            $table->char('letter',5)->nullable();
            $table->char('tag',5)->nullable();
            $table->char('stream',5)->nullable();
            $table->foreignId('study_id')->nullable();
            $table->string('byname')->nullable();
            $table->string('room')->nullable();
            $table->string('klass_head_ids')->nullable();
            $table->tinyInteger('current_term')->default(1);
            $table->tinyInteger('lock_courses')->default(0);
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
        Schema::dropIfExists('klasses');
    }
};
