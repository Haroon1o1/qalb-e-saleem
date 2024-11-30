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
  final String tag;
  final int duration;

  TextScreen({
    super.key,
    required this.image,
    required this.duration,
    required this.name,
    required this.tag,
    required this.audioPath,
  });

  @override
  State<TextScreen> createState() => _TextScreenState();
}

class _TextScreenState extends State<TextScreen> {

  @override
void dispose() {
  super.dispose();
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
                      Hero(
                        tag:widget.tag,
                        child: Container(
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
                  getImageAddress(),
                  height: 70,
                  width: 70,
                  fit: BoxFit.fill,
                )
              : CachedNetworkImage(
                  imageUrl: getImageAddress(),
                  height: 70,
                  width: 70,
                  fit: BoxFit.fill,
                  placeholder: (context, url) => Container(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
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


  String getImageAddress() {
    final imageMap = {
      "منقبت": "https://firebasestorage.googleapis.com/v0/b/qalb-e-saleem-c7987.appspot.com/o/pngs%2Fmanqabat-white.png?alt=media&token=eaa3c36e-80c0-4f93-82c2-874f7f9df704",
      "اظہار تشکر": "https://firebasestorage.googleapis.com/v0/b/qalb-e-saleem-c7987.appspot.com/o/pngs%2Fizhar-white.png?alt=media&token=926120f6-72b1-4911-bb88-82053107ad60",
      "الفراق": "https://firebasestorage.googleapis.com/v0/b/qalb-e-saleem-c7987.appspot.com/o/pngs%2Falfiraq-white.png?alt=media&token=6457350d-b92c-4137-8c0b-3458a8ac766f",
      "مقدمہ الکتاب": "https://firebasestorage.googleapis.com/v0/b/qalb-e-saleem-c7987.appspot.com/o/pngs%2Fmuqadma-white.png?alt=media&token=708c31c0-5f78-4b0a-9c54-7d89651be058",
      "پیش لفظ": "https://firebasestorage.googleapis.com/v0/b/qalb-e-saleem-c7987.appspot.com/o/pngs%2Fpaish_lafz-white.png?alt=media&token=c96fd275-b73a-48a2-b8b7-888a633c25a1",
      "سوانح حیات": "https://firebasestorage.googleapis.com/v0/b/qalb-e-saleem-c7987.appspot.com/o/pngs%2Fsawane-white.png?alt=media&token=a36b7833-abd0-4d58-a94f-cd13db32ed91",
      "قلبِ سلیم": "https://firebasestorage.googleapis.com/v0/b/qalb-e-saleem-c7987.appspot.com/o/pngs%2Fqalb_e_saleem-white.png?alt=media&token=5f6b40ff-deba-44b2-a33d-08d71ad1c1db",
      "شجرٔہ قادریہ حسبیہ": "https://firebasestorage.googleapis.com/v0/b/qalb-e-saleem-c7987.appspot.com/o/pngs%2Fshajra_hasbia.png?alt=media&token=7d24e2a2-317f-4798-90fd-8909a8b763d9",
      "شجرٔہ قادریہ نسبیہ": "https://firebasestorage.googleapis.com/v0/b/qalb-e-saleem-c7987.appspot.com/o/pngs%2Fshajra_nasbia.png?alt=media&token=747a78a2-137c-413f-877c-52c724b2c00c",
      "قطعہ تاریخ وصال": "https://firebasestorage.googleapis.com/v0/b/qalb-e-saleem-c7987.appspot.com/o/pngs%2Fqata-white.png?alt=media&token=eb630353-a13f-4b2b-9c49-ce0402b7659d",
      "2منقبت": "https://firebasestorage.googleapis.com/v0/b/qalb-e-saleem-c7987.appspot.com/o/pngs%2Fmanqabat2-white.png?alt=media&token=3251e169-aac7-4222-902b-8ffc0af48a89",
    };
    return imageMap[widget.name] ?? "";
  }


  String getPdfsName() {
    final pdfMap = {
      "منقبت": "https://firebasestorage.googleapis.com/v0/b/qalb-e-saleem-c7987.appspot.com/o/pdfs%2Fmanqabat.pdf?alt=media&token=b3a2ab54-ea00-4d2b-a413-7a4ee2261bac",
      "اظہار تشکر": "https://console.firebase.google.com/project/qalb-e-saleem-c7987/storage/qalb-e-saleem-c7987.appspot.com/files/~2Fpdfs",
      "الفراق": "https://firebasestorage.googleapis.com/v0/b/qalb-e-saleem-c7987.appspot.com/o/pdfs%2Falfiraq.pdf?alt=media&token=a4105358-93ef-4142-9602-d66927c1bf0c",
      "مقدمہ الکتاب": "https://firebasestorage.googleapis.com/v0/b/qalb-e-saleem-c7987.appspot.com/o/pdfs%2Fmuqadma.pdf?alt=media&token=1b1795ec-a528-4001-994a-0dd212f141f0",
      "پیش لفظ":"https://firebasestorage.googleapis.com/v0/b/qalb-e-saleem-c7987.appspot.com/o/pdfs%2Fpaish_lafz.pdf?alt=media&token=770bc9ba-56b3-4548-bf80-aac876052caa" ,
      "سوانح حیات": "https://firebasestorage.googleapis.com/v0/b/qalb-e-saleem-c7987.appspot.com/o/pdfs%2Fsawane.pdf?alt=media&token=8e41532a-1d73-46b1-8559-4021e088ad3f",
      "قلبِ سلیم": "https://firebasestorage.googleapis.com/v0/b/qalb-e-saleem-c7987.appspot.com/o/pdfs%2Fqalb_e_saleem.pdf?alt=media&token=9b1a4b90-0ac6-4c93-8e54-dde768a799b7",
      "شجرٔہ قادریہ حسبیہ":"https://firebasestorage.googleapis.com/v0/b/qalb-e-saleem-c7987.appspot.com/o/pdfs%2Fshajra_hasbia.pdf?alt=media&token=b86df206-484b-4611-8a98-78e0ce931510" ,
      "شجرٔہ قادریہ نسبیہ":"https://firebasestorage.googleapis.com/v0/b/qalb-e-saleem-c7987.appspot.com/o/pdfs%2Fshajra_nasbia.pdf?alt=media&token=c392c645-d187-452b-8f69-39b04ad6cc25" ,
      "قطعہ تاریخ وصال":"https://firebasestorage.googleapis.com/v0/b/qalb-e-saleem-c7987.appspot.com/o/pdfs%2Fqata.pdf?alt=media&token=370b6ed1-e243-49f2-9e41-fd71726f0cfd" ,
      "2منقبت": "https://firebasestorage.googleapis.com/v0/b/qalb-e-saleem-c7987.appspot.com/o/pdfs%2Fmanqabat2.pdf?alt=media&token=fef71bc8-9758-45f0-8efa-199e9adfffe1",
    };
      return pdfMap[widget.name] ?? "";
    }

  Color? getColor() {
    final colorMap = {
      "منقبت": Color(0xFF10A8E3),
      "اظہار تشکر": Color(0xFF2C3491),
      "الفراق": Color(0xFF281E63),
      "مقدمہ الکتاب": Color(0xFF692592),
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
