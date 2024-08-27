import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qalb/Transition/CustomPageTransition.dart';
import 'package:qalb/screens/HomeScreen/LongBox.dart';
import 'package:qalb/screens/HomeScreen/smallContainer.dart';
import 'package:qalb/screens/Shajr_e_Qadria/Shajr_e_Qadria.dart';
import 'package:qalb/screens/hawashi_wa_hawalajat.dart';
import 'package:qalb/screens/majlis_screen.dart';
import 'package:qalb/screens/sound_screen.dart/sound_player.dart';
import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:qalb/screens/videoPlayer.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {


  @override
  void initState() {
    super.initState();
 
  }
    @override
  void dispose() {

    super.dispose();
  }





  @override
  Widget build(BuildContext context) {
     SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.black, // Set the status bar color to black
        statusBarIconBrightness: Brightness.light, // Set the icon brightness to light (white icons)
      ),
    );
    return Scaffold(
      bottomNavigationBar: Stack(
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:  [
                Icon(Icons.home, color: Colors.grey[400]),
                Icon(Icons.search, color: Colors.grey[400]),
                SizedBox(width: 40), // Placeholder for the central circle
                Icon(Icons.notifications, color: Colors.grey[400]),
                Icon(Icons.person, color: Colors.grey[400]),
              ],
            ),
          ),
          Positioned(
            bottom: 0, // Adjust this value to control the hover effect
            child: Container(
              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
              alignment: Alignment.center,
              height: 80, width: 80,
              child: Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                  
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 30),
              ),
            ),
          ),
        ],
      ),

        
     
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    CustomPageNavigation(
                      child: Majlis(),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.49,
                  margin: EdgeInsets.symmetric(horizontal: 0, vertical: 30),
                  decoration: BoxDecoration(
                    color:Colors.transparent,
                      image: DecorationImage(
                          image: AssetImage("assets/images/darbar.png"),
                          fit: BoxFit.fitHeight)),
                  child: Column(
                    children: [
                      SizedBox(height: 40),
                      Container(
                        alignment: Alignment.center,
                        width: 200,
                        height: 80,
                        decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage("assets/new_images/home_banner.png", ),fit: BoxFit.contain,)
                        ),
                        child: Text(
                          "فهرست مجالس",
                          style: GoogleFonts.almarai(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        "امام االولیاء حضرت پیر سّید محّمد عبد اهلل شاہ مشہدی قادری",
                        style: GoogleFonts.almarai(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "رحمة اهلل تعالى عليه",
                        style: GoogleFonts.almarai(
                          fontSize: 11,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SmallContainer(
                      backgroundColor: Color(0xFF10A8E3),
                      imagePath: 'assets/images/manqabat-dark.png',
                      text: 'منقبت',
                      sub: "حضرت سّید محمد ظفر مشہدی قادری رحمة اهلل عليه",
                      audioPath: '',
                    ),
                    SmallContainer(
                      backgroundColor: Color(0xFF2C3491),
                      imagePath: 'assets/images/tashakur.png',
                      text: 'اظہار تشکر',
                      sub: 'سید محمد فراز شاہ عفی عنہ',
                      audioPath: '',
                    ),
                    SmallContainer(
                      backgroundColor: Color(0xFF692592),
                      imagePath: 'assets/images/muqadma-dark.png',
                      text: 'مقّدمۃ الکتاب',
                      sub: 'حضرت ابو الحقائق پیر سّید امانت علی شاہ چشتی نظامی',
                      audioPath: '',
                    ),
                    SmallContainer(
                      backgroundColor: Color(0xFF00B771),
                      imagePath: 'assets/images/paish_lafz-dark.png',
                      text: 'پیش لفظ',
                      sub: 'عبد الحمید قادری عفی عنہ',
                      audioPath: '',
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  children: [
                    // Widget secondBox() {
                    //   return Container(
                    //     padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                    //     margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    //     height: 140,
                    //     width: double.infinity,
                    //     decoration: BoxDecoration(
                    //         color: Color.fromARGB(129, 0, 165, 165),
                    //         borderRadius: BorderRadiusDirectional.circular(15)),
                    //     child: Row(
                    //       crossAxisAlignment: CrossAxisAlignment.center,
                    //       mainAxisAlignment: MainAxisAlignment.end,
                    //       children: [
                    //         Column(
                    //           crossAxisAlignment: CrossAxisAlignment.end,
                    //           mainAxisAlignment: MainAxisAlignment.end,
                    //           children: [
                    //             Text(
                    //               "سوانح حیات",
                    //               style: GoogleFonts.almarai(
                    //                   fontWeight: FontWeight.bold,
                    //                   fontSize: 20,
                    //                   color: Colors.white),
                    //             ),
                    //             SizedBox(height: 15),
                    //             Text(
                    //               textDirection: TextDirection.rtl,
                    //               "از رشحاِت قلم:",
                    //               style: GoogleFonts.almarai(fontSize: 10, color: Colors.white),
                    //             ),
                    //             Text(
                    //               textDirection: TextDirection.rtl,
                    //               "حضرت سّید محمد ظفر قادری",
                    //               style: GoogleFonts.almarai(fontSize: 10, color: Colors.white),
                    //             ),
                    //             Text(
                    //               textDirection: TextDirection.rtl,
                    //               "قادری رحمة اهلل عليه",
                    //               style: GoogleFonts.almarai(fontSize: 10, color: Colors.white),
                    //             ),
                    //             SizedBox(height: 10),
                    //           ],
                    //         ),
                    //         SizedBox(width: 05),
                    //         ClipRRect(
                    //           borderRadius: BorderRadius.circular(20.0), // Radius of the corners
                    //           child: Image.asset(
                    //             "assets/images/sawana.png", // Replace with your image asset
                    //             width: 110.0, // Set the desired width
                    //             height: 110.0, // Set the desired height
                    //             fit: BoxFit.fill, // Ensures the image covers the entire area
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   );
                    // }
                    LongBox(
                      audioPath: '',
                      imagePath: 'assets/images/sawana-white.png',
                      mainText: "سوانح حیات",
                      subText1: "از رشحاِت قلم:",
                      subText2:
                          " حضرت سّید محمد ظفر قادری قادری رحمة اهلل عليه",
                      backgroundColor: Color(0xFF00BEAE),
                    ),
                    SizedBox(height: 10),
                    LongBox(
                      audioPath: '',
                      imagePath: 'assets/images/qalbesaleem.png',
                      mainText: 'قلبِ سلیم',
                      subText1: 'از رشحاِت قلم',
                      subText2: 'سّید محمد فراز شاہ مشہدی قادری عفی عنہ',
                      backgroundColor: Color(0xFF1373BF),
                    ),
                    SizedBox(height: 10),
                    LongBox(
                        audioPath: '',
                        imagePath: 'assets/images/aqwal-white.png',
                        mainText: 'اقوال و ارشاداِت عالیہ',
                        subText1:
                            'امام االولیاء حضرت پیر سّید محّمد عبد اهلل شاہ',
                        subText2: ' مشہدی قادری رحمة اهلل تعالى عليه  ',
                        backgroundColor: Color(0xFF2B3491)),
                  ],
                ),
              ),

                  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: LongBox(
                  imagePath: 'assets/images/alfiraq-white.png',
                  mainText: 'الفراق',
                  subText1: 'از رشحاِت قلم',
                  subText2: 'حضرت سّید محمد ظفر مشہدی قادری رحمة اهلل عليه ',
                  backgroundColor: Color(0xFF281E63),
                  audioPath: '',
                ),
              ),
              SizedBox(height:20),
Container(
  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
  alignment: Alignment.bottomRight,
  decoration: BoxDecoration(
    image: DecorationImage(image: AssetImage("assets/new_images/video.png"), fit: BoxFit.cover),
    borderRadius: BorderRadiusDirectional.circular(10), color: Colors.black),
  height: 200, width: MediaQuery.of(context).size.width*0.9,
  child: Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Text("صدائے عبد اللہ دستاویزی فلم", style:  GoogleFonts.almarai(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.white),
                ),
      SizedBox(width: 10),
      Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red, ),
      width:50, height: 50,
      child: IconButton(
        icon: Icon(Icons.play_arrow, color: Colors.white, size: 30),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => FullScreenVideoPlayer(),
            ),
          );
        },
      ),

      ),
    ],
  ),
),
SizedBox(height: 20,),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                width: double.infinity,
                height: 520,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          "assets/images/upergrad.png",
                        ),
                        fit: BoxFit.fill)),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                        width: 200,
                        height: 80,
                        decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage("assets/new_images/home_banner.png", ),fit: BoxFit.contain,)
                        ),
                      child: Text(
                        "شجرٔہ قادریہ",
                        style: GoogleFonts.almarai(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          textAlign: TextAlign.center,
                          "امام االولیاء حضرت پیر سّید محمد عبد الله شاہ مشہدی قادری رحمة اهلل عليه",
                          style: GoogleFonts.almarai(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              CustomPageNavigation(
                                child: ShajrEQadriaScreen(text: "nasbiya"),
                              ),
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                20.0), // Radius of the corners
                            child: Image.asset(
                              "assets/images/shajra_nasbia.png", // Replace with your image asset
                              width: MediaQuery.of(context).size.width *
                                  0.46, // Set the desired width
                              height: 110.0, // Set the desired height
                              fit: BoxFit
                                  .cover, // Ensures the image covers the entire area
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              CustomPageNavigation(
                                child: ShajrEQadriaScreen(text: "hasbiya"),
                              ),
                            );
                          },

///ISKO SET KRIIIIIIN 



                          child: Container(
                            height:110,
                           width: MediaQuery.of(context).size.width *
                                  0.46,
                            decoration: BoxDecoration(
                              image: DecorationImage(image: AssetImage("assets/images/shajra_hasbia.png"),
                              fit: BoxFit
                                  .fill,
                              
                              ),
                              borderRadius: BorderRadiusDirectional.circular(0)
                            ),
                               // Replace with your image asset
                               // Ensures the image covers the entire area
                            ),
                          
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              CustomPageNavigation(
                                child: ShajrEQadriaScreen(text: "nasbiya"),
                              ),
                            );
                          },
                          child: Container(
                           alignment: Alignment.center,
                         width: MediaQuery.of(context).size.width *
                                0.46,
                        height: 75,
                        decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage("assets/new_images/long_container.png", ),fit: BoxFit.fill,colorFilter: ColorFilter.mode(
        Color(0xFF2B3491), // Adjust opacity as needed
        BlendMode.srcATop, // Choose the blend mode that works best
      ),)
                        ),
                            child: Text(
                              "شجرٔہ قادریہ نسبیہ",
                              style: GoogleFonts.almarai(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              CustomPageNavigation(
                                  child: ShajrEQadriaScreen(text: "hasbiya")),
                            );
                          },

                          child: Container(
  alignment: Alignment.center,
 width: MediaQuery.of(context).size.width *
                                0.46,
  height: 75,
  child: Stack(
    children: [
      Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(3.1416), // Flip the image horizontally
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/new_images/long_container.png"),
              fit: BoxFit.fill,
              colorFilter: ColorFilter.mode(
                Color(0xFF2B3491), // Adjust opacity as needed
                BlendMode.srcATop, // Choose the blend mode that works best
              ),
            ),
          ),
        ),
      ),
      Center(
        child: Text(
          "شجرٔہ قادریہ حسبیہ",
          textDirection: TextDirection.rtl,
          style: GoogleFonts.almarai(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    ],
  ),
)

                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              CustomPageNavigation(
                                child: SoundPlayer(
                                  image: "assets/images/shajra_nasbia.png",
                                  name: "شجرٔہ قادریہ نسبیہ",
                                  sub: "منظوم مع تضمین",
                                ),
                              ),
                            );
                          },
                            child: Container(
  height: 75,
  width: MediaQuery.of(context).size.width * 0.46, // Set the desired width
  alignment: Alignment.center,
  child: Stack(
    children: [
      // Flipping the background image horizontally
      Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(3.1416), // Flip the image horizontally
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/new_images/border_container.png"),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
      // Text remains centered and unaffected by the image flip
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "شجرٔہ قادریہ نسبیہ",
              style: GoogleFonts.almarai(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              "منظوم مع تضمین",
              textDirection: TextDirection.rtl,
              style: GoogleFonts.almarai(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    ],
  ),
)

                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              CustomPageNavigation(
                                  child: SoundPlayer(
                                image: "assets/images/shajra_hasbia.png",
                                name: "شجرٔہ قادریہ حسبیہ",
                                sub: "منظوم مع تضمین",
                              )),
                            );
                          },
                          child: Container(
                            height: 75,
                            width: MediaQuery.of(context).size.width *
                                0.46, // Set the desired width

                            alignment: Alignment.center,
                             decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/new_images/border_container.png"),
              fit: BoxFit.fill,)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  textDirection: TextDirection.rtl,
                                  "شجرٔہ قادریہ حسبیہ",
                                  style: GoogleFonts.almarai(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Text(
                                  textDirection: TextDirection.rtl,
                                  "منظوم مع تضمین",
                                  style: GoogleFonts.almarai(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),
          
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          CustomPageNavigation(
                            child: SoundPlayer(
                              image: "assets/images/manqabat2-dark.png",
                              name: "منقبت",
                              sub: 'عبد الحمید قادری عفی عنہ',
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width *
                            0.44, // Set the desired width

                        alignment: Alignment.center,
                         decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/new_images/long_container.png"),
              fit: BoxFit.fill, colorFilter: ColorFilter.mode(
        Color(0xFF00A79D), // Adjust opacity as needed
        BlendMode.srcATop, // Choose the blend mode that works best
      ),)),
                       
                        child: Text(
                          "منقبت",
                          style: GoogleFonts.almarai(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          CustomPageNavigation(
                            child: SoundPlayer(
                              image: "assets/images/qata-dark.png",
                              name: "قطعہ تاریخ وصال",
                              sub:
                                  'حضرت ابو الحقائق پیر سّید امانت علی شاہ چشتی نظامی',
                            ),
                          ),
                        );
                      },
                      child: Stack(
  children: [
    // Flipping the background image horizontally
    Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationY(3.1416), // Flip the image horizontally
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width * 0.44,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/new_images/long_container.png"),
            fit: BoxFit.fill,
            colorFilter: ColorFilter.mode(
              Color(0xFF1373BF),
              BlendMode.srcATop,
            ),
          ),
        ),
      ),
    ),
    // Text remains unaffected by the flip
    Container(
      height: 60,
      width: MediaQuery.of(context).size.width * 0.44,
      alignment: Alignment.center,
      child: Text(
        "قطعہ تاریخ وصال",
        style: GoogleFonts.almarai(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),
  ],
)

                    )
                  ],
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    CustomPageNavigation(
                      child: hawashiwahawalajatScreen(),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                 
                  alignment: Alignment.center,
                        width: double.infinity,
                        height: 70,
                        decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage("assets/new_images/home_banner.png", ),fit: BoxFit.fill,colorFilter: ColorFilter.mode(
              Color(0xFF0FA8E2),
              BlendMode.srcATop,
            ),)),
                  child: Text(
                    "حواشی و حوالہ جات",
                    style: GoogleFonts.almarai(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                  width: double.infinity,
                  decoration:
                      BoxDecoration(color: Color(0xFF2B3491)),
                  child: Column(children: [
                    Container(
                      height: 240,

                      width: double.infinity, // Set the desired width

                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(20),
                          color: Color(0xFF162170)),
                      child: Image.asset("assets/images/hizb.png",fit: BoxFit.contain,width: 130,),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "© 2021",
                      style: GoogleFonts.almarai(
                          fontSize: 18, color: Colors.white),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      textDirection: TextDirection.rtl,
                      "جملہ حقوق بحِق ناشر محفوظ ہیں",
                      style: GoogleFonts.almarai(
                          fontSize: 14,
                          color: Colors.white,),
                    ),
                    Text(
                      textDirection: TextDirection.rtl,
                      "ادارہ تحقیقاِت نواز",
                      style: GoogleFonts.almarai(
                          fontSize: 14,
                          color: Colors.white,),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      textDirection: TextDirection.rtl,
                      "مکتبہ حزب الرح",
                      style: GoogleFonts.almarai(
                          fontSize: 14,
                          color: Color.fromARGB(255, 69, 221, 255),),
                    ),
                    Text(
                      textDirection: TextDirection.rtl,
                      "آستانہ عالیہ قادریہ",
                      style: GoogleFonts.almarai(
                          fontSize: 14,
                          color: Color.fromARGB(255, 69, 221, 255),
   ),
                    ),
                    Text(
                      textDirection: TextDirection.rtl,
                      "حضرت پیر سید محمد عبداهلل شاہ مشہدی قادری",
                      style: GoogleFonts.almarai(
                          fontSize: 14,
                          color: Color.fromARGB(255, 69, 221, 255),
),
                    ),
                    Text(
                      textDirection: TextDirection.rtl,
                      "رحمة اهلل تعالى عليه",
                      style: GoogleFonts.almarai(
                          fontSize: 14,
                          color: Color.fromARGB(255, 69, 221, 255),
                     ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      textDirection: TextDirection.rtl,
                      "موضع قادر بخش شریف، تحصیل کمالیہ",
                      style: GoogleFonts.almarai(
                          fontSize: 14,
                          color: Colors.white,
                     ),
                    ),
                    Text(
                      textDirection: TextDirection.rtl,
                      "ضلع ٹوبہ ٹیک سنگھ، پاکستان",
                      style: GoogleFonts.almarai(
                          fontSize: 14,
                          color: Colors.white,
                     ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                  ])),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/facebook.png",
                    width: 40,
                  ),
                  SizedBox(width: 10),
                  Image.asset(
                    "assets/images/instagram.png",
                    width: 40,
                  ),
                  SizedBox(width: 10),
                  Image.asset(
                    "assets/images/web.png",
                    width: 40,
                  ),
                  SizedBox(width: 10),
                  Image.asset(
                    "assets/images/share.png",
                    width: 40,
                  ),
                  SizedBox(width: 10),
                  Image.asset(
                    "assets/images/gototop.png",
                    width: 40,
                  ),
                  SizedBox(width: 10),
                ],
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
