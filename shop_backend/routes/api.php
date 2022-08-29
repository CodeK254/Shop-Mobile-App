<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use Laravel\Sanctum\Sanctum;
use App\Http\Controllers\AuthsController;
use App\Http\Controllers\StockController;
use App\Http\Controllers\FavouritesController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::post("/signup", [AuthsController::class, "register"]);

Route::post("/signin", [AuthsController::class, "login"]);

Route::group(["middleware" => ["auth:sanctum"]], function () {
    Route::delete("/signout", [AuthsController::class, "logout"]);

    Route::get("/users", [AuthsController::class, "users"]);

    Route::put("/users", [AuthsController::class, "update"]);

    Route::get("/users/user", [AuthsController::class, "user"]);

    Route::apiResource("/stock", StockController::class);

    Route::post("stock/{id}/favourites", [FavouritesController::class, "favouriteOrNot"]);
});
