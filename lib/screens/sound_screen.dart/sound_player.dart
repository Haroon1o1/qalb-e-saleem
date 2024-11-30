import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
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
  super.initState();
}


  @override
  void dispose() {
    saveAudioPosition(widget.name, soundPlayerProvider.position);
    soundPlayerProvider.stopAudio();
    super.dispose();
  }

  Future<void> saveAudioPosition(String name, Duration position) async {
    final prefs = await SharedPreferences.getInstance();

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
                                onTap: ()async{soundPlayerProvider
                                    .togglePlayStop(await getAudio());},
                                child: Image.asset(
                                  soundPlayerProvider.isPlaying
                                      ? "assets/images/pause.png"
                                      : "assets/images/play.png",
                                  width: 60,
                                ),
                              ),
                              GestureDetector(
                              onTap: () {
                                Share.share('Download Qalb-E-Saleem App: https://play.google.com/store/apps/details?id=com.bookreadqbs.qalbesaleem&hl=en');
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
      "منقبت": "https://firebasestorage.googleapis.com/v0/b/qalb-e-saleem-c7987.appspot.com/o/audio%2Fmanqabat1.mp3?alt=media&token=7480350d-aebd-4072-a880-a4bbb49e7e41",
      "اظہار تشکر": "https://firebasestorage.googleapis.com/v0/b/qalb-e-saleem-c7987.appspot.com/o/audio%2Ftashakur.mp3?alt=media&token=6a66383b-0081-433a-8ac4-4b7edc11f871",
      "الفراق": "https://firebasestorage.googleapis.com/v0/b/qalb-e-saleem-c7987.appspot.com/o/audio%2Falfiraq.mp3?alt=media&token=af74c030-2970-4710-92a0-e02c1d0fe955",
      "مقدمہ الکتاب":"https://firebasestorage.googleapis.com/v0/b/qalb-e-saleem-c7987.appspot.com/o/audio%2Fmuqadma.mp3?alt=media&token=7c0c25fb-0396-4a00-9d1e-d07e224eaed2" ,
      "پیش لفظ":"https://firebasestorage.googleapis.com/v0/b/qalb-e-saleem-c7987.appspot.com/o/audio%2Fpaishlafz.mp3?alt=media&token=7c676ba1-c4f6-40ae-95d8-00af09232f7c" ,
      "سوانح حیات": "https://firebasestorage.googleapis.com/v0/b/qalb-e-saleem-c7987.appspot.com/o/audio%2Fsawana.mp3?alt=media&token=849ee633-d3c7-42fb-b10e-e06992af6493",
      "قلبِ سلیم": "https://console.firebase.google.com/project/qalb-e-saleem-c7987/storage/qalb-e-saleem-c7987.appspot.com/files/~2Faudio",
      "شجرٔہ قادریہ حسبیہ": "https://firebasestorage.googleapis.com/v0/b/qalb-e-saleem-c7987.appspot.com/o/audio%2Fshajra_hasbiya.mp3?alt=media&token=c07580d8-2e59-4370-b8eb-13fcb1c3ef3d",
      "شجرٔہ قادریہ نسبیہ": "https://firebasestorage.googleapis.com/v0/b/qalb-e-saleem-c7987.appspot.com/o/audio%2Fshajra_nasbiya.mp3?alt=media&token=15c54dc3-8082-46b4-9a8c-456ed7bcd7a5",
      "قطعہ تاریخ وصال": "https://firebasestorage.googleapis.com/v0/b/qalb-e-saleem-c7987.appspot.com/o/audio%2Fqata.mp3?alt=media&token=2087f0db-1c42-4a65-8fcd-db5f6fa795f7",
      "2منقبت": "https://firebasestorage.googleapis.com/v0/b/qalb-e-saleem-c7987.appspot.com/o/audio%2Fmanqabat2.mp3?alt=media&token=a0a1b5f7-5778-4041-977d-09c514500a19",
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



