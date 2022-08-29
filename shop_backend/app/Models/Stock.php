<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Stock extends Model
{
    use HasFactory;

    protected $fillable = [
        "user_id",
        'stock_name',
        'stock_description',
        'stock_price',
        'stock_quantity',
        'stock_image',
        'stock_category',
        'stock_sub_category',
    ];

    public function user(){
        return $this->belongsTo(User::class);
    }

    public function favourites(){
        return $this->hasMany(Favourite::class);
    }
}
