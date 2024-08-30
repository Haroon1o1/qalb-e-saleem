import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qalb/Transition/CustomPageTransition.dart';
import 'package:qalb/screens/HomeScreen/LongBox.dart';
import 'package:qalb/screens/HomeScreen/smallContainer.dart';
import 'package:qalb/screens/Shajr_e_Qadria/Shajr_e_Qadria.dart';
import 'package:qalb/screens/aqwal_wa_irshadaat/aqwal_wa_irshadaat.dart';
import 'package:qalb/screens/hawashi_wa_hawalajat.dart';
import 'package:qalb/screens/majlis_screen.dart';
import 'package:qalb/screens/sound_screen.dart/sound_player.dart';
import 'package:qalb/screens/videoPlayer.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  _BottomNavBarScreenState createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0; // Start with the middle icon selected
  late AnimationController _controller;
  late AnimationController _prevController;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      value: 1.0, // The selected icon starts in the popped state
    );

    _prevController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  void _onItemTapped(int index) {
    if (index == 4) {
      // Open drawer when the last item is clicked
      _scaffoldKey.currentState?.openEndDrawer();
      return;
    }

    if (index == _selectedIndex) {
      return; // Do nothing if the selected icon is tapped again
    }

    setState(() {
      _prevController = _controller;
      _selectedIndex = index;

      // Animate the previous icon to its normal state
      _prevController.reverse();

      // Animate the new selected icon to its popped-up state
      _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
      );
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Assign the scaffold key
      body: Center(
        child: _buildContent(_selectedIndex), // Display the corresponding screen content
      ),
      bottomNavigationBar: Container(
        decoration:  BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(10),
                boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.2), offset: Offset(-1,-2),
                blurRadius: 5,
                spreadRadius: 0.0000001
                )
              ]),
              child: BottomNavigationBar(
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: _buildIcon('assets/new_images/home.png', 0),
                    label: "هوم",
                  ),
                  BottomNavigationBarItem(
                    icon: _buildIcon('assets/new_images/box.png', 1),
                    label: "اقوال و ارشاداتِ",
                  ),
                  BottomNavigationBarItem(
                    activeIcon: _buildIcon('assets/new_images/dash.png', 2),
                    icon: _buildIcon('assets/new_images/dash.png', 2),
                    label: "فهرست مجالس",
                  ),
                  BottomNavigationBarItem(
                    icon: _buildIcon('assets/new_images/page.png', 3),
                    label: "شجرۂ قادریہ",
                  ),
                  BottomNavigationBarItem(
                    icon: _buildIcon('assets/new_images/menu.png', 4),
                    label: "مضامین",
                  ),
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: Colors.blue,
                unselectedItemColor: Colors.grey,
                onTap: _onItemTapped,
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.white,
                elevation: 0,
              ),
            ),
          ],
        ),
      ),
      endDrawer: _buildDrawer(), // Add the drawer
    );
  }

  Widget _buildIcon(String iconURL, int index) {
    bool isSelected = _selectedIndex == index;

    return AnimatedBuilder(
      animation: isSelected ? _controller : _prevController,
      builder: (context, child) {
        return Transform.translate(
          offset: isSelected ? const Offset(0, -15) : Offset.zero,
          child: Transform.scale(
            scale: isSelected ? _controller.value + 0.6 : 1.0,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: isSelected
                  ? const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    )
                  : null,
              child: Image.asset(
                iconURL,
                color: isSelected ? Colors.white : Colors.grey,
                width: 15,
                height: 15,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildContent(int index) {
    // Return the content widget for the selected tab.
    switch (index) {
      case 0:
        return const Home();
      case 1:
        return const Center(child: Text('Quotes Screen'));
      case 2:
        return const Center(child: Text('Menu Screen'));
      case 3:
        return const Center(child: Text('Profile Screen'));
      case 4:
        return const Center(child: Text('More Screen'));
      default:
        return const Center(child: Text('Home Screen'));
    }
  }

  Widget _buildDrawer() {
    return Padding(

      padding: const EdgeInsets.only(top:40.0, bottom:10),
      child: Drawer(
        width: 240,
        backgroundColor: Color(0xFF2F49D1),
        child: Padding(
          padding: const EdgeInsets.only(top:40.0, right:20),
          child: Column(
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
                            child: Majlis(),
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
                Navigator.push(context, CustomPageNavigation(child: AqwalWaIrshadaatScreen()));

              }),
              drawerItems("شجرۂ قادریہ حسبیہ",(){
                Navigator.push(context, CustomPageNavigation(child: ShajrEQadriaScreen(text: "hasbiya")));

              }),
              drawerItems("شجرۂ قادریہ نسبیہ",(){
                Navigator.push(context, CustomPageNavigation(child: ShajrEQadriaScreen(text: "nasbiya")));

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
              Padding(
                
                padding: const EdgeInsets.only(left:20.0, right: 10),
                child: Divider(
                  color: Colors.white54,
                  thickness: 2,
                ),
              ),

              SizedBox(height: 5),

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
                    Container( width: 35,padding: EdgeInsets.all(8), height: 35, decoration: BoxDecoration(borderRadius: BorderRadiusDirectional.circular(10),color: Color(0xFF00FFFF), ),child:  Image.asset("assets/new_images/share.png",color: Color(0xFF2F49D1),),),
                  ],
                ),
              )
             
            ],
          ),
        ),
      ),
    );
  }
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
                            child: Majlis(),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.32,
                        margin: EdgeInsets.symmetric(vertical: 30),
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
                                fontSize: 22,
                                color: Color(0xFF02DBC6),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              textAlign: TextAlign.center,
                              "امام االولیاء حضرت پیر سّید محّمد عبد اهلل شاہ مشہدی قادری",
                              style: GoogleFonts.almarai(
                                  fontSize: 9,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "رحمة الله تعالى عليه",
                              style: GoogleFonts.almarai(
                                fontSize: 9,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      height: 20,
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
                              subText2: ' مشہدی قادری رحمة اهلل تعالى عليه  ',
                              backgroundColor: Color(0xFF2B3491)),
                        ],
                      ),
                    ),
                    LongBox(
                      imagePath: 'assets/images/alfiraq-white.png',
                      mainText: 'الفراق',
                      subText1: 'از رشحاِت قلم',
                      subText2:
                          'حضرت سّید محمد ظفر مشہدی قادری رحمة الله تعالى عليه ',
                      backgroundColor: Color(0xFF281E63),
                      audioPath: '',
                    ),
                    SizedBox(height: 20),
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
                height: 20,
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
                                child: ShajrEQadriaScreen(text: "nasbiya"),
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
                                    child: ShajrEQadriaScreen(text: "hasbiya")),
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
              SizedBox(height: 10),
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
              SizedBox(height: 10),
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
                      "حضرت پیر سید محمد عبداهلل شاہ مشہدی قادری",
                      style: GoogleFonts.almarai(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 69, 221, 255),
                      ),
                    ),
                    Text(
                      textDirection: TextDirection.rtl,
                      "رحمة اهلل تعالى عليه",
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
                  Image.asset(
                    "assets/images/gototop.png",
                    width: 40,
                  ),
                  SizedBox(width: 10),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}