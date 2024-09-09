import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qalb/Transition/CustomPageTransition.dart';
import 'package:qalb/providers/HomeProvider.dart';
import 'package:qalb/screens/HomeScreen/LongBox.dart';
import 'package:qalb/screens/HomeScreen/smallContainer.dart';
import 'package:qalb/screens/Shaja_screens/Shajr_e_Qadria.dart';
import 'package:qalb/screens/aqwal_wa_irshadaat/aqwal_wa_irshadaat.dart';
import 'package:qalb/screens/hawashi_wa_hawalajat/hawashi_wa_hawalajat.dart';
import 'package:qalb/screens/majlis_screens/majlis_screen.dart';
import 'package:qalb/screens/sound_screen.dart/sound_player.dart';
import 'package:qalb/utils/videoPlayer.dart';

import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class BottomNavBarScreen extends StatefulWidget {
  @override
  _BottomNavBarScreenState createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(
      initialPage: context.read<HomeNavBarProvider>().selectedIndex,
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final navBarProvider = Provider.of<HomeNavBarProvider>(context);

    return Scaffold(
      endDrawer: buildDrawer(context),
      key: _scaffoldKey,
      body: PageView(
        controller: pageController,
        onPageChanged: (index) {
          navBarProvider.setSelectedIndex(index);
        },
        children: <Widget>[
          Home(),
          AqwalWaIrshadaatScreen(isNavBar: true),
          Majlis(isNavBar: true),
          ShajrEQadriaScreen(text: 'hasbiya', isNavBar: true),
        ],
      ),
      bottomNavigationBar: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 80,
            padding: EdgeInsets.only(left: 10, right: 10, top: 10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(-1, -2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildNavItem(0, "assets/new_images/home.png", "هوم"),
                buildNavItem(1, "assets/new_images/box.png", "اقوال و ارشاداتِ"),
                const SizedBox(width: 30), // Spacer for the central button
                buildNavItem(3, "assets/new_images/page.png", "شجرۂ قادریہ"),
                buildNavItem(4, "assets/new_images/menu.png", "مضامین"),
              ],
            ),
          ),
          Positioned(
            bottom: 5, 
            child: GestureDetector(
              onTap: () {
                navBarProvider.setSelectedIndex(2);
                pageController.jumpToPage(2);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      width: 75,
                      height: 75,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(18),
                        width: 60,
                        height: 60,
                        decoration: const BoxDecoration(
                          color: Color(0xFF345EF1),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            )
                          ],
                        ),
                        child: Image.asset(
                          "assets/new_images/dash.png",
                          color: navBarProvider.selectedIndex == 2
                              ? Colors.white
                              : Colors.white, // Highlight selected
                        ),
                      ),
                    ),
                    SizedBox(height: 0),
                    SizedBox(
                      width: 60,
                      child: Text(
                        textAlign: TextAlign.center,
                        "فهرست مجالس",
                        style: GoogleFonts.almarai(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          color: Color(0xFFBEBEC0),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
     
    );
  }

  // Helper method to build each navigation item with animation
  Widget buildNavItem(int index, String assetPath, String text) {
  final navBarProvider = Provider.of<HomeNavBarProvider>(context);

  return GestureDetector(
    onTap: () {
      if (index == 4) {
        _scaffoldKey.currentState?.openEndDrawer();
        return;
      } else {
        navBarProvider.setSelectedIndex(index);
        pageController.jumpToPage(index); 
      }
    },
    child: Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.all(10),
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
          ),
          child: Image.asset(
            assetPath,
            width: 25,
            color: navBarProvider.selectedIndex == index
                ? Color(0xFF345EF1)
                : Colors.grey, // Highlight selected
          ),
        ),
        Text(
          text,
          style: GoogleFonts.almarai(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: navBarProvider.selectedIndex == index
                ? Color(0xFF345EF1)
                : Color(0xFFBEBEC0),
          ),
        ),
      ],
    ),
  );
}

}


  Widget buildDrawer(BuildContext context) {
    return Padding(

      padding: const EdgeInsets.only(top:40.0, bottom:10),
      child: Drawer(
        width: 270,
        backgroundColor: Color(0xFF2F49D1),
        child: Padding(
          padding: const EdgeInsets.only(top:40.0, right:20, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children:  <Widget>[
                  Text(
                    'قلبِ سلیم',
                    style: GoogleFonts.almarai(
                                      fontSize: 25,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                  ),
                  SizedBox(height: 40,),
                  drawerItems("فهرست مجالس", (){
                    Navigator.push(
                              context,
                              CustomPageNavigation(
                                child: Majlis(isNavBar: false,),
                              ),
                            );
                  }),
              
                  drawerItems("پیش لفظ",(){
                    Navigator.push(context, CustomPageNavigation(child: SoundPlayer(image: 'assets/images/paish_lafz-dark.png', name: "پیش لفظ", sub: 'عبد الحمید قادری عفی عنہ')));
              
                  }),
                 
                  drawerItems("مقدمہ الکتاب",(){
                    Navigator.push(context, CustomPageNavigation(child: SoundPlayer(image: 'assets/images/muqadma-dark.png', name: "مقدمہ الکتاب", sub: 'حضرت ابو الحقائق پیر سّید امانت علی شاہ چشتی نظامی')));
              
                  }),
              
                  drawerItems("اظہار تشکر",(){
                    Navigator.push(context, CustomPageNavigation(child: SoundPlayer(image: 'assets/images/tashakur.png', name: "اظہار تشکر", sub: 'سید محمد فراز شاہ عفی عنہ')));
              
                  }),
              
                  drawerItems("منقبت",(){
                    Navigator.push(context, CustomPageNavigation(child: SoundPlayer(image: 'assets/images/manqabat-dark.png', name: "منقبت", sub: "حضرت سّید محمد ظفر مشہدی قادری رحمة الله تعالى عليه")));
              
                  }),
                     
                  drawerItems("سوانح حیات",(){
                    Navigator.push(context, CustomPageNavigation(child: SoundPlayer(image: 'assets/images/sawane-dark.png', name: "سوانح حیات", sub: "حضرت سّید محمد ظفر قادری قادری رحمة الله تعالى عليه")));
              
                  }),
              
                  drawerItems("قلب سلیم",(){
                    Navigator.push(context, CustomPageNavigation(child: SoundPlayer(image: 'assets/images/qalb_e_saleem-dark.png', name: "قلب سلیم", sub: 'سّید محمد فراز شاہ مشہدی قادری عفی عنہ')));
              
                  }),
                  drawerItems("اقوال و ارشاداتِ عالیہ",(){
                    Navigator.push(context, CustomPageNavigation(child: AqwalWaIrshadaatScreen(isNavBar: false)));
              
                  }),
                  drawerItems("شجرۂ قادریہ حسبیہ",(){
                    Navigator.push(context, CustomPageNavigation(child: ShajrEQadriaScreen(text: "hasbiya",isNavBar: false)));
              
                  }),
                  drawerItems("شجرۂ قادریہ نسبیہ",(){
                    Navigator.push(context, CustomPageNavigation(child: ShajrEQadriaScreen(text: "nasbiya",isNavBar: false)));
              
                  }),
                  drawerItems("شجرۂ حسبیہ منظوم مع تضمین",(){
                    Navigator.push(context, CustomPageNavigation(child: SoundPlayer(
                                    image: "assets/images/shajra_hasbia.png",
                                    name: "شجرٔہ قادریہ حسبیہ",
                                    sub: "منظوم مع تضمین",
                                  )));
              
                  }),
                  drawerItems("شجرۂ نسبیہ منظوم مع تضمین",(){
                    Navigator.push(context, CustomPageNavigation(child: SoundPlayer(
                                        image: "assets/images/shajra_nasbia.png",
                                        name: "شجرٔہ قادریہ نسبیہ",
                                        sub: "منظوم مع تضمین",
                                      ),));
              
                  }),
              
                  drawerItems("الفراق",(){
                    Navigator.push(context, CustomPageNavigation(child: SoundPlayer(image: 'assets/images/alfiraq-dark.png', name: 'الفراق', sub: "'حضرت سّید محمد ظفر مشہدی قادری رحمة الله تعالى عليه'")));
              
                  }), 
                  drawerItems("قطعہ تاریخ وصال",(){
                    Navigator.push(context, CustomPageNavigation(child: SoundPlayer(image: "assets/images/qata-dark.png", name: "قطعہ تاریخ وصال", sub: 'حضرت ابو الحقائق پیر سّید امانت علی شاہ چشتی نظامی')));
              
                  }),
                     
                  drawerItems("منقبت",(){
                    Navigator.push(context, CustomPageNavigation(child: SoundPlayer(image: "assets/images/manqabat2-dark.png", name: "منقبت", sub: 'عبد الحمید قادری عفی عنہ')));
              
                  }),
                  drawerItems("حواشی و حوالہ جات",(){
                    Navigator.push(context, CustomPageNavigation(child: hawashiwahawalajatScreen()));
              
                  }),
              SizedBox(height: 0,),
                  
              
              
                  
                 
                ],
              ),
              Padding(
                    
                    padding: const EdgeInsets.only(left:20.0, right: 10),
                    child: Divider(
                      color: Colors.white54,
                      thickness: 2,
                    ),
                  ),
                  SizedBox(height:5),
              Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                    
                        Container( width: 35,padding: EdgeInsets.all(8), height: 35, decoration: BoxDecoration(borderRadius: BorderRadiusDirectional.circular(10),color: Color(0xFF00FFFF)),child:  Image.asset("assets/new_images/fb.png",color: Color(0xFF2F49D1),),),
                        SizedBox(width: 5),
                        Container( width: 35,padding: EdgeInsets.all(8), height: 35, decoration: BoxDecoration(borderRadius: BorderRadiusDirectional.circular(10),color: Color(0xFF00FFFF),),child:  Image.asset("assets/new_images/insta.png",color: Color(0xFF2F49D1),),),
                        SizedBox(width: 5),
                        Container( width: 35,padding: EdgeInsets.all(8), height: 35, decoration: BoxDecoration(borderRadius: BorderRadiusDirectional.circular(10),color: Color(0xFF00FFFF)),child: Image.asset("assets/new_images/world.png",color: Color(0xFF2F49D1),),),
                        SizedBox(width: 5),
                        GestureDetector(
                          onTap: (){
                                Share.share('Download Qalb-E-Saleem App: https://play.google.com/store/apps/details?id=com.hizburehman.qalb_e_saleem&hl=en');
                          },
                          child: Container( width: 35,padding: EdgeInsets.all(8), height: 35, decoration: BoxDecoration(borderRadius: BorderRadiusDirectional.circular(10),color: Color(0xFF00FFFF), ),child:  Image.asset("assets/new_images/share.png",color: Color(0xFF2F49D1),),)),
                      ],
                    ),),
              
            ],
          ),
        ),
      ),
    );
  }


