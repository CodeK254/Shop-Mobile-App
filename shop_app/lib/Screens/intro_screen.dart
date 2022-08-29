import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Introduction extends StatefulWidget {

  @override
  State<Introduction> createState() => _IntroductionState();
}

class _IntroductionState extends State<Introduction> {

  PageController _controller = PageController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.9,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                PageView(
                  controller: _controller,
                  onPageChanged: (index){
                    setState(() {
                      isLastPage = index == 3;
                    });
                  },
                  children : [
                    kPageContainer(Colors.white),
                    kPageContainer(Colors.black),
                    kPageContainer(Colors.teal),
                    kPageContainer(Colors.red),
                  ],
                ),
              ],
            ),
          ),
          Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.1,
              maxWidth: MediaQuery.of(context).size.width,
            ),
            color: Colors.white,
            child: isLastPage ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: TextButton(
                onPressed: (){
                  Navigator.pushReplacementNamed(context, "/register");
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ), 
                child: Text(
                  "Get Started",
                  style: GoogleFonts.firaSans(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            )
            :
            Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: SmoothPageIndicator(
                  controller: _controller, 
                  count: 4, 
                  effect: const WormEffect(
                    activeDotColor: Colors.blue, 
                    dotHeight: 6,
                    dotWidth: 6,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}