<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\BookController;
use Illuminate\Http\Request;

// Rotas públicas
Route::post('/login', [AuthController::class, 'login']);

// // Rotas protegidas por auth:api
// Route::middleware('auth:api')->group(function () {

//     // Autenticação e perfil
//     Route::controller(AuthController::class)->group(function () {
//         Route::get('/verify-token', 'verifyToken');
//         Route::get('/me', fn(Request $request) => $request->user());
//         Route::put('/profile/update-name', 'updateName');
//         Route::post('/update-profile-image', 'updateProfileImage');
//         Route::post('/logout', 'logout');
//     });

//     // Livros - somente leitura e operações padrão
//     Route::prefix('books')->controller(BookController::class)->group(function () {
//         Route::get('/search', 'buscar');
//         Route::get('/', 'index');
//         Route::get('/recents', 'recents');
//         Route::get('/trashed', 'trashed');
//         Route::get('/{id}', 'show');
//         Route::post('/{id}', 'update');
//         Route::delete('/{id}', 'destroy');
//         Route::post('/{id}/restore', 'restore');
//         Route::delete('/{id}/force', 'forceDelete');
//     });
// });

// Autenticação e perfil
Route::controller(AuthController::class)->group(function () {
    Route::get('/verify-token', 'verifyToken');
    Route::get('/me', fn(Request $request) => $request->user());
    Route::put('/profile/update-name', 'updateName');
    Route::post('/update-profile-image', 'updateProfileImage');
    Route::post('/logout', 'logout');
});

// Livros
Route::prefix('books')->controller(BookController::class)->group(function () {
    Route::get('/search', 'buscar');
    Route::get('/', 'index');
    Route::get('/recents', 'recents');
    Route::get('/trashed', 'trashed');
    Route::get('/{id}', 'show');
    Route::post('/', 'store');
    Route::post('/{id}', 'update');
    Route::delete('/{id}', 'destroy');
    Route::post('/{id}/restore', 'restore');
    Route::delete('/{id}/force', 'forceDelete');
});