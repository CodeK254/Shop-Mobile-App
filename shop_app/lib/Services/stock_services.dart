// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:shop_app/Models/api_response.dart';
import 'package:shop_app/Services/user_services.dart';
import 'package:shop_app/constants.dart';
import 'package:http/http.dart' as http;

Future<ApiResponse> addStock(String? image, String stock_name, String stock_description, String stock_price, String stock_quantity, String stock_category, String stock_sub_category) async {
  ApiResponse apiResponse = new ApiResponse();
  var token = await getToken();
  try{
    var response = await http.post(
      Uri.parse(stockURL), 
      headers: {
        "accept": "application/json",
        "authorization": "Bearer $token",
      },
      body: image != "" ? {
        "image": image,
        "stock_name": stock_name,
        "stock_description": stock_description,
        "stock_price": stock_price,
        "stock_quantity": stock_quantity,
        "stock_category": stock_category,
        "stock_sub_category": stock_sub_category,
      }
      :
      {
        "stock_name": stock_name,
        "stock_description": stock_description,
        "stock_price": stock_price,
        "stock_quantity": stock_quantity,
        "stock_category": stock_category,
        "stock_sub_category": stock_sub_category,
      }
    );
    
    switch(response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body);
        print(apiResponse.data);
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
    apiResponse.error = somethingWentWrong;
  }

  return apiResponse;
}

Future<ApiResponse> allStock() async {
  ApiResponse apiResponse = ApiResponse();
  var token = await getToken();
  try{
    var response = await http.get(
      Uri.parse(stockURL),
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      }
    );
    
    switch(response.statusCode) {
      case 200:
        // apiResponse.data = jsonDecode(response.body)["posts"].map((post) => Post.fromJson(post)).toList();
        apiResponse.data = jsonDecode(response.body)["stock"];
        apiResponse.data as List<dynamic>;
        break;

      case 401:
        apiResponse.error = unauthorized; 
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

Future<ApiResponse> updateStock(int id, String? image, String stock_name, String stock_price, String stock_quantity) async {
  ApiResponse apiResponse = ApiResponse();
  var token = await getToken();
  try{
    print("Image inside the Update Method is: $image");
    var response = await http.put(
      Uri.parse("$stockURL/$id"),
      headers: {
        "accept": "application/json",
        "authorization": "Bearer $token",
      },
      body: image != null ? {
        "stock_image": image,
        "stock_name": stock_name,
        "stock_price": stock_price,
        "stock_quantity": stock_quantity,
      }
      :
      {
        "stock_name": stock_name,
        "stock_price": stock_price,
        "stock_quantity": stock_quantity,
      }
    );

    print("Error made as Response StatusCode: ${response.statusCode} is achieved");
    
    switch(response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body);
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
    apiResponse.error = "Error: somethingWentWrong!!!";
  }

  return apiResponse;
}