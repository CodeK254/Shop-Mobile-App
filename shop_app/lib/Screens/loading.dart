// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/Models/api_response.dart';
import 'package:shop_app/Screens/home.dart';
import 'package:shop_app/Screens/intro_screen.dart';
import 'package:shop_app/Screens/login.dart';
import 'package:shop_app/Services/user_services.dart';
import 'package:shop_app/constants.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void _loadUserInfo() async {
    print('Loading user info');
    String token = await getToken();
    if(token == '') {
      print('No token found');
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Introduction()), (route) => false);
    } else {
      print(token);
      ApiResponse response = await getUserDetails();
      if(response.error == null){ 
        print('User info loaded');
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Home()), (route) => false);
      }
      else if(response.error == unauthorized){
        print(response.error);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: Text("${response.error}"),
            actions: [
              TextButton(
                child: const Text('Ok'),
                onPressed: () => response.error != "Unauthorized" ? Navigator.pop(context) : Navigator.pushReplacementNamed(context, "/login"),
              ),
            ],
          ),
        );
      }
      else{
        print('An error occurred while processing');
        Fluttertoast.showToast(msg: "An error occurred while processing");
      }
    }
  }

  @override

  void initState() {
    _loadUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
          color: Colors.blue,
        ),
      ),
    );
  }
}