<?php

use App\Http\Controllers\HealthController;
use App\Http\Controllers\MetricsController;
use App\Http\Controllers\TodoController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

// Health check routes
Route::get('/health', [HealthController::class, 'check']);
Route::get('/ping', [HealthController::class, 'ping']);

// Metrics routes
Route::get('/metrics', [MetricsController::class, 'prometheus']);
Route::get('/metrics/json', [MetricsController::class, 'json']);

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

// Todo API Routes (which is perform read, write, show and delete todo)
Route::apiResource('todos', TodoController::class);
