<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class StockResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array|\Illuminate\Contracts\Support\Arrayable|\JsonSerializable
     */
    public function toArray($request)
    {
        return [
            "stock" => [
                "type" => "Inventory",
                "id" => $this->id,
                "attributes" => [
                    "user_id" => $this->stock_id,
                    "name" => $this->stock_name,
                    "description" => $this->stock_description,
                    "price" => $this->stock_price,
                    "quantity" => $this->stock_quantity,
                    "image" => $this->stock_image,
                    "category" => $this->stock_category,
                    "sub_category" => $this->stock_sub_category,
                    "created_at" => $this->created_at,
                    "updated_at" => $this->updated_at,
                ],
            ],
        ];
    }
}