Widget drawerItems(String text, GestureTapCallback onTap){
  return Padding(
    padding: const EdgeInsets.only(bottom:15.0),
    child: GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children:[
           Text(text,
                                  style: GoogleFonts.almarai(
                                    fontSize: 12,
                                    color: Color(0xFF00FFFF),
                                    fontWeight: FontWeight.bold,
      
                                  ),),
                                  SizedBox(width:10),
                                  Padding(
                                    padding: const EdgeInsets.only(top:2.0),
                                    child: Icon(Icons.arrow_back_ios, color: Color(0xFF00FFFF),size: 13,),
                                  )
        ]
      ),
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
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.black, // Set the status bar color to black
        statusBarIconBrightness:
            Brightness.light, // Set the icon brightness to light (white icons)
      ),
    );
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
                            child: Majlis(isNavBar: false,),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.32,
                        margin: EdgeInsets.only(top: 30),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadiusDirectional.circular(20),
                          image: DecorationImage(
                            image: AssetImage("assets/images/darbar.png"),
                            fit: BoxFit
                                .cover, // Ensures the image covers the entire container
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            Text(
                              "فهرست مجالس",
                              style: GoogleFonts.almarai(
                                fontSize: 18,
                                color: Color(0xFF02DBC6),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              textAlign: TextAlign.center,
                              "امام االولیاء حضرت پیر سّید محّمد عبد اللہ شاہ مشہدی قادری",
                              style: GoogleFonts.almarai(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "رحمة الله تعالى عليه",
                              style: GoogleFonts.almarai(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height:20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SmallContainer(
                          backgroundColor: Color(0xFF10A8E3),
                          imagePath: 'assets/images/manqabat-dark.png',
                          text: 'منقبت',
                          sub:
                              "حضرت سّید محمد ظفر مشہدی قادری رحمة الله تعالى عليه",
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
                          sub:
                              'حضرت ابو الحقائق پیر سّید امانت علی شاہ چشتی نظامی',
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
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [
                          LongBox(
                            audioPath: '',
                            imagePath: 'assets/images/sawana-white.png',
                            mainText: "سوانح حیات",
                            subText1: "از رشحاِت قلم:",
                            subText2:
                                " حضرت سّید محمد ظفر قادری قادری رحمة الله تعالى عليه",
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
                              subText2: 'مشہدی قادری رحمة اهلل تعالى عليه',
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
                            image: AssetImage("assets/new_images/video.png"),
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
                                child: ShajrEQadriaScreen(text: "nasbiya",isNavBar:false),
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
                                child: ShajrEQadriaScreen(text: "hasbiya",isNavBar:false),
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
                                child: ShajrEQadriaScreen(text: "nasbiya",isNavBar:false),
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
                                    child: ShajrEQadriaScreen(text: "hasbiya",isNavBar:false)),
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
                                    image: "assets/images/shajra_nasbia.png",
                                    name: "شجرٔہ قادریہ نسبیہ",
                                    sub: "منظوم مع تضمین",
                                  ),
                                ),
                              );
                            },
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
                              )),
                            );
                          },
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
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:10.0),
                child: LongBox(
                        imagePath: 'assets/images/alfiraq-white.png',
                        mainText: 'الفراق',
                        subText1: 'از رشحاِت قلم',
                        subText2:
                            'حضرت سّید محمد ظفر مشہدی قادری رحمة الله تعالى عليه ',
                        backgroundColor: Color(0xFF281E63),
                        audioPath: '',
                      ),
              ),
              SizedBox(height:12),
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
                          borderRadius: BorderRadiusDirectional.circular(15),
                          color: Color(0xFF00A79D), // Adjust opacity as needed
                        ),

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
                              ),
                            ),
                          );
                        },
                        child: Stack(
                          children: [
                            // Flipping the background image horizontally
                            Container(
                              height: 60,
                              width: MediaQuery.of(context).size.width * 0.46,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadiusDirectional.circular(15),
                                color: Color(0xFF1373BF),
                              ),
                            ),
                            // Text remains unaffected by the flip
                            Container(
                              height: 60,
                              width: MediaQuery.of(context).size.width * 0.46,
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
                        ))
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
                    Container(
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
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "© 2021",
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
                  GestureDetector(
                    onTap: (){
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
}