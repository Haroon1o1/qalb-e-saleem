import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qalb/providers/DataProvider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:audioplayers/audioplayers.dart';

class AqwalWaIrshadaatScreen extends StatefulWidget {
  const AqwalWaIrshadaatScreen({super.key});

  @override
  State<AqwalWaIrshadaatScreen> createState() => _AqwalWaIrshadaatScreenState();
}

class _AqwalWaIrshadaatScreenState extends State<AqwalWaIrshadaatScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.8);
  final AudioPlayer _audioPlayer = AudioPlayer();
  int _currentIndex = 0;

  bool _isPlaying = false;
void _toggleAudio() {
  final akwalProvider = Provider.of<DataProvider>(context, listen: false);
  final akwalAudioUrls = akwalProvider.akwalAudio;

  // Check if the index is valid
  if (_currentIndex < 0 || _currentIndex >= akwalAudioUrls.length) {
    log("Invalid index: $_currentIndex");
    return;
  }

  if (_isPlaying) {
    _audioPlayer.stop();
  } else {
    // Ensure the index is within bounds
    if (akwalAudioUrls.isNotEmpty && _currentIndex < akwalAudioUrls.length) {
      final url = akwalAudioUrls[_currentIndex];
      log("Playing audio from URL: $url");
      _audioPlayer.play(UrlSource(url));
    } else {
      log("No audio URL found for index $_currentIndex");
    }
  }

  setState(() {
    _isPlaying = !_isPlaying;
  });
}


@override
void initState() {
  super.initState();
  _pageController.addListener(() {
    setState(() {
      _currentIndex = _pageController.page!.round();
    });
  });

  _audioPlayer.onPlayerComplete.listen((_) {
    setState(() {
      _isPlaying = false;
    });
  });

  _audioPlayer.onPlayerStateChanged.listen((state) {
  });
}

@override
   void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }


 build(BuildContext context) {
    final akwalImageUrls = Provider.of<DataProvider>(context, listen: false).akwalImageUrls;
        
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
                    padding: const EdgeInsets.only(bottom: 0.0, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const SizedBox(height: 10),
                            Text(
                              "اقوال و ارشاداِت عالیہ",
                              style: GoogleFonts.almarai(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "امام االولیاء حضرت پیر سّید محّمد عبد اهلل شاہ مشہدی قادری",
                              style: GoogleFonts.almarai(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Image.asset(
                                  "assets/images/back-arrow-white.png",
                                  width: 25),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.21,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical:10),
              height: MediaQuery.of(context).size.height * 0.8,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: PageView.builder(
                      onPageChanged: (value){
                        setState(() {
                          _isPlaying = false;
                        });
                      },
                      reverse: true,
                      controller: _pageController,
                      itemCount: akwalImageUrls.length,
                      itemBuilder: (context, index) {
                        final imageUrl = akwalImageUrls[index];
                        print('PageView index: $index, Image URL: $imageUrl');
                        return _buildPage(imageUrl);
                      },
                    ),
                  ),
                  SizedBox(height: 0),
                  Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(3.14), // Flip horizontally
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: SmoothPageIndicator(
                    controller: _pageController,
                    count: akwalImageUrls.length-35,
                    effect: WormEffect(
                      spacing: 3.0, // Adjust spacing between dots
                      dotHeight: 4.0, // Adjust dot height
                      dotWidth: 4.0, // Adjust dot width
                      dotColor: Colors.grey.shade300,
                      activeDotColor: Colors.grey,
                    ),
                  ),
                ),
              ),
                  SizedBox(height: 20),
                  InkWell(
                    onTap: _toggleAudio,
                    child: Image.asset(
                      _isPlaying
                          ? "assets/new_images/mute-audio.png"
                          : "assets/new_images/play-audio.png",
                      height: 60,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: CachedNetworkImage(
        imageUrl: imagePath,
        placeholder: (context, url) => Container(),
        errorWidget: (context, url, error) => Icon(Icons.error),
        fit: BoxFit.fill,
      ),
    );
  }
}
