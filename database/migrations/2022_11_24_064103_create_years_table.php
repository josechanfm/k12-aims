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
        Schema::create('years', function (Blueprint $table) {
            $table->id();
            $table->string('code');
            $table->string('title');
            $table->text('description')->nullable();
            $table->text('meta')->nullable();
            $table->text('transcript')->nullable();
            $table->date('start')->nullable();
            $table->date('end')->nullable();
            $table->boolean('current_year')->default(false);
            $table->tinyinteger('current_term')->default(2);
            $table->boolean('active')->default(true);
            $table->timestamps();
            $table->unique('code');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('years');
    }
};
