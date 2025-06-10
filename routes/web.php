<?php

use Illuminate\Foundation\Application;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;
use App\Http\Controllers\SupplierController;
use App\Http\Controllers\PaymentSpaController;
use App\Http\Controllers\SubjectController;
use App\Http\Controllers\CourseController;
// use App\Http\Controllers\Admin\KlassController;
// use App\Http\Controllers\Admin\YearController;
// use App\Http\Controllers\Admin\GradeController;
// use App\Http\Controllers\Admin\YearPlanController;
use App\Http\Controllers\Admin\PromotionController;
use Illuminate\Http\Request;
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

Route::get('excel/download_sheet',[App\Http\Controllers\ExcelController::class,'downloadSheet']);

Route::get('excel/read_file',[App\Http\Controllers\ExcelController::class,'readFile']);
Route::get('excel/form1',[App\Http\Controllers\ExcelController::class,'form1']);

Route::get('/', function () {
    return Inertia::render('Welcome', [
        'canLogin' => Route::has('login'),
        'canRegister' => Route::has('register'),
        'laravelVersion' => Application::VERSION,
        'phpVersion' => PHP_VERSION,
    ]);
})->name('home');


Route::get('/manual', function (Request $request) {
    $manual=App\Models\Manual::where('route',$request->route)->first();
    if(empty($manual)){
        $manual=App\Models\Manual::where('route','default')->first();
    }
    return Inertia::render('Manual', [
        'manual' => $manual,
    ]);
})->name('manual');


Route::middleware([
    'auth:sanctum',
    config('jetstream.auth_session'),
    'verified',
])->group(function () {
    Route::get('api/config/item',[App\Http\Controllers\Api\ConfigController::class,'getItem'])->name('api.config.item');
    Route::get('/dashboard', function () {
        return Inertia::render('Dashboard');
    })->name('dashboard');
    Route::get('api/grades_klasses',[App\Http\Controllers\Api\GatherController::class,'gradesKlasses'])->name('api.gradesKlasses');
    Route::get('api/klass_students/{klass}',[App\Http\Controllers\Api\GatherController::class,'klassStudents'])->name('api.klassStudents');
    Route::get('api/student_medical_records/{student}',[App\Http\Controllers\Api\GatherController::class,'studentMedicalRecords'])->name('api.studentMedicalRecords');
    Route::prefix('master')->group(function(){
        Route::resource('/configs',App\Http\Controllers\Master\ConfigController::class);
        Route::resource('/transcriptTemplate',App\Http\Controllers\Master\TranscriptTemplateController::class);
        Route::resource('/users',App\Http\Controllers\Master\UserController::class);
    });
    
});


Route::resource('/payments',PaymentSpaController::class);
Route::resource('/subjects',SubjectController::class);
Route::resource('/courses',CourseController::class);

// Route::middleware([
//     'auth:sanctum',
//     config('jetstream.auth_session'),
//     'verified',
// ])->group(function () {
//     Route::prefix('master')->middleware([ 'checkRole:master'])->group(function(){
Route::group([
    'prefix'=>'/master',
    'middleware'=>[
        'auth:sanctum',
        config('jetstream.auth_session'),
        'verified',
        'role:master|admin'
    ]
],function () {
        Route::resource('/studies',App\Http\Controllers\Master\StudyController::class)->names('master.studies');
        Route::post('/study_subject/sortOrderSubject/{study}',[App\Http\Controllers\Master\StudySubjectController::class,'sortOrderSubject'])->name('master.studySubjects.sortOrder');
        Route::resource('/study_subjects',App\Http\Controllers\Master\StudySubjectController::class)->names('master.studySubjects');
        Route::resource('/subjects',App\Http\Controllers\Master\SubjectController::class)->names('master.subjects');
        Route::resource('/configs',App\Http\Controllers\Master\ConfigController::class)->names('master.configs');
        Route::resource('/transcriptTemplate',App\Http\Controllers\Master\TranscriptTemplateController::class)->names('master.transcriptTemplate');
        Route::resource('/roles',App\Http\Controllers\Master\RoleController::class)->names('master.roles');
        Route::resource('/users',App\Http\Controllers\Master\UserController::class)->names('master.users');
        Route::resource('/theme_templates',App\Http\Controllers\Master\ThemeTemplateController::class)->names('master.themeTemplates');
        Route::resource('/topic_templates',App\Http\Controllers\Master\TopicTemplateController::class)->names('master.topicTemplates');
        Route::resource('/grade/{gradeYear}/theme_templates',App\Http\Controllers\Master\ThemeTemplateController::class)->names('master.grade.themeTemplates');
        Route::resource('/grade/{gradeYear}/topic_templates',App\Http\Controllers\Master\TopicTemplateController::class)->names('master.grade.topicTemplates');
        Route::get('/theme_templates',[App\Http\Controllers\Master\ThemeTemplateController::class,'list'])->name('master.themeTemplates');
        Route::resource('manuals',App\Http\Controllers\Master\ManualController::class)->names('master.manuals');
        Route::resource('issues',App\Http\Controllers\Master\IssueController::class)->names('master.issues');
    });

