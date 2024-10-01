import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qalb/providers/DataProvider.dart';
import 'package:qalb/providers/SoundPlayerProvider.dart';
import 'package:qalb/screens/sound_screen.dart/text_screen.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SoundPlayer extends StatefulWidget {
  final String image;
  final String name;
  final String sub;
  final String tag;

  SoundPlayer({
    super.key,
    required this.image,
    required this.name,
    required this.sub,
    required this.tag,
  });

  @override
  State<SoundPlayer> createState() => _SoundPlayerState();
}

class _SoundPlayerState extends State<SoundPlayer> {
  Map<String, dynamic> images = {};
  late SoundPlayerProvider soundPlayerProvider;
  @override
  void initState() {
    loadAudioPosition(widget.name);
    super.initState();
    images = Provider.of<DataProvider>(context, listen: false).audioMap;
    soundPlayerProvider = Provider.of<SoundPlayerProvider>(context, listen: false);
    
    
  }

  @override
  void dispose() {
    saveAudioPosition(widget.name, soundPlayerProvider.position);
    soundPlayerProvider.stopAudio();
    super.dispose();
  }

  Future<void> saveAudioPosition(String name, Duration position) async {
    final prefs = await SharedPreferences.getInstance();
        log("in saving audio method for name ${name} --- seconds: ${position.inSeconds}"); 

    if(position.inSeconds.toDouble() > 0){
      prefs.setInt(name, position.inSeconds);
    }
  }

  Future<void> loadAudioPosition(String name) async {
    final prefs = await SharedPreferences.getInstance();
    int? savedPosition = prefs.getInt(name);

    if (savedPosition != null && savedPosition > 0) {
                log("in load audio method for name ${name} --- seconds: ${savedPosition} -- duration is ${getDuration()}"); 

    
     
        soundPlayerProvider.seekAudio(savedPosition.toDouble());

    }else{
        soundPlayerProvider.seekAudio(Duration.zero.inSeconds.toDouble());
      }
  }


  @override
  Widget build(BuildContext context) {
    log(images["shajra_nasbiya"]);
        soundPlayerProvider =
        Provider.of<SoundPlayerProvider>(context, listen: true);
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        soundPlayerProvider.stopAudio();
      },
      canPop: true,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.1),
          height: MediaQuery.of(context).size.height * 1,
          alignment: Alignment.center,
          child: Consumer<SoundPlayerProvider>(
            builder: (context, soundPlayerProvider, _) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 0),
                    Column(
                      
                      children: [
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
                                    color: Color(0xFF8590A3))),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                soundPlayerProvider.stopAudio();
                              },
                              child: Image.asset(
                                  "assets/images/back-arrow-grey.png",
                                  width: 25),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 50),
                      Hero(
                        tag:widget.tag,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.42,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  widget.image,
                                ),
                                fit: BoxFit.fill,
                              ),
                              borderRadius: BorderRadiusDirectional.circular(5)),
                        ),
                      ),
SizedBox(height:10),
                      Text(
                        overflow: TextOverflow.clip,
                        textAlign: TextAlign.center,
                          widget.name,
                          style: GoogleFonts.almarai(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          child: Text(
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                            overflow: TextOverflow.clip,
                            widget.sub,
                            style: GoogleFonts.almarai(
                              fontSize: 13,
                              color: Colors.black,
                            ),
                          ),
                        ),
                    ]),
                 
                    Column(
                      children: [
                        
                        SizedBox(height: 0),
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: Color(0xFF8590A3),
                            inactiveTrackColor: Colors.grey[300],
                            thumbColor: Color(0xFF9BA8B9),
                            thumbShape: CustomRoundSliderThumbShape(),
                            overlayColor: Colors.grey.withOpacity(0.2),
                            trackHeight: 1.8,
                          ),
                          child:  Slider(
                          value: soundPlayerProvider.position.inSeconds.toDouble(),
                          min: 0.0,
                          max: Duration(seconds: getDuration()).inSeconds.toDouble(),
                          onChanged: (value) {
                            log('Slider changed to: $value');
                            soundPlayerProvider.seekAudio(value);
                          },
                        ),
                        
                        
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                             
                              Text(
                                soundPlayerProvider.formatDuration(
                                    Duration(seconds:getDuration())),
                                style: TextStyle(color: Color(0xFF9BA8B9)),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => TextScreen(
                                            tag: widget.tag,
                                            audioPath: getAudio(),
                                            image: widget.image,
                                            duration: getDuration(),
                                            name: widget.name,
                                          ),
                                        ));
                                  },
                                  child: Image.asset(
                                    "assets/images/read.png",
                                    width: 30,
                                  )),
                              GestureDetector(
                                onTap: () => soundPlayerProvider
                                    .togglePlayStop(getAudio()),
                                child: Image.asset(
                                  soundPlayerProvider.isPlaying
                                      ? "assets/images/pause.png"
                                      : "assets/images/play.png",
                                  width: 60,
                                ),
                              ),
                              GestureDetector(
                              onTap: () {
                                Share.share('Download Qalb-E-Saleem App: https://play.google.com/store/apps/details?id=com.hizburehman.qalb_e_saleem&hl=en');
                              },
                              child: Image.asset(
                                "assets/images/share-grey.png",
                                width: 28,
                              ),
                            ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  String getAudio() {
    
    final audioMap = {
      "منقبت": images["manqabat1"],
      "اظہار تشکر": images["tashakur"],
      "الفراق": images["alfiraq"],
      "مقدمہ الکتاب": images["muqadma"],
      "پیش لفظ": images["paishlafz"],
      "سوانح حیات": images["sawana"],
      "قلبِ سلیم": images["qalb"],
      "شجرٔہ قادریہ حسبیہ": images["shajra_hasbiya"],
      "شجرٔہ قادریہ نسبیہ": images["shajra_nasbiya"],
      "قطعہ تاریخ وصال": images["qata"],
      "2منقبت": images["manqabat2"],
    };
    return audioMap[widget.name] ?? "";
  }

  int getDuration() {
    final duration = {
      "منقبت": 160,
      "اظہار تشکر": 373,
      "الفراق": 161,
      "مقدمہ الکتاب": 964,
      "پیش لفظ": 2425,
      "سوانح حیات": 2207,
      "قلبِ سلیم": 628,
      "شجرٔہ قادریہ حسبیہ": 751,
      "شجرٔہ قادریہ نسبیہ": 421,
      "قطعہ تاریخ وصال": 51,
      "2منقبت": 108 ,
    };
    return duration[widget.name] ?? 0;
  }
}

// -----------------------------------------------SLIDER STYLE
class CustomRoundSliderThumbShape extends SliderComponentShape {
  final double outerRadius;
  final double innerRadius;

  CustomRoundSliderThumbShape({this.outerRadius = 12.0, this.innerRadius = 5.0});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(outerRadius * 2 + 4.0, outerRadius * 2 + 4.0);
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

    // Draw the outer circle with some padding
    canvas.drawCircle(center, outerRadius, outerPaint);

    final Paint innerPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Draw the inner circle
    canvas.drawCircle(center, innerRadius, innerPaint);
  }
}



