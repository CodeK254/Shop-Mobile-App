import 'package:flutter/material.dart';
import 'package:shop_app/Screens/home.dart';
import 'package:shop_app/Screens/intro_screen.dart';
import 'package:shop_app/Screens/loading.dart';
import 'package:shop_app/Screens/login.dart';
import 'package:shop_app/Screens/register.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => const Loading(),
        "/intro": (context) => Introduction(),
        "/register": (context) => const Register(),
        "/login": (context) => const Login(),
        "/home": (context) => Home(),
      }, 
    )
  );
}