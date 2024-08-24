import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:qalb/providers/DataProvider.dart';
import 'package:qalb/providers/SoundPlayerProvider.dart';

class TextScreen extends StatefulWidget {
  final String image;
  final String name;
  final String audioPath;

  TextScreen({
    super.key,
    required this.image,
    required this.name,
    required this.audioPath,
  });

  @override
  State<TextScreen> createState() => _TextScreenState();
}

class _TextScreenState extends State<TextScreen> {
  String fileText = '';
  Map<String, dynamic> images = {};

  @override
  void initState() {
    images = Provider.of<DataProvider>(context, listen: false).imageMap;
    super.initState();
    textFile();
    // The audio is already being managed by the SoundPlayerProvider
  }

  Future<void> textFile() async {
    log("--------------${widget.name}-----${getTextFile()}");
    String fileContent = await rootBundle.loadString(getTextFile());
    setState(() {
      fileText = fileContent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SoundPlayerProvider>(
      builder: (context, soundPlayerProvider, _) {
        return Scaffold(
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.26,
                          decoration: BoxDecoration(color: Colors.blue),
                        ),

                        // YH CHEEZ NI CHL RHI YRA BAKI SB SET HO GYA H
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      getImageAddress() == ""
                                          ? Image.network(widget.image,
                                              width: 80)
                                          : Image.network(
                                              getImageAddress(),
                                              width: 80,
                                            ),
                                      SizedBox(width: 10),
                                      InkWell(
                                        onTap: () {},
                                        child: Image.asset(
                                          "assets/images/pause-white.png",
                                          width: 35,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                      Image.asset(
                                        "assets/images/back-arrow-white.png",
                                        width: 25,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              // ...................................................IDR TK
                              Text('TEST'),

                              // Slider added here
                              Column(
                                children: [
                                  SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                      activeTrackColor: Colors.grey,
                                      inactiveTrackColor: Colors.grey[300],
                                      thumbColor: Colors.grey,
                                      thumbShape: CustomRoundSliderThumbShape(),
                                      overlayColor:
                                          Colors.grey.withOpacity(0.2),
                                      trackHeight: 4.0,
                                    ),
                                    child: Slider(
                                      value: soundPlayerProvider
                                          .position.inSeconds
                                          .toDouble(),
                                      min: 0.0,
                                      max: soundPlayerProvider
                                          .duration.inSeconds
                                          .toDouble(),
                                      onChanged: (value) {
                                        soundPlayerProvider.seekAudio(value);
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
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
                                                fontSize: 10,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          soundPlayerProvider.formatDuration(
                                              soundPlayerProvider.duration),
                                          style: GoogleFonts.almarai(
                                            fontSize: 10,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Html(data: fileText),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String getTextFile() {
    return Provider.of<DataProvider>(context, listen: false)
            .imageMap[widget.name] ??
        '';
  }

  String getImageAddress() {
    return images[widget.name] ?? '';
  }
}

// -----------------------------------------------SLIDER STYLE

class CustomRoundSliderThumbShape extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(24.0, 24.0);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final Paint outerPaint = Paint()
      ..color = sliderTheme.thumbColor!
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, 12.0, outerPaint);

    final Paint innerPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, 5.0, innerPaint);
  }
}
