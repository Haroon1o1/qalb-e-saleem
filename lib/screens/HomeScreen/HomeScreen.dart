import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qalb/Transition/CustomPageTransition.dart';
import 'package:qalb/screens/HomeScreen/LongBox.dart';
import 'package:qalb/screens/HomeScreen/smallContainer.dart';
import 'package:qalb/screens/Shajr_e_Qadria/Shajr_e_Qadria.dart';
import 'package:qalb/screens/hawashi_wa_hawalajat.dart';
import 'package:qalb/screens/majlis_screen.dart';
import 'package:qalb/screens/sound_screen.dart/sound_player.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 60),
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
                  height: MediaQuery.of(context).size.height * 0.33,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          image: AssetImage("assets/images/darbar.png"),
                          fit: BoxFit.fill)),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Text(
                        "فهرست مجالس",
                        style: GoogleFonts.almarai(
                          fontSize: 21,
                          color: Color.fromARGB(255, 69, 221, 255),
                          fontWeight: FontWeight.bold,
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
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SmallContainer(
                      backgroundColor: Colors.transparent,
                      imagePath: 'assets/images/manqabat-dark.png',
                      text: 'منقبت',
                      sub: "حضرت سّید محمد ظفر مشہدی قادری رحمة اهلل عليه",
                      audioPath: 'Audios/al firaaq.mp3',
                    ),
                    SmallContainer(
                      backgroundColor: const Color.fromARGB(255, 20, 5, 128),
                      imagePath: 'assets/images/tashakur.png',
                      text: 'اظہار تشکر',
                      sub: 'سید محمد فراز شاہ عفی عنہ',
                      audioPath: 'Audios/al firaaq.mp3',
                    ),
                    SmallContainer(
                      backgroundColor: Colors.purple,
                      imagePath: 'assets/images/muqadma-dark.png',
                      text: 'مقّدمۃ الکتاب',
                      sub: 'حضرت ابو الحقائق پیر سّید امانت علی شاہ چشتی نظامی',
                      audioPath: 'Audios/al firaaq.mp3',
                    ),
                    SmallContainer(
                      backgroundColor: Colors.green,
                      imagePath: 'assets/images/paish_lafz-dark.png',
                      text: 'پیش لفظ',
                      sub: 'عبد الحمید قادری عفی عنہ',
                      audioPath: 'Audios/al firaaq.mp3',
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
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
                      audioPath: 'Audios/al firaaq.mp3',
                      imagePath: 'assets/images/sawana-white.png',
                      mainText: "سوانح حیات",
                      subText1: "از رشحاِت قلم:",
                      subText2:
                          " حضرت سّید محمد ظفر قادری قادری رحمة اهلل عليه",
                      backgroundColor: Color(0xFF00BEAE),
                    ),
                    SizedBox(height: 10),
                    LongBox(
                      audioPath: 'Audios/al firaaq.mp3',
                      imagePath: 'assets/images/qalbesaleem.png',
                      mainText: 'قلبِ سلیم',
                      subText1: 'از رشحاِت قلم',
                      subText2: 'سّید محمد فراز شاہ مشہدی قادری عفی عنہ',
                      backgroundColor: Color(0xFF1373BF),
                    ),
                    SizedBox(height: 10),
                    LongBox(
                        audioPath: 'Audios/al firaaq.mp3',
                        imagePath: 'assets/images/aqwal-white.png',
                        mainText: 'اقوال و ارشاداِت عالیہ',
                        subText1:
                            'امام االولیاء حضرت پیر سّید محّمد عبد اهلل شاہ',
                        subText2: ' مشہدی قادری رحمة اهلل تعالى عليه  ',
                        backgroundColor: Color(0xFF2B3491)),
                  ],
                ),
              ),
              SizedBox(height:30),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 60),
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
                    Text(
                      "شجرٔہ قادریہ",
                      style: GoogleFonts.almarai(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
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



                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                20.0), // Radius of the corners
                            child: Image.asset(
                              "assets/images/shajra_hasbia.jpg", // Replace with your image asset
                              width: MediaQuery.of(context).size.width *
                                  0.46, // Set the desired width
                              height: 110.0, // Set the desired height
                              fit: BoxFit
                                  .fill, // Ensures the image covers the entire area
                            ),
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
                            height: 75,
                            width: MediaQuery.of(context).size.width *
                                0.46, // Set the desired width

                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadiusDirectional.circular(15),
                                color: Color(0xFF2B3491)),
                            child: Text(
                              "شجرٔہ قادریہ نسبیہ",
                              style: GoogleFonts.almarai(
                                  fontSize: 15,
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
                            height: 75,
                            width: MediaQuery.of(context).size.width *
                                0.46, // Set the desired width

                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadiusDirectional.circular(20),
                                color: Color(0xFF2B3491)),
                            child: Text(
                              textDirection: TextDirection.rtl,
                              "شجرٔہ قادریہ حسبیہ",
                              style: GoogleFonts.almarai(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
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
                                  audioPath: '',
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: 75,
                            width: MediaQuery.of(context).size.width *
                                0.46, // Set the desired width

                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadiusDirectional.circular(20),
                              color: Colors.transparent,
                              border: Border.all(
                                color: Colors.white,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "شجرٔہ قادریہ نسبیہ",
                                  style: GoogleFonts.almarai(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Text(
                                  textDirection: TextDirection.rtl,
                                  "منظوم مع تضمین",
                                  style: GoogleFonts.almarai(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              CustomPageNavigation(
                                  child: SoundPlayer(
                                image: "assets/images/shajra_hasbia.jpg",
                                name: "شجرٔہ قادریہ حسبیہ",
                                sub: "منظوم مع تضمین",
                                audioPath: '',
                              )),
                            );
                          },
                          child: Container(
                            height: 75,
                            width: MediaQuery.of(context).size.width *
                                0.46, // Set the desired width

                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadiusDirectional.circular(20),
                              color: Colors.transparent,
                              border: Border.all(
                                color: Colors.white,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  textDirection: TextDirection.rtl,
                                  "شجرٔہ قادریہ حسبیہ",
                                  style: GoogleFonts.almarai(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Text(
                                  textDirection: TextDirection.rtl,
                                  "منظوم مع تضمین",
                                  style: GoogleFonts.almarai(
                                      fontSize: 15,
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
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: LongBox(
                  imagePath: 'assets/images/alfiraq-white.png',
                  mainText: 'الفراق',
                  subText1: 'از رشحاِت قلم',
                  subText2: 'حضرت سّید محمد ظفر مشہدی قادری رحمة اهلل عليه ',
                  backgroundColor: Color.fromARGB(255, 26, 32, 99),
                  audioPath: 'Audios/al firaaq.mp3',
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 10),
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
                              audioPath: 'Audios/al firaaq.mp3',
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width *
                            0.46, // Set the desired width

                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(20),
                            color: Color(0xFF00A79D)),
                        child: Text(
                          "منقبت",
                          style: GoogleFonts.almarai(
                              fontSize: 15,
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
                              audioPath: 'Audios/al firaaq.mp3',
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width * 0.46,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(20),
                            color: Color(0xFF1373BF)),
                        child: Text(
                          "قطعہ تاریخ وصال",
                          style: GoogleFonts.almarai(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
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
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  height: 60,
                  width: double.infinity, // Set the desired width

                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(20),
                      color: Color(0xFF0891C0)),
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
                      BoxDecoration(color: Color.fromARGB(255, 65, 73, 168)),
                  child: Column(children: [
                    Container(
                      height: 230,

                      width: double.infinity, // Set the desired width

                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(20),
                          color: Color(0xFF2B3491)),
                      child: Image.asset("assets/images/hizb.png"),
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
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      textDirection: TextDirection.rtl,
                      "ادارہ تحقیقاِت نواز",
                      style: GoogleFonts.almarai(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      textDirection: TextDirection.rtl,
                      "مکتبہ حزب الرح",
                      style: GoogleFonts.almarai(
                          fontSize: 14,
                          color: Color.fromARGB(255, 69, 221, 255),
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      textDirection: TextDirection.rtl,
                      "آستانہ عالیہ قادریہ",
                      style: GoogleFonts.almarai(
                          fontSize: 14,
                          color: Color.fromARGB(255, 69, 221, 255),
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      textDirection: TextDirection.rtl,
                      "حضرت پیر سید محمد عبداهلل شاہ مشہدی قادری",
                      style: GoogleFonts.almarai(
                          fontSize: 14,
                          color: Color.fromARGB(255, 69, 221, 255),
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      textDirection: TextDirection.rtl,
                      "رحمة اهلل تعالى عليه",
                      style: GoogleFonts.almarai(
                          fontSize: 14,
                          color: Color.fromARGB(255, 69, 221, 255),
                          fontWeight: FontWeight.bold),
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
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      textDirection: TextDirection.rtl,
                      "ضلع ٹوبہ ٹیک سنگھ، پاکستان",
                      style: GoogleFonts.almarai(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
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
