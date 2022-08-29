// ignore_for_file: use_build_context_synchronously

import "package:flutter/material.dart";
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/Screens/editStock.dart';
import 'package:shop_app/Services/stock_services.dart';
import 'package:shop_app/constants.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List data = [];

  Future<List> getAllStock() async {
    var response = await allStock();

    if(response.error == null){
      setState(() {
        data = response.data as List;
      });
    }
    else if(response.error == "Unauthorized"){
      Navigator.pushReplacementNamed(context, "/login");
    } else {
      Fluttertoast.showToast(msg: "${response.error}");
      // showDialog(
      //   context: context,
      //   builder: (context) => AlertDialog(
      //     contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      //     title: const Text("Alert"),
      //     content: Text(
      //       "${response.error}",
      //       style: GoogleFonts.firaSans(
      //         fontSize: 18,
      //         color: Colors.black,
      //         letterSpacing: 1.2,
      //       ),
      //     ),
      //   ),
      // );
    }

    return data;
  }

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
      body: FutureBuilder(
        future: getAllStock(),
        builder: (context, snapshot) {
          if(snapshot.hasError){
            Fluttertoast.showToast(msg: "Snapshot threw an Error!!!");
          }

          if(!snapshot.hasData){
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
                color: Colors.blue,
              ),
            );
          } 
          else {
              return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: MediaQuery.of(context).size.width * 0.03,
                  mainAxisSpacing: MediaQuery.of(context).size.width * 0.03,
                ),
                itemCount: data.length,
                itemBuilder: (context, index){
                  return Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: data[index]["image"] != null ? Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage("${data[index]["image"]}"),
                              fit: BoxFit.cover,
                            ),
                            border: Border.all(
                              color: Colors.black54,
                              width: 1,
                            )
                          ),
                        )
                        :
                        Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.black54,
                              width: 1,
                            )
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> EditStock(parsed: data[index])));
                            },
                            child: Center(
                              child: Text(
                                "image_not_set",
                                style: GoogleFonts.rancho(
                                  fontSize: 18,
                                  letterSpacing: 1.2,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        )
                      ),
                      Text(
                        data[index]["stock_name"], 
                        style: const TextStyle(color: Colors.black
                        ),
                      ),
                    ],
                  );
                }
              ),
            );
          }
        },
      ),
    );
  }
}