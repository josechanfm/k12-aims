<?php

use Illuminate\Foundation\Application;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;
use App\Http\Controllers\SupplierController;
use App\Http\Controllers\PaymentSpaController;
use App\Http\Controllers\YearController;
use App\Http\Controllers\SubjectController;
use App\Http\Controllers\CourseController;
use App\Http\Controllers\KlassController;
use App\Http\Controllers\YearPlan\YearPlanController;
use App\Http\Controllers\YearPlan\PromotionController;
/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/


Route::get('/', function () {
    return Inertia::render('Welcome', [
        'canLogin' => Route::has('login'),
        'canRegister' => Route::has('register'),
        'laravelVersion' => Application::VERSION,
        'phpVersion' => PHP_VERSION,
    ]);
});

Route::middleware([
    'auth:sanctum',
    config('jetstream.auth_session'),
    'verified',
])->group(function () {
    Route::get('/dashboard', function () {
        return Inertia::render('Dashboard');
    })->name('dashboard');
    Route::get('/admin',function(){
        return Inertia::render('Admin/Panel');
    })->name('admin');
    Route::get('/settings',function(){
        return Inertia::render('Admin/Settings');
    })->name('settings');
    Route::resource('/supplier',SupplierController::class);
});

Route::get('/test',function(){
    return Inertia::render('Welcome');
});

Route::resource('/payments',PaymentSpaController::class);
Route::resource('/years',YearController::class);
Route::resource('/subjects',SubjectController::class);
Route::resource('/courses',CourseController::class);
Route::resource('/klasses',KlassController::class);
Route::get('/year/klass/disciplines/{klassId}',[KlassController::class,'disciplines']);
Route::get('/year/klasses/{yearId}',[YearController::class,'year']);
Route::get('/year/subjects/{yearId}',[YearController::class,'subjects']);

Route::resource('/promotion',PromotionController::class);
Route::get('/promotion/klass/{klassId}',[PromotionController::class,'klass']);
Route::get('/promotion/grade/{gradeId}',[PromotionController::class,'grade']);

Route::prefix('year_plan')->group(function(){
    Route::resource('/dashboard',YearPlanController::class);
});

