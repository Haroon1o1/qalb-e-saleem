import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:qalb/providers/DataProvider.dart';

class TextScreen extends StatefulWidget {
  final String image;
  
  final String name;
  final String audioPath;

  TextScreen({super.key, required this.image, required this.name, required this.audioPath});

  @override
  State<TextScreen> createState() => _TextScreenState();
}

class _TextScreenState extends State<TextScreen> {
  String fileText = '';
  Map<String, dynamic> images = {};


  @override
  void initState() {
       images =  Provider.of<DataProvider>(context, listen: false).imageMap;

    super.initState();
    textFile();
  }

  Future<void> textFile() async {
    log("--------------${widget.name}-----${getTextFile()}");
    String fileContent = await rootBundle.loadString(getTextFile());
    setState(() {
      fileText = fileContent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.26,
                      decoration: BoxDecoration(color: Colors.blue),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  getImageAddress() == "" ? Image.network(
                                    widget.image, width:80
                                  ) :Image.network(
                                    getImageAddress(),
                                    width: 80,
                                  ),
                                  SizedBox(width: 10),
                                  Image.asset(
                                    "assets/images/pause-white.png",
                                    width: 35,
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    widget.name,
                                    style: GoogleFonts.almarai(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Image.asset(
                                    "assets/images/back-arrow-white.png",
                                    width: 25,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset("assets/images/clock-white.png", width: 15),
                                    SizedBox(width: 5),
                                    Text("0:00", style: GoogleFonts.almarai(fontSize: 12, color: Colors.white)),
                                  ],
                                ),
                                LottieBuilder.asset("assets/images/voice.json", width: 20),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.21,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 25),
              height: MediaQuery.of(context).size.height * 0.8,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.7,
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.grey.shade300,
                    width: 1.0,
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.asset("assets/images/motive.png", width: 100, ),
                      SizedBox(height: 30),
                      Text(widget.name, style: TextStyle(fontFamily:"al-quran",fontSize: 25,color: Color.fromARGB(255, 15, 199, 181)),),
        SizedBox(height:widget.name == "شجرٔہ قادریہ نسبیہ" || widget.name == "شجرٔہ قادریہ حسبیہ" ? 0 : 30),
                      Html(data: fileText),
                      SizedBox(height: 30),
                      Image.asset("assets/images/motive.png", width: 100),
                      SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String getImageAddress() {
    final imageMap = {
      "منقبت": images["manqabat-white"],
      "اظہار تشکر": images["izhar-white"],
      "الفراق": images["alfiraq-white"],
      "مقّدمۃ الکتاب": images["muqadma-white"],
      "پیش لفظ": images["paish_lafz-white"],
      "سوانح حیات": images["sawana-white"],
      "قلبِ سلیم": images["qalbesaleem"],
      "شجرٔہ قادریہ حسبیہ": images["shajra_hasbia"],
      "شجرٔہ قادریہ نسبیہ": images["shajra_nasbia"],
      "قطعہ تاریخ وصال": images["qata-white"],
      "2منقبت": images["manqabat2-white"],
    };
    return imageMap[widget.name] ?? "";
  }
  

  String getTextFile() {
    final textFileMap = {
      "اظہار تشکر": "assets/textFiles/tashakur.html",
      "مقّدمۃ الکتاب": "assets/textFiles/maqadma.html",
      "الفراق": "assets/textFiles/alfiraq.html",
      "پیش لفظ": "assets/textFiles/peshLafz.html",
      "سوانح حیات": "assets/textFiles/sawana.html",
      "قلبِ سلیم": "assets/textFiles/qalb.html",
      "شجرٔہ قادریہ حسبیہ": "assets/textFiles/hasbia.html",
      "شجرٔہ قادریہ نسبیہ": "assets/textFiles/nasbiya.html",
      "قطعہ تاریخ وصال": "assets/textFiles/qata.html",
      "1منقبت": "assets/textFiles/manqabat1.html",
      "2منقبت": "assets/textFiles/manqabat2.html",
      "1": "assets/textFiles/01.html",
      "2": "assets/textFiles/02.html",
      "3": "assets/textFiles/03.html",
      "4": "assets/textFiles/04.html",
      "5": "assets/textFiles/05.html",
      "6": "assets/textFiles/06.html",
      "7": "assets/textFiles/07.html",
      "8": "assets/textFiles/08.html",
      "9": "assets/textFiles/09.html",
      "10": "assets/textFiles/10.html",
      "11": "assets/textFiles/11.html",
      "12": "assets/textFiles/12.html",
      "13": "assets/textFiles/13.html",
      "14": "assets/textFiles/14.html",
      "15": "assets/textFiles/15.html",
      "16": "assets/textFiles/16.html",
      "17": "assets/textFiles/17.html",
      "18": "assets/textFiles/18.html",
      "19": "assets/textFiles/19.html",
      "20": "assets/textFiles/20.html",

    };
    return textFileMap[widget.name] ?? "";
  }

//  Color getColor() {
//     final color = {
//       "اظہار تشکر": "assets/textFiles/tashakur.html",
//       "مقّدمۃ الکتاب": "assets/textFiles/maqadma.html",
//       "الفراق": "assets/textFiles/alfiraq.html",
//       "پیش لفظ": "assets/textFiles/peshLafz.html",
//       "سوانح حیات": "assets/textFiles/sawana.html",
//       "قلبِ سلیم": "assets/textFiles/qalb.html",
//       "شجرٔہ قادریہ حسبیہ": "assets/textFiles/hasbia.html",
//       "شجرٔہ قادریہ نسبیہ": "assets/textFiles/nasbiya.html",
//       "قطعہ تاریخ وصال": "assets/textFiles/qata.html",
//       "1منقبت": "assets/textFiles/manqabat1.html",
//       "2منقبت": "assets/textFiles/manqabat2.html",

//     }
  
}
