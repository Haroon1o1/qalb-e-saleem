import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qalb/providers/DataProvider.dart';
import 'package:qalb/screens/aqwal_wa_irshadaat/widgets/imageBuilderWidget.dart';
import 'package:qalb/screens/aqwal_wa_irshadaat/widgets/upperPart.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:qalb/providers/SoundPlayerProvider.dart'; // Import SoundPlayerProvider

class AqwalWaIrshadaatScreen extends StatefulWidget {
  const AqwalWaIrshadaatScreen({super.key});

  @override
  State<AqwalWaIrshadaatScreen> createState() => _AqwalWaIrshadaatScreenState();
}

class _AqwalWaIrshadaatScreenState extends State<AqwalWaIrshadaatScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.8);
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentIndex = _pageController.page!.round();
      });
      // Stop audio when page changes
      Provider.of<SoundPlayerProvider>(context, listen: false).stopAudio();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _toggleAudio() {
    final akwalProvider = Provider.of<DataProvider>(context, listen: false);
    final akwalAudioUrls = akwalProvider.akwalAudio;
    
    if (_currentIndex < 0 || _currentIndex >= akwalAudioUrls.length) {
      log("Invalid index: $_currentIndex");
      return;
    }

    final audioUrl = akwalAudioUrls[_currentIndex];
    Provider.of<SoundPlayerProvider>(context, listen: false).togglePlayStop(audioUrl);
  }

  @override
  Widget build(BuildContext context) {
    final akwalImageUrls = Provider.of<DataProvider>(context, listen: false).akwalImageUrls;
    final soundProvider = Provider.of<SoundPlayerProvider>(context); // Access SoundPlayerProvider
    
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          UpperPart(),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.21,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
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
                      onPageChanged: (value) {
                        setState(() {
                          // Reset audio state when page changes
                          soundProvider.stopAudio();
                        });
                      },
                      reverse: true,
                      controller: _pageController,
                      itemCount: akwalImageUrls.length,
                      itemBuilder: (context, index) {
                        final imageUrl = akwalImageUrls[index];
                        print('PageView index: $index, Image URL: $imageUrl');
                        return ImageBuilder(imagePath: imageUrl);
                      },
                    ),
                  ),
                  const SizedBox(height: 0),
                  Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(3.14), // Flip horizontally
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: SmoothPageIndicator(
                        controller: _pageController,
                        count: akwalImageUrls.length - 35,
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
                  const SizedBox(height: 20),
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
