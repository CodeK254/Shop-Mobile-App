<?php

namespace App\Http\Controllers;

use App\Models\Stock;
use App\Models\Favourite;
use Illuminate\Http\Request;

class FavouritesController extends Controller
{
    // get all favourites.
    public function favouriteOrNot($id)
    {
        $item = Stock::findOrFail($id);

        if(!$item){
            return response()->json([
                'message' => 'Item not found.',
            ], 404);
        }

        $favourite = $item->favourites()->where("user_id", auth()->user()->id)->first();

        // Add to favourites
        if(!$favourite){
            Favourite::create([
                "user_id" => auth()->user()->id,
                "stock_id" => $id,
            ]);

            return response()->json([
                'message' => 'Item added to favourites.',
            ], 200);
        }

        // Remove from favourites
        else{
            $favourite->delete();

            return response()->json([
                'message' => 'Item removed from favourites.',
            ], 200);
        }
    }
}
