import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qalb/Transition/CustomPageTransition.dart';
import 'package:qalb/providers/DataProvider.dart';
import 'package:qalb/providers/HomeProvider.dart';
import 'package:qalb/screens/HomeScreen/LongBox.dart';
import 'package:qalb/screens/HomeScreen/smallContainer.dart';
import 'package:qalb/screens/HomeScreen/uperContainer.dart';
import 'package:qalb/screens/Shaja_screens/Shajr_e_Qadria.dart';
import 'package:qalb/screens/aqwal_wa_irshadaat/aqwal_wa_irshadaat.dart';
import 'package:qalb/screens/hawashi_wa_hawalajat/hawashi_wa_hawalajat.dart';
import 'package:qalb/screens/majlis_screens/majlis_screen.dart';
import 'package:qalb/screens/sound_screen.dart/sound_player.dart';
import 'package:qalb/utils/videoPlayer.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class BottomNavBarScreen extends StatefulWidget {
  @override
  _BottomNavBarScreenState createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final PageController _pageController = PageController();

  double _linePosition = 0.0;
  double _lineWidth = 0.0;
  final List<GlobalKey> _navItemKeys = List.generate(4, (_) => GlobalKey());

  final List<Widget> _pages = [
    Home(),
    AqwalWaIrshadaatScreen(isNavBar: true),
    ShajrEQadriaScreen(text: "hasbiya", isNavBar: true),
    Majlis(isNavBar: true),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<HomeNavBarProvider>(context, listen: false);
      _updateLinePosition(provider.selectedIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeNavBarProvider>(context);
 

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: []);
    return Scaffold(
      endDrawer: buildDrawer(context),
      key: _scaffoldKey,
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          provider.setSelectedIndex(index);
          _updateLinePosition(index);
        },
        children: _pages,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        backgroundColor: const Color(0xFF345EF1),
        foregroundColor: Colors.white,
        onPressed: () {
          provider.setSelectedIndex(3); // Set to index of Majlis page
          _pageController.jumpToPage(3); // Navigate to Majlis page
          _updateLinePosition(3); // Update line position for Majlis
        },
        child: Image.asset(
          width: 25,
          "assets/new_images/dash.png",
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      buildNavItem(0, "assets/new_images/home.png", "هوم", _navItemKeys[0]),
                      const SizedBox(width: 30),
                      buildNavItem(1, "assets/new_images/box.png", "اقوال و ارشاداتِ", _navItemKeys[1]),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:20.0),
                    child: Text("مجالس", style: GoogleFonts.almarai(fontSize:10, color: provider.selectedIndex == 3 ? Color(0xFF345EF1) : Colors.grey),),
                  ),
                  Row(
                    children: [
                      buildNavItem(2, "assets/new_images/page.png", "شجرۂ قادریہ", _navItemKeys[2]),
                      const SizedBox(width: 30),
                      buildNavItem(3, "assets/new_images/menu.png", "مضامین", _navItemKeys[3]),
                    ],
                  ),
                ],
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              left: _linePosition,
              bottom: 0,
              child: Container(
                height: 3,
                width: _lineWidth,
                decoration: BoxDecoration(
                  color: provider.selectedIndex == 3 ? Colors.white : Color(0xFF345EF1),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
        shape: const CircularNotchedRectangle(),
      ),
    );
  }

  Widget buildNavItem(int index, String icon, String text, GlobalKey key) {
    final provider = Provider.of<HomeNavBarProvider>(context);

    return GestureDetector(
      onTap: () {
        if (index == 3) {
          // Open the drawer for index 3
          _scaffoldKey.currentState?.openEndDrawer();
        } else {
          // Update page and line position for other indexes
          provider.setSelectedIndex(index);
          _pageController.jumpToPage(index);
          _updateLinePosition(index);
        }
      },
      key: key,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            icon,
            width: 20,
            color: provider.selectedIndex == 3 ? Colors.grey : provider.selectedIndex == index ? const Color(0xFF345EF1) : Colors.grey,
          ),
          Text(
            text,
            style: provider.selectedIndex == 3 ? GoogleFonts.almarai(
              fontSize: 10,
              color: Colors.grey,
            ) : GoogleFonts.almarai(
              fontSize: 10,
              color: provider.selectedIndex == index ? const Color(0xFF345EF1) : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  void _updateLinePosition(int index) {
    final RenderBox? renderBox = _navItemKeys[index].currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final size = renderBox.size;
      final offset = renderBox.localToGlobal(Offset.zero);

      setState(() {
        _lineWidth = size.width;
        _linePosition = offset.dx + (size.width - _lineWidth-31) / 2;
      });
    }
  }
}

Widget buildDrawer(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 40.0, bottom: 10),
    child: Drawer(
      width: 270,
      backgroundColor: Color(0xFF2F49D1),
      child: 
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(onPressed: (){
                      Navigator.pop(context);
                    }, icon: Icon(Icons.close, color: Colors.white,)),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, right: 0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                        "assets/images/icon.png",
                        width: 70,
                      ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                drawerItems("فهرست مجالس", () {
                  Navigator.push(
                    context,
                    CustomPageNavigation(
                      child: Majlis(
                        isNavBar: false,
                      ),
                    ),
                  );
                }),
                drawerItems("پیش لفظ", () {
                  Navigator.push(
                      context,
                      CustomPageNavigation(
                          child: SoundPlayer(
                            tag: "",
                              image: 'assets/images/paish_lafz-dark.png',
                              name: "پیش لفظ",
                              sub: 'عبد الحمید قادری عفی عنہ')));
                }),
                drawerItems("مقدمہ الکتاب", () {
                  Navigator.push(
                      context,
                      CustomPageNavigation(
                          child: SoundPlayer(
                            tag: "",
                              image: 'assets/images/muqadma-dark.png',
                              name: "مقدمہ الکتاب",
                              sub:
                                  'حضرت ابو الحقائق پیر سّید امانت علی شاہ چشتی نظامی')));
                }),
                drawerItems("اظہار تشکر", () {
                  Navigator.push(
                      context,
                      CustomPageNavigation(
                          child: SoundPlayer(
                            tag: "",
                              image: 'assets/images/tashakur.png',
                              name: "اظہار تشکر",
                              sub: 'سید محمد فراز شاہ عفی عنہ')));
                }),
                drawerItems("منقبت", () {
                  Navigator.push(
                      context,
                      CustomPageNavigation(
                          child: SoundPlayer(
                            tag: "",
                              image: 'assets/images/manqabat-dark.png',
                              name: "منقبت",
                              sub:
                                  "حضرت سّید محمد ظفر مشہدی قادری رحمة الله تعالى عليه")));
                }),
                drawerItems("سوانح حیات", () {
                  Navigator.push(
                      context,
                      CustomPageNavigation(
                          child: SoundPlayer(
                            tag: "",
                              image: 'assets/images/sawane-dark.png',
                              name: "سوانح حیات",
                              sub:
                                  "حضرت سّید محمد ظفر قادری قادری رحمة الله تعالى عليه")));
                }),
                drawerItems("قلب سلیم", () {
                  Navigator.push(
                      context,
                      CustomPageNavigation(
                          child: SoundPlayer(
                            tag: "",
                              image: 'assets/images/qalb_e_saleem-dark.png',
                              name: "قلب سلیم",
                              sub: 'سّید محمد فراز شاہ مشہدی قادری عفی عنہ')));
                }),
                drawerItems("اقوال و ارشاداتِ عالیہ", () {
                  Navigator.push(
                      context,
                      CustomPageNavigation(
                          child: AqwalWaIrshadaatScreen(isNavBar: false)));
                }),
                drawerItems("شجرۂ قادریہ حسبیہ", () {
                  Navigator.push(
                      context,
                      CustomPageNavigation(
                          child: ShajrEQadriaScreen(
                              text: "hasbiya", isNavBar: false)));
                }),
                drawerItems("شجرۂ قادریہ نسبیہ", () {
                  Navigator.push(
                      context,
                      CustomPageNavigation(
                          child: ShajrEQadriaScreen(
                              text: "nasbiya", isNavBar: false)));
                }),
                drawerItems("شجرۂ حسبیہ منظوم مع تضمین", () {
                  Navigator.push(
                      context,
                      CustomPageNavigation(
                          child: SoundPlayer(
                            tag: "",
                        image: "assets/images/shajra_hasbia.png",
                        name: "شجرٔہ قادریہ حسبیہ",
                        sub: "منظوم مع تضمین",
                      )));
                }),
                drawerItems("شجرۂ نسبیہ منظوم مع تضمین", () {
                  Navigator.push(
                      context,
                      CustomPageNavigation(
                        child: SoundPlayer(
                          tag: "",
                          image: "assets/images/shajra_nasbia.png",
                          name: "شجرٔہ قادریہ نسبیہ",
                          sub: "منظوم مع تضمین",
                        ),
                      ));
                }),
                drawerItems("الفراق", () {
                  Navigator.push(
                      context,
                      CustomPageNavigation(
                          child: SoundPlayer(
                            tag: "",
                              image: 'assets/images/alfiraq-dark.png',
                              name: 'الفراق',
                              sub:
                                  "'حضرت سّید محمد ظفر مشہدی قادری رحمة الله تعالى عليه'")));
                }),
                drawerItems("قطعہ تاریخ وصال", () {
                  Navigator.push(
                      context,
                      CustomPageNavigation(
                          child: SoundPlayer(
                            tag: "",
                              image: "assets/images/qata-dark.png",
                              name: "قطعہ تاریخ وصال",
                              sub:
                                  'حضرت ابو الحقائق پیر سّید امانت علی شاہ چشتی نظامی')));
                }),
                drawerItems("منقبت", () {
                  Navigator.push(
                      context,
                      CustomPageNavigation(
                          child: SoundPlayer(
                            tag: "",
                              image: "assets/images/manqabat2-dark.png",
                              name: "منقبت",
                              sub: 'عبد الحمید قادری عفی عنہ')));
                }),
                drawerItems("حواشی و حوالہ جات", () {
                  Navigator.push(context,
                      CustomPageNavigation(child: hawashiwahawalajatScreen()));
                }),
                SizedBox(
                  height: 0,
                ),
              ],
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 20.0, right: 10),
          //   child: Divider(
          //     color: Colors.white54,
          //     thickness: 2,
          //   ),
          // ),
          // SizedBox(height: 5),
          // Padding(
          //   padding: const EdgeInsets.only(right: 10.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     children: [
          //       Container(
          //         width: 35,
          //         padding: EdgeInsets.all(8),
          //         height: 35,
          //         decoration: BoxDecoration(
          //             borderRadius: BorderRadiusDirectional.circular(10),
          //             color: Color(0xFF00FFFF)),
          //         child: Image.asset(
          //           "assets/new_images/fb.png",
          //           color: Color(0xFF2F49D1),
          //         ),
          //       ),
          //       SizedBox(width: 5),
          //       Container(
          //         width: 35,
          //         padding: EdgeInsets.all(8),
          //         height: 35,
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadiusDirectional.circular(10),
          //           color: Color(0xFF00FFFF),
          //         ),
          //         child: Image.asset(
          //           "assets/new_images/insta.png",
          //           color: Color(0xFF2F49D1),
          //         ),
          //       ),
          //       SizedBox(width: 5),
          //       Container(
          //         width: 35,
          //         padding: EdgeInsets.all(8),
          //         height: 35,
          //         decoration: BoxDecoration(
          //             borderRadius: BorderRadiusDirectional.circular(10),
          //             color: Color(0xFF00FFFF)),
          //         child: Image.asset(
          //           "assets/new_images/world.png",
          //           color: Color(0xFF2F49D1),
          //         ),
          //       ),
          //       SizedBox(width: 5),
          //       GestureDetector(
          //           onTap: () {
          //             Share.share(
          //                 'Download Qalb-E-Saleem App: https://play.google.com/store/apps/details?id=com.hizburehman.qalb_e_saleem&hl=en');
          //           },
          //           child: Container(
          //             width: 35,
          //             padding: EdgeInsets.all(8),
          //             height: 35,
          //             decoration: BoxDecoration(
          //               borderRadius: BorderRadiusDirectional.circular(10),
          //               color: Color(0xFF00FFFF),
          //             ),
          //             child: Image.asset(
          //               "assets/new_images/share.png",
          //               color: Color(0xFF2F49D1),
          //             ),
          //           )),
          //     ],
          //   ),
          // ),
        
    ),
  );
}

