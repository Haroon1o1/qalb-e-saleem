import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qalb/Transition/CustomPageTransition.dart';
import 'package:qalb/providers/HomeProvider.dart';
import 'package:qalb/screens/HomeScreen/HomeScreen.dart';
import 'package:qalb/screens/Shaja_screens/Shajr_e_Qadria.dart';
import 'package:qalb/screens/aqwal_wa_irshadaat/aqwal_wa_irshadaat.dart';
import 'package:qalb/screens/hawashi_wa_hawalajat/hawalajat.dart';
import 'package:qalb/screens/majlis_screens/majlis_screen.dart';
import 'package:qalb/screens/sound_screen.dart/sound_player.dart';

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
    padding: const EdgeInsets.only(top: 60.0, bottom: 120),
    child: Drawer(
      width: 300, 
      backgroundColor: Color(0xFF2e3192),
      child: 
          Padding(
            padding: const EdgeInsets.only(right: 20, top:15, bottom: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                
                Padding(
                  padding: const EdgeInsets.only(top:8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(onPressed: (){
                        Navigator.pop(context);
                      }, icon: Icon(Icons.close, color: Colors.white,)),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                        
                        "assets/images/drawer.png",
                        width: 130,
                      ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    drawerItems("فهرست مجالس", () {
                   Navigator.pop(context);
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
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      CustomPageNavigation(
                          child: SoundPlayer(
                            tag: "paish",
                              image: 'assets/images/paish_lafz-dark.png',
                              name: "پیش لفظ",
                              sub: 'عبد الحمید قادری عفی عنہ')));
                }),
                drawerItems("مقدمہ الکتاب", () {
                   Navigator.pop(context);
                  Navigator.push(
                      context,
                      CustomPageNavigation(
                          child: SoundPlayer(
                            tag: "maqadma",
                              image: 'assets/images/muqadma-dark.png',
                              name: "مقدمہ الکتاب",
                              sub:
                                  'حضرت ابو الحقائق پیر سّید امانت علی شاہ چشتی نظامی')));
                }),
                drawerItems("اظہار تشکر", () {
                   Navigator.pop(context);
                  Navigator.push(
                      context,
                      CustomPageNavigation(
                          child: SoundPlayer(
                            tag: "tashakur",
                              image: 'assets/images/tashakur.png',
                              name: "اظہار تشکر",
                              sub: 'سید محمد فراز شاہ عفی عنہ')));
                }),
                drawerItems("منقبت", () {
                   Navigator.pop(context);
                  Navigator.push(
                      context,
                      CustomPageNavigation(
                          child: SoundPlayer(
                            tag: "man2",
                              image: 'assets/images/manqabat-dark.png',
                              name: "منقبت",
                              sub:
                                  "حضرت سّید محمد ظفر مشہدی قادری رحمة الله تعالى عليه")));
                }),
                drawerItems("سوانح حیات", () {
                   Navigator.pop(context);
                  Navigator.push(
                      context,
                      CustomPageNavigation(
                          child: SoundPlayer(
                            tag: "sawana",
                              image: 'assets/images/sawane-dark.png',
                              name: "سوانح حیات",
                              sub:
                                  "حضرت سّید محمد ظفر قادری قادری رحمة الله تعالى عليه")));
                }),
                drawerItems("قلب سلیم", () {
                   Navigator.pop(context);
                  Navigator.push(
                      context,
                      CustomPageNavigation(
                          child: SoundPlayer(
                            tag: "qalb",
                              image: 'assets/images/qalb_e_saleem-dark.png',
                              name: "قلب سلیم",
                              sub: 'سّید محمد فراز شاہ مشہدی قادری عفی عنہ')));
                }),
                drawerItems("اقوال و ارشاداتِ عالیہ", () {
                   Navigator.pop(context);
                  Navigator.push(
                      context,
                      CustomPageNavigation(
                          child: AqwalWaIrshadaatScreen(isNavBar: false)));
                }),
                drawerItems("شجرۂ قادریہ حسبیہ", () {
                   Navigator.pop(context);
                  Navigator.push(
                      context,
                      CustomPageNavigation(
                          child: ShajrEQadriaScreen(
                              text: "hasbiya", isNavBar: false)));
                }),
                drawerItems("شجرۂ قادریہ نسبیہ", () {
                   Navigator.pop(context);
                  Navigator.push(
                      context,
                      CustomPageNavigation(
                          child: ShajrEQadriaScreen(
                              text: "nasbiya", isNavBar: false)));
                }),
                drawerItems("شجرۂ حسبیہ منظوم مع تضمین", () {
                   Navigator.pop(context);
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
                   Navigator.pop(context);
                  Navigator.push(
                      context,
                      CustomPageNavigation(
                        child: SoundPlayer(
                          tag: "",
                          image: "assets/images/nasbi.png",
                          name: "شجرٔہ قادریہ نسبیہ",
                          sub: "منظوم مع تضمین",
                        ),
                      ));
                }),
                drawerItems("الفراق", () {
                   Navigator.pop(context);
                  Navigator.push(
                      context,
                      CustomPageNavigation(
                          child: SoundPlayer(
                            tag: "firaq",
                              image: 'assets/images/alfiraq-dark.png',
                              name: 'الفراق',
                              sub:
                                  "'حضرت سّید محمد ظفر مشہدی قادری رحمة الله تعالى عليه'")));
                }),
                drawerItems("قطعہ تاریخ وصال", () {
                   Navigator.pop(context);
                  Navigator.push(
                      context,
                      CustomPageNavigation(
                          child: SoundPlayer(
                            tag: "qata",
                              image: "assets/images/qata-dark.png",
                              name: "قطعہ تاریخ وصال",
                              sub:
                                  'حضرت ابو الحقائق پیر سّید امانت علی شاہ چشتی نظامی')));
                }),
                drawerItems("منقبت", () {
                   Navigator.pop(context);
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
                   Navigator.pop(context);
                  Navigator.push(context,
                      CustomPageNavigation(child: HawalajatPdf()));
                }),
                  ],
                ),
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
            color: Color(0xFFdee5f9),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 10),
        Padding(
          padding: const EdgeInsets.only(top: 2.0),
          child: Icon(
            Icons.arrow_back_ios,
            color: Color(0xFFdee5f9),
            size: 13,
          ),
        )
      ]),
    ),
  );
}
