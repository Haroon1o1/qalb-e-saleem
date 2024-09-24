import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:qalb/providers/DataProvider.dart';
import 'package:qalb/providers/SoundPlayerProvider.dart';
import 'package:qalb/screens/sound_screen.dart/sound_player.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Majlis_Text extends StatefulWidget {
  final String image;
  final String name;
  final int index;
  final int duration;

  final String file;
  final String audioPath;

  Majlis_Text(
      {super.key,
      required this.index,
      required this.duration,
      required this.image,
      required this.name,
      required this.file,
      required this.audioPath});

  @override
  State<Majlis_Text> createState() => _Majlis_TextState();
}

class _Majlis_TextState extends State<Majlis_Text> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Consumer<SoundPlayerProvider>(
              builder: (context, soundPlayerProvider, _) {
            return Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.30,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/upergrad.png"),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Platform.isIOS
              ? Image.network(
                  widget.image,
                  width: 80,
                  height:80,
                  fit: BoxFit.fill,
                )
              : CachedNetworkImage(
                  imageUrl: widget.image,
                  width: 80,
                  height:80,
                  fit: BoxFit.fill,
                  placeholder: (context, url) => Container(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                                   
                                    SizedBox(width: 15),
                                    GestureDetector(
                                      onTap: () => soundPlayerProvider
                                          .togglePlayStop(widget.audioPath),
                                      child: Image.asset(
                                        soundPlayerProvider.isPlaying
                                            ? "assets/images/pause-white.png"
                                            : "assets/images/play.png",
                                        color: soundPlayerProvider.isPlaying
                                            ? null
                                            : Colors.white,
                                        width: 35,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      child: Text(
                                        textDirection: TextDirection.rtl,
                                        overflow: TextOverflow.clip,
                                        widget.name,
                                        style: GoogleFonts.almarai(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Image.asset(
                                        "assets/images/back-arrow-white.png",
                                        width: 25,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 70,
                                        child: Row(
                                          children: [
                                            Image.asset(
                                                "assets/images/clock-white.png",
                                                width: 15),
                                            SizedBox(width: 5),
                                            Text(
                                              soundPlayerProvider
                                                  .formatDuration(
                                                      soundPlayerProvider
                                                          .position),
                                              style: GoogleFonts.almarai(
                                                fontSize: 12,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 200,
                                        child: SliderTheme(
                                          data:
                                              SliderTheme.of(context).copyWith(
                                            activeTrackColor: Colors.grey[100],
                                            inactiveTrackColor:
                                                Colors.grey[200],
                                            thumbColor: Colors.grey,
                                            thumbShape:
                                                CustomRoundSliderThumbShape(),
                                            overlayColor:
                                                Colors.grey.withOpacity(0.2),
                                            trackHeight: 1.0,
                                          ),
                                          child: Slider(
                                            value: soundPlayerProvider
                                                .position.inSeconds
                                                .toDouble(),
                                            min: 0.0,
                                            max: widget.duration.toDouble(),
                                            onChanged: (value) {
                                              soundPlayerProvider
                                                  .seekAudio(value);
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  LottieBuilder.asset(
                                    animate: Provider.of<SoundPlayerProvider>(
                                            context,
                                            listen: false)
                                        .isPlaying,
                                    "assets/images/voice.json",
                                    width: 20,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.25,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              height: MediaQuery.of(context).size.height * 0.8,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset(
                      "assets/new_images/arrow-up.png",
                      width: 20,
                    ),
                    SizedBox(height: 5),
                    Container(
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
                          borderRadius: BorderRadius.circular(20)),
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height * 0.66,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Container(
                          child: SfPdfViewer.network(
                        Provider.of<DataProvider>(context, listen: false)
                            .majlisText[widget.index],
                        canShowScrollHead: false,
                        canShowPaginationDialog: false,
                        pageSpacing: 0,
                        enableTextSelection: false,
                        canShowPageLoadingIndicator:
                            false, // Disable page loading indicator
                        canShowScrollStatus: true,
                      )),
                    ),
                    SizedBox(height: 5),
                    Image.asset(
                      "assets/new_images/arrow-down.png",
                      width: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