Widget drawerItems(String text, GestureTapCallback onTap) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 15.0),
    child: GestureDetector(
      onTap: onTap,
      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Text(
          text,
          style: GoogleFonts.almarai(
            fontSize: 12,
            color: Color(0xFF00FFFF),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 10),
        Padding(
          padding: const EdgeInsets.only(top: 2.0),
          child: Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF00FFFF),
            size: 13,
          ),
        )
      ]),
    ),
  );
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ScrollController _scrollController = ScrollController();
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
     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black,
    statusBarColor: Colors.transparent, // Make status bar transparent
    statusBarIconBrightness: Brightness.dark
  ));

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: []);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 40, right: 15, left: 15),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          CustomPageNavigation(
                            child: Majlis(
                              isNavBar: false,
                            ),
                          ),
                        );
                      },
                      child: UpperContainer(),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SmallContainer(
                          backgroundColor: Color(0xFF10A8E3),
                          imagePath: 'assets/images/manqabat-dark.png',
                          text: 'منقبت',
                          sub:
                              "حضرت سّید محمد ظفر مشہدی قادری رحمة الله تعالى عليه",
                              tag:"manqabat",
                          audioPath: '',
                        ),
                        SmallContainer(
                           tag:"tashakur",
                          backgroundColor: Color(0xFF2C3491),
                          imagePath: 'assets/images/tashakur.png',
                          text: 'اظہار تشکر',
                          sub: 'سید محمد فراز شاہ عفی عنہ',
                          audioPath: '',
                        ),
                        SmallContainer(
                           tag:"maqadma",
                          backgroundColor: Color(0xFF692592),
                          imagePath: 'assets/images/muqadma-dark.png',
                          text: 'مقّدمۃ الکتاب',
                          sub:
                              'حضرت ابو الحقائق پیر سّید امانت علی شاہ چشتی نظامی',
                          audioPath: '',
                        ),
                        SmallContainer(
                           tag:"paish",
                          backgroundColor: Color(0xFF00B771),
                          imagePath: 'assets/images/paish_lafz-dark.png',
                          text: 'پیش لفظ',
                          sub: 'عبد الحمید قادری عفی عنہ',
                          audioPath: '',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [
                          LongBox(
                            tag: "sawana",
                            audioPath: '',
                            imagePath: 'assets/images/sawaneh-hayat.png',
                            mainText: "سوانح حیات",
                            subText1: "از رشحاِت قلم:",
                            subText2:
                                " حضرت سّید محمد ظفر قادری رحمة الله تعالى عليه",
                            backgroundColor: Color(0xFF00BEAE),
                          ),
                          SizedBox(height: 10),
                          LongBox(
                            tag: "qalb",
                            audioPath: '',
                            imagePath: 'assets/images/qalb-e-saleem.png',
                            mainText: 'قلبِ سلیم',
                            subText1: 'از رشحاِت قلم',
                            subText2: 'سّید محمد فراز شاہ مشہدی قادری عفی عنہ',
                            backgroundColor: Color(0xFF1373BF),
                          ),
                          SizedBox(height: 10),
                          LongBox(
                            tag: "",
                              audioPath: '',
                              imagePath: 'assets/images/aqwal-white.png',
                              mainText: 'اقوال و ارشاداِت عالیہ',
                              subText1:
                                  'امام االولیاء حضرت پیر سّید محّمد عبد الله شاہ',
                              subText2: 'مشہدی قادری رحمة الله تعالى عليه',
                              backgroundColor: Color(0xFF2B3491)),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      alignment: Alignment.bottomRight,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(Provider.of<DataProvider>(context, listen: false).gif),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(40),
                          ),
                          color: Colors.black),
                      height: 230,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "صدائے عبد اللہ دستاویزی فلم",
                            style: GoogleFonts.almarai(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.white),
                          ),
                          SizedBox(width: 15),
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                            ),
                            width: 55,
                            height: 55,
                            child: IconButton(
                              icon: Icon(Icons.play_arrow,
                                  color: Colors.white, size: 35),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        FullScreenVideoPlayer(),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                width: double.infinity,
                height: 490,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          "assets/images/upergrad.png",
                        ),
                        fit: BoxFit.fill)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "شجرٔہ قادریہ",
                      style: GoogleFonts.almarai(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 15),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          textAlign: TextAlign.center,
                          "امام االولیاء حضرت پیر سّید محمد عبد الله شاہ مشہدی قادری رحمة الله تعالى عليه",
                          style: GoogleFonts.almarai(
                              fontSize: 13,
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
                                child: ShajrEQadriaScreen(
                                    text: "nasbiya", isNavBar: false),
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
                                child: ShajrEQadriaScreen(
                                    text: "hasbiya", isNavBar: false),
                              ),
                            );
                          },
      
                          ///ISKO SET KRIIIIIIN
                          child: Container(
                            height: 110,
                            width: MediaQuery.of(context).size.width * 0.46,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    "assets/new_images/shajra-hasbia.png"),
                                fit: BoxFit.fill,
                              ),
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
                                child: ShajrEQadriaScreen(
                                    text: "nasbiya", isNavBar: false),
                              ),
                            );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.46,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadiusDirectional.circular(20),
                              color:
                                  Color(0xFF2B3491), // Adjust opacity as needed
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
                                    child: ShajrEQadriaScreen(
                                        text: "hasbiya", isNavBar: false)),
                              );
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width * 0.46,
                              height: 80,
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Color(
                                          0xFF2B3491), // Adjust opacity as needed
                                      borderRadius:
                                          BorderRadiusDirectional.circular(20),
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
                            ))
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
                                     tag:"sajra-nasbi",
                                    image: "assets/images/shajra_nasbia.png",
                                    name: "شجرٔہ قادریہ نسبیہ",
                                    sub: "منظوم مع تضمین",
                                  ),
                                ),
                              );
                            },
                            child: Hero(
                              tag:"sajra-nasbi",
                              child: Container(
                                height: 80,
                                width: MediaQuery.of(context).size.width *
                                    0.46, // Set the desired width
                                alignment: Alignment.center,
                                child: Stack(
                                  children: [
                                    // Flipping the background image horizontally
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadiusDirectional.circular(20),
                                        border: Border.all(color: Colors.white),
                                      ),
                                    ),
                                    // Text remains centered and unaffected by the image flip
                                    Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "شجرٔہ قادریہ نسبیہ",
                                            style: GoogleFonts.almarai(
                                              decoration: TextDecoration.none,
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            "منظوم مع تضمین",
                                            textDirection: TextDirection.rtl,
                                            style: GoogleFonts.almarai(
                                              decoration: TextDecoration.none,
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
                              ),
                            )),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              CustomPageNavigation(
                                  child: SoundPlayer(
                                image: "assets/images/shajra_hasbia.png",
                                name: "شجرٔہ قادریہ حسبیہ",
                                sub: "منظوم مع تضمین",
                                tag:"sajra"
                              )),
                            );
                          },
                          child: Hero(
                            tag:"sajra",
                            child: Container(
                              height: 80,
                              width: MediaQuery.of(context).size.width *
                                  0.46, // Set the desired width
                            
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadiusDirectional.circular(20),
                                border: Border.all(color: Colors.white),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    textDirection: TextDirection.rtl,
                                    "شجرٔہ قادریہ حسبیہ",
                                    style: GoogleFonts.almarai(
                                      decoration: TextDecoration.none,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    textDirection: TextDirection.rtl,
                                    "منظوم مع تضمین",
                                    style: GoogleFonts.almarai(
                                      decoration: TextDecoration.none,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
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
                  tag: "firaq",
                  imagePath: 'assets/images/alfiraq-white.png',
                  mainText: 'الفراق',
                  subText1: 'از رشحاِت قلم',
                  subText2:
                      'حضرت سّید محمد ظفر مشہدی قادری رحمة الله تعالى عليه ',
                  backgroundColor: Color(0xFF281E63),
                  audioPath: '',
                ),
              ),
              SizedBox(height: 12),
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
      
                               tag:"man2",
                              image: "assets/images/manqabat2-dark.png",
                              name: "منقبت",
                              sub: 'عبد الحمید قادری عفی عنہ',
                            ),
                          ),
                        );
                      },
                      child: Hero(
                        tag:"man2",
                        child: Container(
                          height: 70,
                          width: MediaQuery.of(context).size.width *
                              0.46, // Set the desired width
                        
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(15),
                            color: Color(0xFF00A79D), // Adjust opacity as needed
                          ),
                        
                          child: Text(
                            "منقبت",
                            style: GoogleFonts.almarai(
                              decoration: TextDecoration.none,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          CustomPageNavigation(
                            child: SoundPlayer(
                               tag:"qata",
                              image: "assets/images/qata-dark.png",
                              name: "قطعہ تاریخ وصال",
                              sub:
                                  'حضرت ابو الحقائق پیر سّید امانت علی شاہ چشتی نظامی',
                            ),
                          ),
                        );
                      },
                      child: Hero(
                        tag:"qata",
                        child: Container(
                          height: 70,
                          width: MediaQuery.of(context).size.width *
                              0.46, // Set the desired width
                        
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(15),
                            color: Color(0xFF00A79D), // Adjust opacity as needed
                          ),
                        
                          child: Text(
                            "قطعہ تاریخ وصال",
                            style: GoogleFonts.almarai(
                              decoration: TextDecoration.none,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
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
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(15),
                    color: Color(0xFF0FA8E2),
                  ),
                  child: Text(
                    "حواشی و حوالہ جات",
                    style: GoogleFonts.almarai(
                      
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 35),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                  width: double.infinity,
                  decoration: BoxDecoration(color: Color(0xFF2B3491)),
                  child: Column(children: [
                    GestureDetector(
                      onTap: (){
                        _launchUrl("https://www.hizb-ur-rahman.com/");
                      },
                      child: Container(
                        height: 240,
                      
                        width: double.infinity, // Set the desired width
                      
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(20),
                            color: Color(0xFF162170)),
                        child: Image.asset(
                          "assets/images/hizb.png",
                          fit: BoxFit.contain,
                          height: 300,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "© 2024",
                      style: GoogleFonts.almarai(
                          fontSize: 20, color: Colors.white),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      textDirection: TextDirection.rtl,
                      "جملہ حقوق بحِق ناشر محفوظ ہیں",
                      style: GoogleFonts.almarai(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      textDirection: TextDirection.rtl,
                      "ادارہ تحقیقاِت نواز",
                      style: GoogleFonts.almarai(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      textDirection: TextDirection.rtl,
                      "مکتبہ حزب الرحمٰن",
                      style: GoogleFonts.almarai(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 69, 221, 255),
                      ),
                    ),
                    Text(
                      textDirection: TextDirection.rtl,
                      "آستانہ عالیہ قادریہ",
                      style: GoogleFonts.almarai(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 69, 221, 255),
                      ),
                    ),
                    Text(
                      textDirection: TextDirection.rtl,
                      "حضرت پیر سید محمد عبداللہ شاہ مشہدی قادری",
                      style: GoogleFonts.almarai(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 69, 221, 255),
                      ),
                    ),
                    Text(
                      textDirection: TextDirection.rtl,
                      "رحمة الله تعالى عليه",
                      style: GoogleFonts.almarai(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
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
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      textDirection: TextDirection.rtl,
                      "ضلع ٹوبہ ٹیک سنگھ، پاکستان",
                      style: GoogleFonts.almarai(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                  ])),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      _launchUrl("https://www.facebook.com/profile.php?id=100081278269074");
                    },
                    child: Image.asset(
                      "assets/images/facebook.png",
                      width: 40,
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: (){
                      _launchUrl("https://www.instagram.com/qalbesaleem_?igsh=Z3F4NjVpNHZ1amdj");
                    },
                    child: Image.asset(
                      "assets/images/instagram.png",
                      width: 40,
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: (){
                      _launchUrl("https://www.qalb-e-saleem.com");
                    },
                    child: Image.asset(
                      "assets/images/web.png",
                      width: 40,
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      Share.share(
                          'Download Qalb-E-Saleem App: https://play.google.com/store/apps/details?id=com.hizburehman.qalb_e_saleem&hl=en');
                    },
                    child: Image.asset(
                      "assets/images/share.png",
                      width: 40,
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      _scrollController.animateTo(
                        0.0,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Image.asset(
                      "assets/images/gototop.png",
                      width: 40,
                    ),
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

   Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw new Exception("NAI CHALA");
    }
  }
}
