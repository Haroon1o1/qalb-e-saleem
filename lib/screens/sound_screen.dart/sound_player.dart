import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:qalb/providers/SoundPlayerProvider.dart';
import 'package:qalb/screens/sound_screen.dart/text_screen.dart';

class SoundPlayer extends StatelessWidget {
  final String image;
  final String name;
  final String sub;
  final String audioPath;

  SoundPlayer({
    super.key,
    required this.image,
    required this.name,
    required this.sub,
    required this.audioPath,
  });

  @override
  Widget build(BuildContext context) {
    print('________________________________________________TEST');
    return ChangeNotifierProvider(
      create: (_) => SoundPlayerProvider(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<SoundPlayerProvider>(
          builder: (context, soundPlayerProvider, _) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 70),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.32),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("قلبِ سلیم",
                              style: GoogleFonts.almarai(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[500])),
                          InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Image.asset(
                                  "assets/images/back-arrow-grey.png",
                                  width: 25)),
                        ],
                      ),
                    ),
                    SizedBox(height: 50),
                    Hero(
                      tag: "image",
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.asset(
                          image,
                          width: double.infinity,
                          height: 320.0,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      name,
                      style: GoogleFonts.almarai(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      textDirection: TextDirection.rtl,
                      overflow: TextOverflow.ellipsis,
                      sub,
                      style: GoogleFonts.almarai(
                        fontSize: 13,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 20),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: Colors.grey,
                        inactiveTrackColor: Colors.grey[300],
                        thumbColor: Colors.grey,
                        thumbShape: CustomRoundSliderThumbShape(),
                        overlayColor: Colors.grey.withOpacity(0.2),
                        trackHeight: 4.0,
                      ),
                      child: Slider(
                        value:
                            soundPlayerProvider.position.inSeconds.toDouble(),
                        min: 0.0,
                        max: soundPlayerProvider.duration.inSeconds.toDouble(),
                        onChanged: (value) {
                          soundPlayerProvider.seekAudio(value);
                        },
                      ),
                    ),
                    // ----------------------TIME of AUDIO---------------
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            soundPlayerProvider
                                .formatDuration(soundPlayerProvider.position),
                            style: TextStyle(color: Colors.black),
                          ),
                          Text(
                            soundPlayerProvider
                                .formatDuration(soundPlayerProvider.duration),
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TextScreen(
                                      image: image,
                                      name: name,
                                      audioPath: audioPath,
                                    ),
                                  ));
                            },
                            child: Image.asset(
                              "assets/images/read.png",
                              width: 35,
                            )),
                        GestureDetector(
                          onTap: () =>
                              soundPlayerProvider.togglePlayStop(audioPath),
                          child: Image.asset(
                            soundPlayerProvider.isPlaying
                                ? "assets/images/play.png"
                                : "assets/images/play.png",
                            width: 60,
                          ),
                        ),
                        Image.asset(
                          "assets/images/share-grey.png",
                          width: 35,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// --------------------------SIDER STYLE------------------------------
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
