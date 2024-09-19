import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
// import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qalb/Transition/CustomPageTransition.dart';
import 'package:qalb/data/data.dart';
import 'package:qalb/providers/DataProvider.dart';
import 'package:qalb/providers/SoundPlayerProvider.dart';
import 'package:qalb/screens/majlis_screens/majlis_sound.dart';

class Majlis extends StatefulWidget {
  final bool isNavBar;
  Majlis({super.key, required this.isNavBar});

  @override
  State<Majlis> createState() => _MajlisState();
}

class _MajlisState extends State<Majlis> with SingleTickerProviderStateMixin {
  late final ScrollController _scrollController;
  late final AnimationController _animationController;
  late final Animation<double> _animation;
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  final PageController _carousel = PageController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..forward();
    _animation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.26,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/upergrad.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.05,
                      vertical: MediaQuery.of(context).size.height * 0.03,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "فهرست مجالس",
                              style: GoogleFonts.almarai(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "امام االولیاء حضرت پیر سّید محّمد عبد اللہ شاہ مشہدی قادری",
                              style: GoogleFonts.almarai(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.025,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 15),
                        Visibility(
                          visible: widget.isNavBar ? false : true,
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Image.asset(
                              "assets/images/back-arrow-white.png",
                              width: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.21, // Adjust as needed
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 0),
              padding: EdgeInsets.symmetric(vertical: 50),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height *
                      0.5, // Adjust to your needs
                  aspectRatio: 1,
                  initialPage: 0,
                  viewportFraction: 0.7,
                  enableInfiniteScroll: false,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.vertical,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                    // Stop audio when page changes
                  },
                ),
                carouselController: _carouselController,
                items: Provider.of<DataProvider>(context)
                    .majlisImages
                    .asMap()
                    .entries
                    .map((entry) {
                  int index = entry.key;
                  String imageUrl = entry.value;

                  return Builder(
                    builder: (BuildContext context) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            CustomPageNavigation(
                              child: Majlis_Sound(
                                image: Provider.of<DataProvider>(context,
                                        listen: false)
                                    .majlisThumb[index],
                                index: index,
                                name: TextData.majlisUrdu[index],
                                sub: TextData.majlisEnglish[index],
                                audioPath: Provider.of<DataProvider>(context,
                                        listen: false)
                                    .majlisSound[index],
                              ),
                            ),
                          );
                        },
                        child: majlisContainer(imageUrl, index),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget majlisContainer(String image, int index) {
    bool isSelected = _currentIndex == index;

    return AnimatedContainer(
      margin: EdgeInsets.symmetric(horizontal: 10),
      duration: Duration(milliseconds: 300),
      padding:
          EdgeInsets.only(left: isSelected ? 10 : 5,right: isSelected ? 10 : 5, top: isSelected ? 0 : 0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(1, 2),
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    "assets/images/clock-white.png",
                    color: Colors.black,
                    height: 12,
                  ),
                  SizedBox(width: 5),
                  Text(
                    formatDuration(getDuration(index + 1)),
                    style: GoogleFonts.almarai(fontSize: 12),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                  Container(
                    padding: const EdgeInsets.all(5),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      "${index + 1}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "مجلس",
                    style: GoogleFonts.almarai(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
       
          AnimatedContainer(
            curve: Curves.easeInOut,
            duration: const Duration(milliseconds: 300),
            height: isSelected ? 190 : 130,
            child: Platform.isIOS
                ? Image.network(
                    image,
                    fit: BoxFit.fill,
                  )
                : CachedNetworkImage(
                    imageUrl: image,
                    fit: BoxFit.fill,
                    placeholder: (context, url) => Container(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
          ),
    
          AnimatedOpacity(
            opacity: isSelected ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 800),
            child: 
                Column(
               
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      overflow: TextOverflow.clip,
                      TextData.majlisUrdu[index],
                      style: GoogleFonts.almarai(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.ltr,
                      overflow: TextOverflow.clip,
                      TextData.majlisEnglish[index],
                      style: GoogleFonts.almarai(
                        fontSize: 13,
                        color: Colors.grey[600]
                      ),
                    ),
                  ],
                ),
                
            
          ),
        ],
      ),
    );
  }

  int getDuration(int index) {
    final duration = {
      1: 853,
      2: 1046,
      3: 789,
      4: 1229,
      5: 1848,
      6: 1828,
      7: 856,
      8: 1029,
      9: 646,
      10: 968,
      11: 1240,
      12: 827,
      13: 1631,
      14: 932,
      15: 2331,
      16: 1296,
      17: 1608,
      18: 764,
      19: 782,
      20: 1975,
    };
    return duration[index] ?? 0;
  }

  String formatDuration(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$remainingSeconds';
  }

  Future<String?> getAudioDuration(String url) async {
    final player = AudioPlayer();
    try {
      await player.setSourceUrl(url);
      Duration? d = await player.getDuration();
      return Provider.of<SoundPlayerProvider>(context, listen: false)
          .formatDuration(d!);
    } catch (e) {
      print('Error loading audio: $e');
      return null;
    } finally {
      await player.dispose();
    }
  }
}
