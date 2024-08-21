import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class hawashiwahawalajatScreen extends StatefulWidget {
  const hawashiwahawalajatScreen({super.key});

  @override
  State<hawashiwahawalajatScreen> createState() =>
      _hawashiwahawalajatScreenState();
}

class _hawashiwahawalajatScreenState extends State<hawashiwahawalajatScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.26,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                "assets/images/majlis/upergrad.png",
                              ),
                              fit: BoxFit.contain)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 0.0, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(height: 10),
                              Text(
                                "حواشی و حوالہ جات",
                                style: GoogleFonts.almarai(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "قلب سلیم",
                                style: GoogleFonts.almarai(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  child: Image.asset(
                                    "assets/images/back-arrow-white.png",
                                    width: 26,
                                  ),
                                ),
                              ]),
                          SizedBox(
                            width: 20,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height *
                0.21, // Adjust position as needed
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 25),
              height: MediaQuery.of(context).size.height *
                  0.8, // Adjust height as needed
              decoration: BoxDecoration(
                color: const Color.fromARGB(
                    255, 231, 230, 230), // Container background color
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.6,
                  padding: EdgeInsets.symmetric(vertical: 55),
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset("assets/images/hawalajat1.png", width: 150),
                      Image.asset("assets/images/hawalajat2.png", width: 160),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
