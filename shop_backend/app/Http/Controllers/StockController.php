<?php

namespace App\Http\Controllers;

use App\Models\Stock;
use App\Http\Requests\StoreStockRequest;
use App\Http\Requests\UpdateStockRequest;
use App\Http\Resources\StockResource;

class StockController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return response()->json([
            "stock" => Stock::orderBy("created_at", "desc")->with("user:id,username,email,image,location")->withCount("favourites")->with("favourites", function($favourites){
                return $favourites->where("user_id", auth()->user()->id)
                    ->select("id", "user_id", "stock_id")->get();
            })->get()
        ], 200);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create(Request $request){
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \App\Http\Requests\StoreStockRequest  $request
     * @return \Illuminate\Http\Response
     */
    public function store(StoreStockRequest $request)
    {
        $attrs = $request->validate([
            'stock_name' => 'required|string|max:255',
            'stock_description' => 'required|string|max:255',
            'stock_price' => 'required|numeric',
            'stock_quantity' => 'required|numeric',
            'stock_category' => 'required|string|max:255',
            'stock_sub_category' => 'required|string|max:255',
        ]);

        $stockImage = $this->saveImage($request->image, "stock");

        $stock = Stock::create([
            'stock_name' => $attrs['stock_name'],
            'stock_description' => $attrs['stock_description'],
            "stock_image" => $stockImage,
            'stock_price' => $attrs['stock_price'],
            'stock_quantity' => $attrs['stock_quantity'],
            'stock_category' => $attrs['stock_category'],
            'stock_sub_category' => $attrs['stock_sub_category'],
            'user_id' => auth()->user()->id,
        ]);

        return response()->json([
            'message' => 'Stock created successfully',
            'stock' => new StockResource($stock)
        ], 200);
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Stock  $stock
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        return response()->json([
            "stock" => Stock::findOrFail($id)->with("user:id,username,email,location")->withCount("favourites")->get()
        ], 200);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Stock  $stock
     * @return \Illuminate\Http\Response
     */
    public function edit(Stock $stock)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \App\Http\Requests\UpdateStockRequest  $request
     * @param  \App\Models\Stock  $stock
     * @return \Illuminate\Http\Response
     */
    public function update(UpdateStockRequest $request, $id)
    {
        $stock = Stock::findOrFail($id);

        if($stock->user_id !== auth()->user()->id){
            return response()->json([
                'message' => 'You are not authorized to update this stock'
            ], 401);
        }

        $attrs = $request->validate([
            'stock_name' => 'required|string|max:255',
            'stock_description' => 'required|string|max:255',
            'stock_price' => 'required|numeric',
            'stock_quantity' => 'required|numeric',
        ]);

        $image = $this->saveImage($request->image, "stock");

        $stock->update([
            'stock_name' => $attrs['stock_name'],
            'stock_description' => $attrs['stock_description'],
            "stock_image" => $image,
            'stock_price' => $attrs['stock_price'],
            'stock_quantity' => $attrs['stock_quantity'],
        ]);

        return response()->json([
            'stock' => new StockResource($stock),
            'message' => 'Stock updated successfully'
        ], 200);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Stock  $stock
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $stock = Stock::findOrFail($id);

        if($stock->user_id !== auth()->user()->id){
            return response()->json([
                'message' => 'You are not authorized to delete this stock'
            ], 401);
        }

        $stock->delete();

        $stock->favourites()->delete();

        return response()->json([
            'message' => 'Stock deleted successfully'
        ], 200);
    }
}
