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

class TextScreen extends StatefulWidget {
  final String image;
  final String name;
  final String audioPath;
  final int duration;

  TextScreen({
    super.key,
    required this.image,
    required this.duration,
    required this.name,
    required this.audioPath,
  });

  @override
  State<TextScreen> createState() => _TextScreenState();
}

class _TextScreenState extends State<TextScreen> {
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
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.30,
                        decoration: getColor() == null
                            ? BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/upergrad.png"),
                                    fit: BoxFit.fill))
                            : BoxDecoration(color: getColor()),
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
                                    Consumer<DataProvider>(
                                      builder: (context, dataProvider, child) {
                                        String imageUrl = getImageAddress(dataProvider);
                                        return imageUrl.isEmpty
                                            ? Container(width: 70)
                                            : Platform.isIOS
              ? Image.network(
                  imageUrl,
                  height: 70,
                  width: MediaQuery.of(context).size.width * 70,
                  fit: BoxFit.fill,
                )
              : CachedNetworkImage(
                  imageUrl: imageUrl,
                  height: 70,
                  width: MediaQuery.of(context).size.width * 0.87,
                  fit: BoxFit.fill,
                  placeholder: (context, url) => Container(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                );
                                      },
                                    ),
                                    SizedBox(width: 10),
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
                                    Text(
                                      widget.name,
                                      style: GoogleFonts.almarai(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
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
                            // Slider added here
                            Consumer<SoundPlayerProvider>(
                              builder: (context, soundPlayerProvider, _) {
                                return Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(children: [
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
                                            SliderTheme(
                                              data: SliderTheme.of(context)
                                                  .copyWith(
                                                activeTrackColor:
                                                    Colors.grey[100],
                                                inactiveTrackColor:
                                                    Colors.grey[200],
                                                thumbColor: Colors.grey,
                                                thumbShape:
                                                    CustomRoundSliderThumbShape(),
                                                overlayColor: Colors.grey
                                                    .withOpacity(0.2),
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
                                          ]),
                                          LottieBuilder.asset(
                                            animate: Provider.of<
                                                        SoundPlayerProvider>(
                                                    context,
                                                    listen: false)
                                                .isPlaying,
                                            "assets/images/voice.json",
                                            width: 20,
                                          ),
                                        ]));
                              },
                            ),
                            SizedBox(height: 0),
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
                    Image.asset("assets/new_images/arrow-up.png", width: 20),
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
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height * 0.66,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Container(
                        child: SfPdfViewer.network(
                          getPdfsName(),
                          canShowScrollHead: false,
                          canShowPaginationDialog: false,
                          pageSpacing: 0,
                          enableTextSelection: false,
                          canShowPageLoadingIndicator: false, // Disable page loading indicator
                          canShowScrollStatus: true,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Image.asset("assets/new_images/arrow-down.png", width: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  String getTextFile() {
    final textFileMap = {
      "اظہار تشکر": "assets/textFiles/tashakur.pdf",
      "مقّدمۃ الکتاب": "assets/textFiles/maqadma.pdf",
      "الفراق": "assets/textFiles/alfiraq.pdf",
      "پیش لفظ": "assets/textFiles/peshLafz.pdf",
      "سوانح حیات": "assets/textFiles/sawana.pdf",
      "قلبِ سلیم": "assets/textFiles/qalb.pdf",
      "شجرٔہ قادریہ حسبیہ": "assets/textFiles/hasbia.pdf",
      "شجرٔہ قادریہ نسبیہ": "assets/textFiles/nasbiya.pdf",
      "قطعہ تاریخ وصال": "assets/textFiles/qata.pdf",
      "منقبت": "assets/textFiles/manqabat1.pdf",
      "2منقبت": "assets/textFiles/manqabat2.pdf",
    };
    return textFileMap[widget.name] ?? "";
  }

  String getImageAddress(DataProvider dataProvider) {
    final imageMap = {
      "منقبت": dataProvider
          .imageMap["manqabat-white"],
      "اظہار تشکر": dataProvider
          .imageMap["izhar-white"],
      "الفراق": dataProvider
          .imageMap["alfiraq-white"],
      "مقّدمۃ الکتاب": dataProvider
          .imageMap["muqadma-white"],
      "پیش لفظ": dataProvider
          .imageMap["paish_lafz-white"],
      "سوانح حیات": dataProvider
          .imageMap["sawane-white"],
      "قلبِ سلیم": dataProvider
          .imageMap["qalb_e_saleem-white"],
      "شجرٔہ قادریہ حسبیہ": dataProvider
          .imageMap["shajra_hasbia"],
      "شجرٔہ قادریہ نسبیہ": dataProvider
          .imageMap["shajra_nasbia"],
      "قطعہ تاریخ وصال": dataProvider
          .imageMap["qata_white"],
      "2منقبت": dataProvider
          .imageMap["manqabat2-white"],
    };
    return imageMap[widget.name] ?? "";
  }


  String getPdfsName() {
    final pdfMap = {
      "منقبت": Provider.of<DataProvider>(context, listen: false)
          .pdfMap["manqabat"],
      "اظہار تشکر": Provider.of<DataProvider>(context, listen: false)
          .pdfMap["izhar"],
      "الفراق": Provider.of<DataProvider>(context, listen: false)
          .pdfMap["alfiraq"],
      "مقّدمۃ الکتاب": Provider.of<DataProvider>(context, listen: false)
          .pdfMap["muqadma"],
      "پیش لفظ": Provider.of<DataProvider>(context, listen: false)
          .pdfMap["paish_lafz"],
      "سوانح حیات": Provider.of<DataProvider>(context, listen: false)
          .pdfMap["sawane"],
      "قلبِ سلیم": Provider.of<DataProvider>(context, listen: false)
          .pdfMap["qalb_e_saleem"],
      "شجرٔہ قادریہ حسبیہ": Provider.of<DataProvider>(context, listen: false)
          .pdfMap["shajra_hasbia"],
      "شجرٔہ قادریہ نسبیہ": Provider.of<DataProvider>(context, listen: false)
          .pdfMap["shajra_nasbia"],
      "قطعہ تاریخ وصال": Provider.of<DataProvider>(context, listen: false)
          .pdfMap["qata"],
      "2منقبت": Provider.of<DataProvider>(context, listen: false)
          .pdfMap["manqabat2"],
    };
    return pdfMap[widget.name] ?? "";
  }

  Color? getColor() {
    final colorMap = {
      "منقبت": Color(0xFF10A8E3),
      "اظہار تشکر": Color(0xFF2C3491),
      "الفراق": Color(0xFF281E63),
      "مقّدمۃ الکتاب": Color(0xFF692592),
      "پیش لفظ": Color(0xFF00B771),
      "سوانح حیات": Color(0xFF00BEAE),
      "قلبِ سلیم": Color(0xFF1373BF),
      "شجرٔہ قادریہ حسبیہ": null,
      "شجرٔہ قادریہ نسبیہ": null,
      "قطعہ تاریخ وصال": Color(0xFF1373BF),
      "2منقبت": Color(0xFF00A79D),
    };
    return colorMap[widget.name] ?? null;
  }
}
