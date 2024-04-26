<?php

use Illuminate\Foundation\Inspiring;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\DB;  // Make sure this line is added.

/*
|--------------------------------------------------------------------------
| Console Routes
|--------------------------------------------------------------------------
|
| This file is where you may define all of your Closure based console
| commands. Each Closure is bound to a command instance allowing a
| simple approach to interacting with each command's IO methods.
|
*/

Artisan::command('inspire', function () {
    $this->comment(Inspiring::quote());
})->purpose('Display an inspiring quote');

// Add the custom db:connectivity-check command.
Artisan::command('db:connectivity-check', function () {
    try {
        DB::connection()->getPdo();
        echo "Successfully connected to the DB.\n";
    } catch (\Exception $e) {
        exit("Could not connect to the DB.\n");
    }
})->purpose('Check database connectivity');