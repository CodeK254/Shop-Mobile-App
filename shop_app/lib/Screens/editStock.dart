// ignore_for_file: use_build_context_synchronously, avoid_print, prefer_interpolation_to_compose_strings, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_app/Models/api_response.dart';
import 'package:shop_app/Services/stock_services.dart';
import 'package:shop_app/Services/user_services.dart';
import 'package:shop_app/constants.dart';
import "dart:io";

class EditStock extends StatefulWidget {

  Map parsed;

  EditStock({required this.parsed});

  @override
  State<EditStock> createState() => _EditStockState();
}

class _EditStockState extends State<EditStock> {
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;

  _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = File(pickedFile!.path);
    });
  }

  String? image = "";

  _stockUpdate() async {
    setState((){
      print("Image is: ${_imageFile.toString()}");

      image = _imageFile != null ? getStringImage(_imageFile) : null;

      print("Image is now set to: $image as 64 byte code.");
    });
    ApiResponse response = await updateStock(widget.parsed["id"], image, _sname.text, _sprice.text, _squantity.text);

    if (response.error == null) {
      Fluttertoast.showToast(
        msg: "Post created successfully",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
      );
      Navigator.pop(context);
    } else if(response.error == unauthorized){
      logoutUser().then((value) => Navigator.pushReplacementNamed(context, "/login"));
    }
    else {
      print(response.error);
    }
  }

  final TextEditingController _sname = TextEditingController();
  final TextEditingController _sprice = TextEditingController();
  final TextEditingController _squantity = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Stock",
          style: GoogleFonts.meriendaOne(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        children: [
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _imageFile == null ? Container(
                decoration: const BoxDecoration(
                  color: Colors.blueGrey,
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: (){
                      _pickImage();
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(20),
                      child: Icon(
                        Icons.add_a_photo,
                      ),
                    ),
                  ),
                ),
              )
              :
              Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.35,
                  maxWidth: MediaQuery.of(context).size.width * 0.95,
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: FileImage(_imageFile!),
                    fit: BoxFit.cover,
                  ),
                ),
              )
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
                  if (value!.isEmpty){
                    return "Stock name is required";
                  }
                },
                controller: _sname,
                decoration: kTextInputDecoration(widget.parsed["stock_name"], "Stock Name"),
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
                  if (value!.isEmpty){
                    return "Stock price required";
                  }
                },
                controller: _sprice,
                decoration: kTextInputDecoration(widget.parsed["stock_price"], "Stock Price"),
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
                  if (value!.isEmpty){
                    return "Stock quantity required";
                  }
                },
                controller: _squantity,
                decoration: kTextInputDecoration(widget.parsed["stock_quantity"], "Stock Quantity"),
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () async {
              if(_formKey.currentState!.validate()) {
                await _stockUpdate();
                Navigator.pushReplacementNamed(context, "/home");
              }
            }, 
            child: Text(
              'ADD STOCK',
              style: GoogleFonts.firaSans(
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ),
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            ),
          ),
        ],
      ),
    );
  }
}