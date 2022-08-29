// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/Models/api_response.dart';
import 'package:shop_app/Models/user.dart';
import 'package:shop_app/Screens/home.dart';
import 'package:shop_app/Services/user_services.dart';
import 'package:shop_app/constants.dart';

class AddLocation extends StatefulWidget {

  String uname;
  String email;
  String pword;
  String pwordConf;

  AddLocation({required this.uname, required this.email, required this.pword, required this.pwordConf});

  @override
  State<AddLocation> createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {

  void _saveUserAndNavigate(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? '');
    await pref.setInt('userId', user.id ?? 0);
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Home()), (route) => false);
  }

  void _registerUser() async {
    ApiResponse response = await registerUser(widget.uname, widget.email, widget.pword, homeLocation);

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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _country = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _postalCode = TextEditingController();

  String homeLocation = "";

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
                        return "Input field cannot be left blank";
                      }
                      return null;
                    },
                    controller: _country,
                    decoration: kTextInputDecoration("Enter your Country name...", "Country"),
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
                        return "Input field cannot be left blank";
                      }
                      return null;
                    },
                    controller: _city,
                    decoration: kTextInputDecoration("Nearest City or Town required...", "City or Town"),
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
                        return "Input field cannot be left blank";
                      }
                      return null;
                    },
                    controller: _address,
                    decoration: kTextInputDecoration("Enter your Home Address...", "Address"),
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
                        return "Input field cannot be left blank";
                      }
                      return null;
                    },
                    controller: _postalCode,
                    decoration: kTextInputDecoration("Enter your postal code...", "Postal Code"),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.1, horizontal: 20),
                child: TextButton(
                  onPressed: (){
                    if(_formKey.currentState!.validate()){                   
                      setState(() {
                        homeLocation = "${_country.text}, ${_city.text}, ${_address.text}, ${_postalCode.text}";
                      });
                      _registerUser();
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
            ],
          ),
        )
      ),
    );
  }
}