//admin
Route::group([
    'prefix'=>'/admin',
    'middleware'=>[
        'auth:sanctum',
        config('jetstream.auth_session'),
        'verified',
        'role:master|admin'
    ]
],function () {
    Route::get('/',[App\Http\Controllers\Admin\DashboardController::class,'index'])->name('admin.dashboard');
    Route::resource('staffs',App\Http\Controllers\Admin\StaffController::class)->names('admin.staffs');
    Route::resource('years',App\Http\Controllers\Admin\YearController::class)->names('admin.years');
    Route::resource('registrations',App\Http\Controllers\Admin\RegistrationController::class)->names('admin.registrations');
    //Route::get('year/{year}/grades',[App\Http\Controllers\Admin\YearController::class,'grades'])->name('admin.year.grades');
    Route::resource('enrollments',App\Http\Controllers\Admin\EnrollmentController::class)->names('admin.enrollments');
    Route::resource('candidates',App\Http\Controllers\Admin\CandidateController::class)->names('admin.candidates');
    Route::put('candidate/accepted',[App\Http\Controllers\Admin\CandidateController::class,'accepted'])->name('admin.candidate.accepted');

    Route::resource('year/{year}/grades',App\Http\Controllers\Admin\GradeController::class)->names('admin.year.grades');
    Route::resource('grade/{grade}/klasses',App\Http\Controllers\Admin\KlassController::class)->names('admin.grade.klasses');
    Route::resource('klass/{klass}/themes',App\Http\Controllers\Admin\ThemeController::class)->names('admin.klass.themes');
    Route::resource('klass/{klass}/topics',App\Http\Controllers\Admin\TopicController::class)->names('admin.klass.topics');
    Route::resource('klass/{klass}/courses',App\Http\Controllers\Admin\CourseController::class)->names('admin.klass.courses');
    Route::post('student/sync_courses',[App\Http\Controllers\Admin\StudentController::class,'syncCourses'])->name('admin.klass.syncCourses');

    Route::put('course/{course}/update_curse_teachers',[App\Http\Controllers\Admin\CourseController::class,'updateCourseTeachers'])->name('admin.course.updateCourseTeachers');
    
    Route::get('/klasses',[App\Http\Controllers\Admin\KlassController::class,'list'])->name('admin.klasses');
    Route::get('/grades',[App\Http\Controllers\Admin\GradeController::class,'list'])->name('admin.grades');

    Route::resource('/courses',App\Http\Controllers\Admin\CourseController::class)->names('admin.courses');
    Route::resource('/students',App\Http\Controllers\Admin\StudentController::class)->names('admin.students');
    Route::get('/transcript/lock',[App\Http\Controllers\Admin\TranscriptController::class,'lockTranscripts'])->name('admin.lockTranscripts');
    Route::resource('extracurriculars',App\Http\Controllers\Admin\ExtracurricularController::class)->names('admin.extracurriculars');
    Route::resource('activities',App\Http\Controllers\Admin\ActivityController::class)->names('admin.activities');
    Route::resource('certificates',App\Http\Controllers\Admin\CertificateController::class)->names('admin.certificates');
    Route::get('certificate/print',[App\Http\Controllers\Admin\CertificateController::class,'print'])->name('admin.certificate.print');
    Route::resource('klass/{klass}/behaviours',App\Http\Controllers\Admin\BehaviourController::class)->names('admin.klass.behaviours');

    Route::post('lock/course/{courseId}/{termId}',[\App\Http\Controllers\Admin\LockController::class,'course'])->name('admin.lock.course');
    Route::post('lock/klass/{klassId}/{termId}',[\App\Http\Controllers\Admin\LockController::class,'klass'])->name('admin.lock.klass');

    Route::post('excel/excel_to_students',[App\Http\Controllers\ExcelController::class,'excelToStudents'])->name('admin.excelToStudents');

});
//Route::prefix('manage/')->middleware([ 'checkRole:master|admin|director|teacher'])->group(function(){
//manage
Route::group([
    'prefix'=>'/director',
    'middleware'=>[
        'auth:sanctum',
        config('jetstream.auth_session'),
        'verified',
        'role:master|admin|director|teacher'
    ]
],function () {
        Route::get('/',[App\Http\Controllers\Director\DashboardController::class,'index'])->name('director.dashboard');

        Route::resource('grades',App\Http\Controllers\Director\GradeController::class)->names('director.grades');
        Route::resource('course',App\Http\Controllers\Director\CourseController::class);
        Route::get('/course/{course}/makeups',[App\Http\Controllers\Director\CourseController::class,'makeups'])->name('director.course.makeups');
        Route::get('/klass/{klass}/courses',[App\Http\Controllers\Director\CourseController::class,'klass'])->name('director.klass.courses');

        Route::resource('klasses',App\Http\Controllers\Director\KlassController::class)->names('director.klasses');
        Route::get('/klass_scores/{klassId}',[App\Http\Controllers\Director\KlassController::class,'klass_scores']);

        Route::resource('students',App\Http\Controllers\Director\StudentController::class)->names('director.students');
        
        Route::get('student/finder',[App\Http\Controllers\Director\StudentController::class,'finder'])->name('director.student.finder');
        Route::post('student/search',[App\Http\Controllers\Director\StudentController::class,'search'])->name('director.student.search');
        // Route::get('student/{student}',[App\Http\Controllers\Director\StudentController::class,'show'])->name('director.student');
        Route::get('student/{student}/siblings',[App\Http\Controllers\Director\StudentController::class,'siblings'])->name('director.student.siblings');
        Route::patch('student/{student}/join_sibling',[App\Http\Controllers\Director\StudentController::class,'joinSibling'])->name('director.student.joinSibling');

        Route::resource('klass/{klass}/students',App\Http\Controllers\Director\StudentController::class)->names('director.klass.students');

        Route::get('students/get_by_klass_id/{klass}',[App\Http\Controllers\Director\StudentController::class,'getByKlassId'])->name('director.students.getByKlassId');
        Route::post('students/get_by_names',[App\Http\Controllers\Director\StudentController::class,'getByNames'])->name('director.students.getByNames');
        
        //Route::get('{model}/{id}/students',[App\Http\Controllers\Director\StudentController::class,'selected'])->name('director.selected.students');

        Route::resource('klass/{klass}/behaviours',App\Http\Controllers\Director\BehaviourController::class)->names('director.klass.behaviours');
        Route::get('klass/{klass}/behaviour/adjust',[App\Http\Controllers\Director\BehaviourController::class,'adjust'])->name('director.klass.behaviour.adjust');

        Route::get('/year/{year}/transcripts',[App\Http\Controllers\Director\TranscriptController::class,'yearTranscripts'])->name('director.year.transcripts');
        Route::get('/grade/{grade}/transcripts',[App\Http\Controllers\Director\TranscriptController::class,'gradeTranscripts'])->name('director.grade.transcripts');
        Route::get('/klass/{klass}/transcripts',[App\Http\Controllers\Director\TranscriptController::class,'klass'])->name('director.klass.transcripts');
        Route::get('/klass/{klass}/transcripts/migrate',[App\Http\Controllers\Director\TranscriptController::class,'migrate'])->name('director.klass.transcripts.migrate');
        Route::get('/klass/student/{klassStudent}/transcript',[App\Http\Controllers\Director\TranscriptController::class,'klassStudent'])->name('director.klass.student.transcript');
        Route::get('klass/{klass}/generate_transcripts',[App\Http\Controllers\Director\TranscriptController::class,'generateTranscripts'])->name('director.klass.generateTranscripts');
        
        Route::resource('/teachers',App\Http\Controllers\Director\TeacherController::class)->names('director.teachers');

        //Route::resource('course/{course}/scores',App\Http\Controllers\Director\ScoreController::class)->names('director.course.scores');
        // Route::post('/course/{course}/scores/batch_update',[App\Http\Controllers\Director\ScoreController::class,'batchUpdate'])->name('director.course.scores.batchUpdate');
        Route::get('/klass/{klass}/final_scores',[App\Http\Controllers\Director\ScoreController::class,'finalScores'])->name('director.klass.finalScores');
        
        Route::post('course/{course}/score_column/reorder',[App\Http\Controllers\Director\ScoreColumnController::class,'reorder'])->name('director.course.scoreColumn.reorder');
        Route::resource('course/{course}/score_columns',App\Http\Controllers\Director\ScoreColumnController::class)->names('director.course.scoreColumns');

        Route::post('/makeup/create_or_cancel',[App\Http\Controllers\Director\MakeupController::class,'createOrCancel'])->name('director.makeup.createOrCancel');
        Route::post('/makeup/update',[App\Http\Controllers\Director\MakeupController::class,'update'])->name('director.makeup.update');
        
        Route::resource('additives',App\Http\Controllers\Director\AdditiveController::class)->names('director.additives');
        Route::get('klass/{klass}/additive/{category}',[App\Http\Controllers\Director\AdditiveController::class,'scope'])->name('director.klass.additive');
        Route::get('klass/{klass}/additive_page',[App\Http\Controllers\Director\AdditiveController::class,'page'])->name('director.klass.additive.page');
        Route::get('klass/{klass}/additive_direct',[App\Http\Controllers\Director\AdditiveController::class,'direct'])->name('director.klass.additive.direct');
        Route::post('klass/{klass}/additive_direct_input',[App\Http\Controllers\Director\AdditiveController::class,'directInput'])->name('director.klass.additive.directInput');

        Route::resource('makeups',App\Http\Controllers\Director\MakeupController::class)->names('director.makeups');
        Route::resource('tasks',App\Http\Controllers\Director\TaskController::class)->names('director.tasks');

        Route::resource('activities',App\Http\Controllers\Director\ActivityController::class)->names('director.activities');
        Route::get('activity/{activity}/students',[App\Http\Controllers\Director\ActivityController::class,'students'])->name('director.activity.students');
        Route::put('activity/{activity}/students/sync',[App\Http\Controllers\Director\ActivityController::class,'studentsSync'])->name('director.activity.students.sync');
        Route::get('activity/{activity}/students/scores',[App\Http\Controllers\Director\ActivityController::class,'studentsScores'])->name('director.activity.students.scores');
        Route::put('activity/{activity}/students/scores/update',[App\Http\Controllers\Director\ActivityController::class,'studentsScoresUpdate'])->name('director.activity.students.scores.update');
        Route::get('activity/{activity}/students/scores/report',[App\Http\Controllers\Director\ActivityController::class,'scoreReport'])->name('director.activity.students.scores.report');

        Route::resource('certificates',App\Http\Controllers\Director\CertificateController::class)->names('director.certificates');
        Route::get('certificate/get_by_conditions',[App\Http\Controllers\Director\CertificateController::class,'getByConditions'])->name('director.certificate.getByConditions');

        //Route::get('promotes',[App\Http\Controllers\Director\PromotionController::class,'list'])->name('director.promotes');
        Route::resource('klass/{klass}/promotes',App\Http\Controllers\Director\PromotionController::class)->names('director.klass.promotes');
        

        Route::group(['prefix'=>'pre',],function () {
            Route::get('/klass/{klass}/final_scores',[App\Http\Controllers\Director\Pre\KlassController::class,'finalScores'])->name('director.pre.klass.finalScores');
            Route::resource('/klasses',App\Http\Controllers\Director\Pre\KlassController::class)->names('director.pre.klasses');
            Route::resource('students',App\Http\Controllers\Director\Pre\StudentController::class)->names('director.pre.students');
            Route::get('/klass/{klass}/habits',[App\Http\Controllers\Director\Pre\HabitController::class,'klass'])->name('director.pre.klass.habits');
            Route::put('/klass/{klass}/habits',[App\Http\Controllers\Director\Pre\HabitController::class,'update'])->name('director.pre.klass.habits.update');
            Route::get('/klass/{klass}/habit/export',[App\Http\Controllers\Director\Pre\HabitController::class,'export'])->name('director.pre.klass.habit.export');
            Route::post('/klass/{klass}/habit/import',[App\Http\Controllers\Director\Pre\HabitController::class,'import'])->name('director.pre.klass.habit.import');
            // Route::get('/klass/{klass}/habit/import',function(App\Models\Klass $klass){
            //     return redirect()->route('director.pre.klass.habits',$klass->id);
            // })->name('director.pre.klass.habit.import');
            Route::post('/klass/{klass}/habit/importConfirmed',[App\Http\Controllers\Director\Pre\HabitController::class,'importConfirmed'])->name('director.pre.klass.habit.importConfirmed');

            Route::get('/klass/{klass}/abilities',[App\Http\Controllers\Director\Pre\AbilityController::class,'klass'])->name('director.pre.klass.abilities');
            Route::get('/klass/{klass}/abilities/pdf',[App\Http\Controllers\Director\Pre\AbilityController::class,'pdf'])->name('director.pre.klass.abilities.pdf');
            Route::get('/klass/{klass}/abilities/mpdf',[App\Http\Controllers\Director\Pre\AbilityController::class,'mpdf'])->name('director.pre.klass.abilities.mpdf');
            Route::post('/klass/{klass}/abilities/update',[App\Http\Controllers\Director\Pre\AbilityController::class,'update'])->name('director.pre.klass.abilities.update');
            Route::get('/klass/{klass}/ability/export',[App\Http\Controllers\Director\Pre\AbilityController::class,'export'])->name('director.pre.klass.ability.export');
            Route::post('/klass/{klass}/ability/import',[App\Http\Controllers\Director\Pre\AbilityController::class,'import'])->name('director.pre.klass.ability.import');
            // Route::get('/klass/{klass}/ability/import',function(App\Models\Klass $klass){
            //     return redirect()->route('director.pre.klass.abilities',$klass->id);
            // })->name('director.pre.klass.ability.import');
            Route::post('/klass/{klass}/ability/importConfirmed',[App\Http\Controllers\Director\Pre\AbilityController::class,'importConfirmed'])->name('director.pre.klass.ability.importConfirmed');


            //Route::get('pre/theme/{theme}/student/{klassStudent}/{format?}',[App\Http\Controllers\Director\Pre\StudentController::class,'theme'])->name('director.pre.theme.student');
            Route::get('klass_student/{klassStudent}/theme/{theme}/{format?}',[App\Http\Controllers\Director\Pre\ThemeController::class,'klassStudent'])->name('director.pre.klassStudent.theme');
            Route::get('klass/{klass}/theme/{theme}/{format?}',[App\Http\Controllers\Director\Pre\ThemeController::class,'klass'])->name('director.pre.klass.theme');
            Route::get('klass/{klass}/themes/{format?}',[App\Http\Controllers\Director\Pre\ThemeController::class,'klassSummary'])->name('director.pre.klass.themes');

            Route::resource('klass/{klass}/behaviours',App\Http\Controllers\Director\Pre\BehaviourController::class)->names('director.pre.klass.behaviours');
            Route::get('klass/{klass}/behaviour/adjust',[App\Http\Controllers\Director\BehaviourController::class,'adjust'])->name('director.pre.klass.behaviour.adjust');

            Route::resource('additives',App\Http\Controllers\Director\Pre\AdditiveController::class)->names('director.pre.additives');
            Route::get('klass/{klass}/additive/{category}',[App\Http\Controllers\Director\Pre\AdditiveController::class,'scope'])->name('director.pre.klass.additive');
            Route::get('klass/{klass}/additive_page',[App\Http\Controllers\Director\Pre\AdditiveController::class,'page'])->name('director.pre.klass.additive.page');
            Route::get('klass/{klass}/additive_direct',[App\Http\Controllers\Director\Pre\AdditiveController::class,'direct'])->name('director.pre.klass.additive.direct');
            Route::post('klass/{klass}/additive_direct_input',[App\Http\Controllers\Director\Pre\AdditiveController::class,'directInput'])->name('director.pre.klass.additive.directInput');
    
    
        });        
});

