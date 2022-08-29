import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/Screens/locations.dart';
import 'package:shop_app/constants.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _passwordConfirmation = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formkey,
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
                        return "Input field cannot be left blank";
                      }
                      return null;
                    },
                    controller: _username,
                    decoration: kTextInputDecoration("Enter your username...", "Username"),
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
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white70,
                  ),
                  child: TextFormField(
                    validator: (value){
                      if(value != _password.text){
                        return "Passwords do not match.";
                      }
                      return null;
                    },
                    obscureText: true,
                    controller: _passwordConfirmation,
                    decoration: kTextInputDecoration("Confirm password...", "Confirm Password"),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.1, horizontal: 20),
                child: TextButton(
                  onPressed: (){
                    if(_formkey.currentState!.validate()){
                      Navigator.pushReplacement(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => AddLocation(
                            uname: _username.text, 
                            email: _email.text, 
                            pword: _password.text, 
                            pwordConf: _passwordConfirmation.text
                          ),
                        ),
                      );
                    }
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Add Location",
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
                    "Already have an account?",
                    style: GoogleFonts.firaSans(
                      fontSize: 20,
                      color: Colors.black,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushReplacementNamed(context, "/login");
                    },
                    child: Text(
                      "Sign In",
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