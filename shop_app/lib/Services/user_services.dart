import 'dart:io';
import 'package:shop_app/constants.dart';
import 'package:shop_app/Models/api_response.dart';
import 'package:shop_app/Models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

// ----------User Register----------

Future<ApiResponse> registerUser(String username, String email, String password, location) async {
  ApiResponse apiResponse = ApiResponse();
  try{
    final response = await http.post(
      Uri.parse(registerURL),
      headers: {'accept': 'application/json'},
      body: {
        "username": username,
        "email": email,
        "password": password,
        "location" : location,
      },
    );
    switch(response.statusCode) {
      case 200:
        apiResponse.data = User.fromJson(jsonDecode(response.body));
        break;
        
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
        
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
        
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch(e){
    apiResponse.error = "An error occured while trying to connect to the server";
  }
  
  return apiResponse;
}

// ----------User Login----------

Future<ApiResponse> loginUser(String email, String password) async {
  ApiResponse apiResponse = ApiResponse();
  try{
    final response = await http.post(
      Uri.parse(loginURL),
      headers: {'accept': 'application/json'},
      body: {
        "email": email,
        "password": password,
      },
    );
    switch(response.statusCode) {
      case 200:
        apiResponse.data = User.fromJson(jsonDecode(response.body));
        break;
        
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;

      case 401:
        apiResponse.error = "Invalid login credentials";
        break;
        
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
        
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch(e){
    apiResponse.error = somethingWentWrong;
  }
  
  return apiResponse;
}

// ----------User Details----------

Future<ApiResponse> getUserDetails() async {
  ApiResponse apiResponse = ApiResponse();
  try{
    String token = await getToken();
    final response = await http.get(
      Uri.parse(userURL),
      headers: {'accept': 'application/json', 'Authorization': 'Bearer $token'},
    );
    switch(response.statusCode) {
      case 200:
        apiResponse.data = User.fromJson(jsonDecode(response.body));
        break;
        
      case 401:
        apiResponse.error = "Unauthorized";
        break;
        
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch(e){
    apiResponse.error = somethingWentWrong;
  }
  
  return apiResponse;
}

// ----------User Token----------

Future<String> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('token') ?? '';
}

// ----------User Get Id----------

Future<int> getUserId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt('userId') ?? 0;
}

// ----------User Logout----------

Future<bool> logoutUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.remove("token");
}

// ---------get Image String -----

String? getStringImage(File? file){
  if(file == null){
    return null;
  }
  else{
    return base64Encode(file.readAsBytesSync());
  }
}