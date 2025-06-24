<?php

namespace App\Providers;

use Illuminate\Auth\Events\Registered;
use Illuminate\Auth\Listeners\SendEmailVerificationNotification;
use Illuminate\Foundation\Support\Providers\EventServiceProvider as ServiceProvider;
use Illuminate\Support\Facades\Event;
use App\Models\Klass;
use App\Observers\KlassObserver;
use App\Models\Course;
use App\Observers\CourseObserver;
use App\Models\Additive;
use App\Observers\AdditiveObserver;
use App\Models\Task;
use App\Observers\TaskObserver;
use App\Models\KlassStudent;
use App\Observers\KlassStudentObserver;



class EventServiceProvider extends ServiceProvider
{
    /**
     * The event to listener mappings for the application.
     *
     * @var array<class-string, array<int, class-string>>
     */
    protected $listen = [
        Registered::class => [
            SendEmailVerificationNotification::class,
        ],
    ];

    /**
     * Register any events for your application.
     *
     * @return void
     */
    public function boot()
    {
        Klass::observe(KlassObserver::class);
        KlassStudent::observe(KlassStudentObserver::class);
        Course::observe(CourseObserver::class);
        Additive::observe(AdditiveObserver::class);
        Task::observe(TaskObserver::class);

    }

    /**
     * Determine if events and listeners should be automatically discovered.
     *
     * @return bool
     */
    public function shouldDiscoverEvents()
    {
        return false;
    }
}
