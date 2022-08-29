<?php

namespace App\Http\Controllers;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class AuthsController extends Controller
{
    public function register(Request $request){
        $rules = $request->validate([
            'username' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users',
            'password' => 'required|min:6',
            'location' => 'required|string|max:255',
        ]);

        $user = User::create([
            'username' => $rules["username"],
            'email' => $rules["email"],
            'password' => bcrypt($rules["password"],),
            'location' => $rules["location"],
        ]);

        // Return User and Response as response

        return response()->json([
            'user' => $user,
            "token" => $user->createToken("secret")->plainTextToken,
            'message' => 'User Created Successfully',
        ], 200);
    }

    public function login(Request $request){
        $rules = $request->validate([
            'email' => 'required|string|email|max:255',
            'password' => 'required|min:6',
        ]);
        if(!Auth::attempt($rules)){
            return response()->json([
                'message' => 'Invalid Credentials',
            ], 401);
        }
        $user = Auth::user();
        return response()->json([
            'user' => $user,
            "token" => $user->createToken("secret")->plainTextToken,
            'message' => 'User Logged In Successfully',
        ], 200);
    }

    public function logout(Request $request){
        auth()->user()->tokens()->delete();

        return response()->json([
            'message' => 'User Logged Out Successfully',
        ], 200);
    }

    public function users(Request $request){
        $users = User::all();
        return response()->json([
            'users' => $users,
        ], 200);
    }

    // Get User.
    public function user() {
        return response([
            'user' => auth()->user(),
        ], 200);
    }

    public function update(Request $request){
        if(!Auth::user()){
            return response()->json([
                'message' => 'You are not authorized to update this user',
            ], 401);
        }

        $attrs =  $request->validate([
            'username' => 'required|string|max:255',
            'email' => 'required|string|email|max:255',
            'location' => 'required|string|max:255',
        ]);

        $image = $this->saveImage($request->image, "profiles");

        auth()->user()->update([
            'username' => $attrs["username"],
            'email' => $attrs["email"],
            'location' => $attrs["location"],
            'image' => $image,
        ]);

        return response()->json([
            'message' => 'User Updated Successfully',
            "user" => auth()->user(),
        ], 200);
    }
}
