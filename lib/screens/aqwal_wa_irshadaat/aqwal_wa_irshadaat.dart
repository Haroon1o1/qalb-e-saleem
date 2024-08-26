import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qalb/providers/DataProvider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AqwalWaIrshadaatScreen extends StatefulWidget {
  const AqwalWaIrshadaatScreen({super.key});

  @override
  State<AqwalWaIrshadaatScreen> createState() => _AqwalWaIrshadaatScreenState();
}

class _AqwalWaIrshadaatScreenState extends State<AqwalWaIrshadaatScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.8);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              padding: const EdgeInsets.symmetric(vertical: 20),
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
                      controller: _pageController,
                      itemCount: akwalImageUrls.length,
                      itemBuilder: (context, index) {
                        final imageUrl = akwalImageUrls[index];
                        print('PageView index: $index, Image URL: $imageUrl');
                        return _buildPage(imageUrl);
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: akwalImageUrls.length,
                    effect: WormEffect(
                      dotHeight: 4,
                      dotWidth: 4,
                      activeDotColor: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 30),
                  InkWell(
                    // Uncomment and modify the following code to handle audio playback
                    // onTap: () {
                    //   if (Provider.of<DataProvider>(context, listen: false)
                    //       .akwalAudio
                    //       .isNotEmpty) {
                    //     _audioPlayer.play(UrlSource(
                    //         Provider.of<DataProvider>(context, listen: false)
                    //             .akwalAudio[0]));
                    //   } else {
                    //     _audioPlayer
                    //         .play(DeviceFileSource('Audios/al firaaq.mp3'));
                    //   }
                    // },
                    child: Image.asset(
                      "assets/images/play.png",
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
      padding: const EdgeInsets.all(8.0),
      child: CachedNetworkImage(
        imageUrl: imagePath,
        placeholder: (context, url) => Container(),
        errorWidget: (context, url, error) => Icon(Icons.error),
        fit: BoxFit.contain,
      ),
    );
  }
}