//Route::prefix('teacher/')->group(function(){
Route::group([
    'prefix'=>'/teacher',
    'middleware'=>[
        'auth:sanctum',
        config('jetstream.auth_session'),
        'verified',
        'role:master|admin|director|teacher'
    ]
],function () {        
        Route::get('/',[App\Http\Controllers\Teacher\DashboardController::class,'index'])->name('teacher.dashboard');
        //Route::resource('course/{course}/behaviours',App\Http\Controllers\Teacher\BehaviourController::class)->names('teacher.course.behaviours');
        //Route::get('klass/{klass}/behaviours',[App\Http\Controllers\Teacher\BehaviourController::class,'klass'])->name('teacher.klass.behaviours');
        
        Route::resource('course/{course}/scores',App\Http\Controllers\Teacher\ScoreController::class)->names('teacher.course.scores');
        Route::post('course/{course}/scores/batch_update',[App\Http\Controllers\Teacher\ScoreController::class,'batchUpdate'])->name('teacher.course.scores.batchUpdate');
        Route::get('klass/{klass}/final_scores',[App\Http\Controllers\Teacher\ScoreController::class,'finalScores'])->name('teacher.klass.finalScores');

        Route::resource('avatars',App\Http\Controllers\Teacher\AvatarController::class)->names('teacher.avatars');
        Route::post('avatar/upload',[App\Http\Controllers\Teacher\AvatarController::class,'upload'])->name('teacher.avatar.upload');
        Route::get('student/{student}/avatars',[App\Http\Controllers\Teacher\AvatarController::class,'student'])->name('teacher.student.avatars');
        
        Route::get('klass/{klass}/avatars',[App\Http\Controllers\Teacher\AvatarController::class,'klass'])->name('teacher.klass.avatars');
        
        Route::get('klass/{klass}/courses',[App\Http\Controllers\Teacher\CourseController::class,'index'])->name('teacher.klass.courses');
        
        Route::resource('behaviours',App\Http\Controllers\Teacher\BehaviourController::class)->names('teacher.behaviours');
        Route::get('{model}/{id}/behaviours',[App\Http\Controllers\Teacher\BehaviourController::class,'selected'])->name('teacher.selected.behaviours');

        Route::get('{model}/{id}/students',[App\Http\Controllers\Teacher\StudentController::class,'selected'])->name('teacher.selected.students');
        Route::get('student/{student}/profile',[App\Http\Controllers\Teacher\StudentController::class,'profile'])->name('teacher.student.profile');
        //Route::resource('/course',App\Http\Controllers\Teachejaon()r\CourseController::class)->names('teacher.course');
})->name('teacher');



