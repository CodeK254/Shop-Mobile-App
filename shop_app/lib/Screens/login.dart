// ignore_for_file: use_build_context_synchronously

import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/Models/api_response.dart';
import 'package:shop_app/Models/user.dart';
import 'package:shop_app/Screens/home.dart';
import 'package:shop_app/Services/user_services.dart';
import 'package:shop_app/constants.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final GlobalKey _formKey = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  void _saveUserAndNavigate(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? '');
    await pref.setInt('userId', user.id ?? 0);
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Home()), (route) => false);
  }

  void _loginUser() async {
    ApiResponse response = await loginUser(_email.text, _password.text);

    if(response.error != null){
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text("${response.error}"),
          actions: [
            TextButton(
              child: const Text('Ok'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    } else {
      _saveUserAndNavigate(response.data as User);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white70,
                  ),
                  child: TextFormField(
                    validator: (value){
                      if(value!.isEmpty){
                        return "Email field cannot be left blank";
                      }
                      return null;
                    },
                    controller: _email,
                    decoration: kTextInputDecoration("Enter your email...", "Email"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white70,
                  ),
                  child: TextFormField(
                    validator: (value){
                      if(value!.isEmpty){
                        return "Password required.";
                      }
                      return null;
                    },
                    obscureText: true,
                    controller: _password,
                    decoration: kTextInputDecoration("Enter your password...", "Password"),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.1, horizontal: 20),
                child: TextButton(
                  onPressed: (){
                    _loginUser();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Login",
                    style: GoogleFonts.firaSans(
                      fontSize: 20,
                      color: Colors.white,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01), 
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: GoogleFonts.firaSans(
                      fontSize: 20,
                      color: Colors.black,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, "/register");
                    },
                    child: Text(
                      "Sign Up",
                      style: GoogleFonts.firaSans(
                        fontSize: 20,
                        color: Colors.blue,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}