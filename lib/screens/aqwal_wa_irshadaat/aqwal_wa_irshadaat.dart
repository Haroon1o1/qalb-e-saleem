import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qalb/data/links.dart';
import 'package:qalb/providers/DataProvider.dart';
import 'package:qalb/screens/aqwal_wa_irshadaat/widgets/upperPart.dart';
import 'package:qalb/providers/SoundPlayerProvider.dart'; // Import SoundPlayerProvider
import 'package:carousel_slider/carousel_slider.dart'; // Import CarouselSlider

// ignore: must_be_immutable
class AqwalWaIrshadaatScreen extends StatefulWidget {
  bool isNavBar;
  AqwalWaIrshadaatScreen({super.key, required this.isNavBar});

  @override
  State<AqwalWaIrshadaatScreen> createState() => _AqwalWaIrshadaatScreenState();
}

class _AqwalWaIrshadaatScreenState extends State<AqwalWaIrshadaatScreen> {
  final CarouselSliderController _carouselController = CarouselSliderController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // Stop audio when page changes
   
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _toggleAudio() {
    final akwalAudioUrls =Links.akwalAudio;
    
    if (_currentIndex < 0 || _currentIndex >= akwalAudioUrls.length) {
      log("Invalid index: $_currentIndex");
      return;
    }

    final audioUrl = akwalAudioUrls[_currentIndex];
    Provider.of<SoundPlayerProvider>(context, listen: false).togglePlayStop(audioUrl);
  }

  @override
  Widget build(BuildContext context) {
    final akwalImageUrls = Links.akwalImages;
    final soundProvider = Provider.of<SoundPlayerProvider>(context); 
    
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          UpperPart(isNavbar: widget.isNavBar,mainText: "اقوال و ارشاداِت عالیہ",subText: "امام االولیاء حضرت پیر سّید محّمد عبد اللہ شاہ مشہدی قادری",),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.21,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              height: MediaQuery.of(context).size.height * 0.8,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: widget.isNavBar ? 10 : 30),
                  CarouselSlider(
  options: CarouselOptions(
    height: MediaQuery.of(context).size.height * 0.5,
    aspectRatio: 16 / 9,
    enableInfiniteScroll: false,
    viewportFraction: 0.75,
    enlargeCenterPage: true,
    initialPage: 0,
    reverse: true,
    pageSnapping: true,
    onPageChanged: (index, reason) {
      setState(() {
        _currentIndex = index;
      });
      // Stop audio when page changes
      soundProvider.stopAudio();
    },
  ),
  carouselController: _carouselController,
  items: akwalImageUrls.asMap().entries.map((entry) {
    String imageUrl = entry.value;
    
    return Builder(
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            // Handle image tap
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 250),
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.bottomCenter,
                    margin: const EdgeInsets.only(top: 10),
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Platform.isIOS
                        ? AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            child: Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width * 0.7,
                            ),
                          )
                        : CachedNetworkImage(
                            imageUrl: imageUrl,
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width * 0.7,
                            placeholder: (context, url) => Container(),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }).toList(),
),

                  const SizedBox(height: 0),
                  // SizedBox(
                  //   width: MediaQuery.of(context).size.width*0.9,
                  //   child: Transform(
                  //     alignment: Alignment.center,
                  //     transform: Matrix4.rotationY(3.14), // Flip horizontally
                  //     child: Container(
                  //       alignment: Alignment.center,
                  //       width: MediaQuery.of(context).size.width * 0.8,
                  //       child: SmoothPageIndicator(
                  //         controller: _carousel,
                  //         count: akwalImageUrls.length,
                  //         effect: WormEffect(
                  //           spacing: 3.0, // Adjust spacing between dots
                  //           dotHeight: 4.0, // Adjust dot height
                  //           dotWidth: 4.0, // Adjust dot width
                  //           dotColor: Colors.grey.shade300,
                  //           activeDotColor: Colors.grey,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 0),
                  InkWell(
                    onTap: _toggleAudio,
                    child: Image.asset(
                      soundProvider.isPlaying
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
}