Route::group([
    'prefix'=>'/medical',
    'middleware'=>[
        'auth:sanctum',
        config('jetstream.auth_session'),
        'verified',
        'role:master|admin|director|teacher'
    ]
],function () {
    Route::get('/',[App\Http\Controllers\Medical\DashboardController::class,'index'])->name('medical');
    //Route::resource('healthcares',App\Http\Controllers\Medical\HealthcareController::class)->names('medical.healthcares');
    
    Route::get('klass/{klass}',[App\Http\Controllers\Medical\DashboardController::class,'klass'])->name('medical.klass');
    Route::resource('treatments',App\Http\Controllers\Medical\TreatmentController::class)->names('medical.treatments');
    Route::resource('healthcares',App\Http\Controllers\Medical\HealthcareController::class)->names('medical.healthcares');
    Route::post('healthcare/{healthcare}/get_bodychecks/{klass}',[App\Http\Controllers\Medical\HealthcareController::class,'getBodychecks'])->name('medical.healthcare.getBodychecks');
    Route::get('medicnote',[App\Http\Controllers\Medical\MedicnoteController::class,'dashboard'])->name('medical.medicnote');
    Route::resource('klass/{klass}/medicnotes',App\Http\Controllers\Medical\MedicnoteController::class)->names('medical.klass.medicnotes');
    Route::resource('bodychecks',App\Http\Controllers\Medical\BodycheckController::class)->names('medical.bodychecks');
});
// Route::prefix('promote')->group(function(){
//     Route::resource('/',App\Http\Controllers\Admin\PromotionController::class);
//     Route::get('klass/{klassId}',[App\Http\Controllers\Admin\PromotionController::class,'klass']);
//     Route::get('getStudents/{klassId}',[App\Http\Controllers\Admin\PromotionController::class,'getStudents']);
//     Route::get('getPromotedStudents/{klassId}',[App\Http\Controllers\Admin\PromotionController::class,'getPromotedStudents']);
//     Route::post('updateStudents',[App\Http\Controllers\Admin\PromotionController::class,'updateStudents']);
//     Route::get('data/{yearId}',[App\Http\Controllers\Admin\PromotionController::class, 'data']);
// });



// Route::group([
//     'prefix'=>'/guardian',
//     'middleware'=>[
//         'auth:sanctum',
//         config('jetstream.auth_session'),
//         'verified',
//         ]
// ],function () {
//     Route::get('/',[App\Http\Controllers\Guardian\DashboardController::class,'index'])->name('guardian.dashboard');
// });

Route::group([
    'prefix'=>'/student',
    'middleware'=>[
        'auth:sanctum',
        config('jetstream.auth_session'),
        'verified',
        ]
],function () {
    Route::get('/', function () {
        dd('student');
    })->name('student');

});

require __DIR__ . '/auth.php';