// ignore_for_file: non_constant_identifier_names

import 'package:shop_app/Models/user.dart';

class Stock{
  int? id;
  String? stock_name;
  String? stock_image;
  int? stock_price;
  int? stock_quantity;
  String? stock_description;
  User? user;
  bool? favorite;

  Stock({
    this.id,
    this.stock_name,
    this.stock_image,
    this.stock_price,
    this.stock_quantity,
    this.stock_description,
    this.user,
    this.favorite,
  });

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      id: json["id"],
      stock_name: json["name"],
      stock_image: json["image"],
      stock_price: json["price"],
      stock_quantity: json["quantity"],
      favorite: json["favourites"].length > 0,
      user: User(
        id: json["user"]["id"], 
        username: json["user"]["name"],
        image: json["user"]["image"],
        location: json["user"]["location"],
      ),
    );
  } 
}