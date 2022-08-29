import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/constants.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        toolbarHeight: MediaQuery.of(context).size.height * 0.09,
        backgroundColor: Colors.white,
        title: Text(
          "Wa Maina Shop & Cereals",
          style: GoogleFonts.playfairDisplay(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            color: Colors.black,
            letterSpacing: 1,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: MediaQuery.of(context).size.width * 0.03,
            mainAxisSpacing: MediaQuery.of(context).size.width * 0.03,
          ),
          itemCount: 10,
          itemBuilder: (context, index){
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/image.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Text("Here", style: TextStyle(color: Colors.black)),
              ],
            );
          }
        ),
      ),
    );
  }
}