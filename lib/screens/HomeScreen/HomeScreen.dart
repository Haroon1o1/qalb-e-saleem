
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qalb/Transition/CustomPageTransition.dart';
import 'package:qalb/screens/HomeScreen/widgets/LongBox.dart';
import 'package:qalb/screens/HomeScreen/widgets/footer.dart';
import 'package:qalb/screens/HomeScreen/widgets/longContainerRow.dart';
import 'package:qalb/screens/HomeScreen/widgets/shajra.dart';
import 'package:qalb/screens/HomeScreen/widgets/smallContainerRow.dart';
import 'package:qalb/screens/HomeScreen/widgets/socialMediaLinks.dart';
import 'package:qalb/screens/HomeScreen/widgets/uperContainer.dart';
import 'package:qalb/screens/hawashi_wa_hawalajat/hawalajat.dart';
import 'package:qalb/screens/majlis_screens/majlis_screen.dart';
import 'package:qalb/screens/sound_screen.dart/sound_player.dart';
import 'package:qalb/utils/videoPlayer.dart';
import 'package:video_player/video_player.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ScrollController _scrollController = ScrollController();
  late VideoPlayerController _controller;
  @override
  void initState() {
     _controller = VideoPlayerController.networkUrl(Uri.parse('https://firebasestorage.googleapis.com/v0/b/qalb-e-saleem-c7987.appspot.com/o/doc-loop.mp4?alt=media&token=a651dfe8-ce75-4fdf-b952-2aac220a861d'), // Replace with your video URL or file path
    )
      ..initialize().then((_) {
        setState(() {});
      })
      ..setLooping(true)  
      ..play();     
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
    statusBarColor: Colors.white, // Make status bar transparent
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
                    SmallContainerRow(),
                    SizedBox(
                      height: 5,
                    ),
                    LongContainerRow(),
                    SizedBox(height: 15),
                   Container(
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          alignment: Alignment.bottomRight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(40),
            ),
            color: Colors.white,
          ),
          height: MediaQuery.of(context).size.height*0.28,
          width: MediaQuery.of(context).size.width * 1,
          child: Stack(
  children: [
    ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
        bottomLeft: Radius.circular(15),
        bottomRight: Radius.circular(40),
      ),
      child: Container(
        // aspectRatio: 16/9,
        width: MediaQuery.of(context).size.width * 1,
        child: VideoPlayer(_controller),
      ),
    ),

    // Text and Play button overlay
    Positioned(
      bottom: 10,
      right: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "صدائے عبد اللہ دستاویزی فلم",
            style: GoogleFonts.almarai(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Colors.white,
            ),
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
              icon: Icon(Icons.play_arrow, color: Colors.white, size: 35),
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
  ],
),

        ),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
            Shajra(),
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
                      child: HawalajatPdf(),
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
              FooterContainer(),
              SizedBox(height: 20),
              SocialMediaRow(scrollController: _scrollController),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

 

 

 
}
