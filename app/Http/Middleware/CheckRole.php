<?php
 
namespace App\Http\Middleware;
 
use Closure;
 
class CheckRole
{
    /**
     * Handle the incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @param  string  $role
     * @return mixed
     */
    public function handle($request, Closure $next, $role)
    {
        $requiredRoles=explode('|',$role);
        foreach($requiredRoles as $r){
            if ($request->user()->hasRole($role)) {
                return $next($request);
            }
        }
        return redirect()->route('dashboard');
        //return $next($request);
    }
 
}