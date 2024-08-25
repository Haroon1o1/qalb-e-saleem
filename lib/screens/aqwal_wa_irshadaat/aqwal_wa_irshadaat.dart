import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qalb/providers/DataProvider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AqwalWaIrshadaatScreen extends StatefulWidget {
  const AqwalWaIrshadaatScreen({super.key});

  @override
  State<AqwalWaIrshadaatScreen> createState() => _AqwalWaIrshadaatScreenState();
}

class _AqwalWaIrshadaatScreenState extends State<AqwalWaIrshadaatScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.8);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log("${Provider.of<DataProvider>(context, listen: false).akwalImageUrls}");
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
              padding: EdgeInsets.symmetric(vertical: 20),
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
                  SizedBox(height: 30),
                  Container(
                    
  height: MediaQuery.of(context).size.height * 0.5,
  child: ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: Provider.of<DataProvider>(context, listen: false).akwalImageUrls.length,
    itemBuilder: (context, index) {     
      return _buildPage(Provider.of<DataProvider>(context, listen: false).akwalImageUrls[index]);
    },
  ),
),

                  SizedBox(height: 30),
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: Provider.of<DataProvider>(context, listen: false).akwalImageUrls.length,
                    effect: WormEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      activeDotColor: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 30),
                  Image.asset(
                    "assets/images/play.png",
                    height: 60,
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
    return Image.network(
      imagePath,
      fit: BoxFit.contain,
    );
  }
}
