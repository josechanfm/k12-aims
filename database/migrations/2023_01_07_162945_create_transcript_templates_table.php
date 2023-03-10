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
        Schema::create('transcript_templates', function (Blueprint $table) {
            $table->id();
            $table->enum('category',['PERSONAL','SUBJECT','ATTITUDE','SUMMARY','GENERAL']);
            $table->string('field_name');
            $table->string('title_zh')->nullable();
            $table->string('title_en')->nullable();
            $table->string('subject_code')->nullable();
            $table->text('remark')->nullable();
            $table->integer('version')->nullable();
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
        Schema::dropIfExists('transcript_templates');
    }
};
