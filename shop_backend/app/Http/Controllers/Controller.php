<?php

namespace App\Http\Controllers;

use Illuminate\Foundation\Auth\Access\AuthorizesRequests;
use Illuminate\Foundation\Bus\DispatchesJobs;
use Illuminate\Foundation\Validation\ValidatesRequests;
use Illuminate\Routing\Controller as BaseController;

class Controller extends BaseController
{
    use AuthorizesRequests, DispatchesJobs, ValidatesRequests;

    public function saveImage($image, $path = "public"){
        if(!$image){
            return null;
        }

        $filename = time().".jpg";

        // Save image file

        \Storage::disk($path)->put($filename, base64_decode($image));

        // Return the path

        return "http://192.168.0.200:8000/"."/storage/".$path."/".$filename;
    }
}
