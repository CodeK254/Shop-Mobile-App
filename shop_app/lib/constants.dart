import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ------------------------ROUTES---------------------------
const String URL = "http://192.168.0.200:8000/api";
const String registerURL = "$URL/signup";
const String loginURL = "$URL/signin";
const String usersURL = "$URL/users";
const String userURL = "$usersURL/user";
const String logoutURL = "$URL/logout";
const String allStock = "$URL/stock";
const String singleStock = "$allStock/{id}";
const String favourites = "$singleStock/favourites";

// ------------------------ERRORS---------------------------

const String somethingWentWrong = "Something went wrong";
const String unauthorized = "Unauthorized";


PageController _controller = PageController();

bool isLastpage = false;

kPageContainer(Color bg_color){
  return Container(
    decoration: BoxDecoration(
      color: bg_color,
    ),
  );
}

kTextInputDecoration(String hint, String label,){
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(horizontal: 15),
    hintText: hint,
    hintStyle: GoogleFonts.rancho(
      fontSize: 20,
      color: Colors.grey,
    ),
    labelText: label,
    labelStyle: GoogleFonts.rancho(
      fontSize: 20,
      color: Colors.brown,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );
}

kSubmitButton(String label, BuildContext context, String route){
  return Padding(
    padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.1, horizontal: 20),
    child: TextButton(
      onPressed: (){
        Navigator.pushReplacementNamed(context, route);
      },
      style: TextButton.styleFrom(
        backgroundColor: Colors.blue,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        label,
        style: GoogleFonts.firaSans(
          fontSize: 20,
          color: Colors.white,
          letterSpacing: 1,
        ),
      ),
    ),
  );
}

ktext(String label, String text, BuildContext context){
  return Padding(
    padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.02, horizontal: 20),
    child: Row(
      children: [
        Text(
          label,
          style: GoogleFonts.rancho(
            fontSize: 22,
            color: Colors.black,
            letterSpacing: 1,
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.02),
        Text(
          text,
          style: GoogleFonts.rancho(
            fontSize: 22,
            color: Colors.black,
            letterSpacing: 1,
          ),
        ),
      ],
    ),
  );
}