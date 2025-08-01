<?php

use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    // This is the main entry point of the application.
    return view('welcome');
});
