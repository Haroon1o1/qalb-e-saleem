import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qalb/Transition/CustomPageTransition.dart';
import 'package:qalb/data/data.dart';
import 'package:qalb/data/links.dart';
import 'package:qalb/providers/SoundPlayerProvider.dart';
import 'package:qalb/screens/majlis_screens/majlis_text.dart';
import 'package:qalb/screens/sound_screen.dart/sound_player.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Majlis_Sound extends StatefulWidget {
  final String image;
  final String name;
  final String sub;
  final String tag;
  final int index;
  final String audioPath;
  

  Majlis_Sound({
    super.key,
    required this.image,
    required this.index,
    required this.name,
    required this.sub,
    required this.tag,
    required this.audioPath,
  });

  @override
  State<Majlis_Sound> createState() => _Majlis_SoundState();
}

class _Majlis_SoundState extends State<Majlis_Sound> {
  late SoundPlayerProvider soundPlayerProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    soundPlayerProvider =
        Provider.of<SoundPlayerProvider>(context, listen: true);
  }
  @override
  void initState() {
    loadAudioPosition();
   
     
     
   
    super.initState();
  }

  @override
  void dispose() {
    saveAudioPosition(soundPlayerProvider.position);
    soundPlayerProvider.stopAudio();
    super.dispose();
  }

  Future<void> saveAudioPosition(Duration position) async {
    final prefs = await SharedPreferences.getInstance();
    if (position.inSeconds > 0) {
      prefs.setInt("majlis${widget.index + 1}", position.inSeconds);
    }
  }

  Future<void> loadAudioPosition() async {
    final prefs = await SharedPreferences.getInstance();
    int? savedPosition = prefs.getInt("majlis${widget.index + 1}");
    if (savedPosition != null && savedPosition > 0) {
      soundPlayerProvider.seekAudio(savedPosition.toDouble());
    } else {
      soundPlayerProvider.seekAudio(Duration.zero.inSeconds.toDouble());
    }
  }

  void navigateToMajlis(int newIndex) {
    Navigator.pushReplacement(
      context,
      CustomPageNavigation(
        child: Majlis_Sound(
          tag: TextData.majlisUrdu[newIndex],
          image: Links.MajlisSoundImage[newIndex],
          index: newIndex,
          name: TextData.majlisUrdu[newIndex],
          sub: TextData.majlisUrdu[newIndex],
          audioPath: Links.majlisSound[newIndex],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        soundPlayerProvider.stopAudio();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.1),
          child: Consumer<SoundPlayerProvider>(
            builder: (context, soundPlayerProvider, _) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF8590A3),
                                    shape: BoxShape.circle,
                                  ),
                                  width: 25,
                                  height: 25,
                                  child: Text(
                                    "${widget.index + 1}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text("مجلس",
                                    style: GoogleFonts.almarai(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF8590A3))),
                              ],
                            ),
                            SizedBox(height: 30),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                soundPlayerProvider
                                    .stopAudio(); // Use stopAudio() method
                              },
                              child: Image.asset(
                                  "assets/images/back-arrow-grey.png",
                                  width: 25),
                            ),
                          ],
                        ),
                        SizedBox(height: 40),
                        Hero(
                          tag: widget.tag,
                          child: Container(
                          height: MediaQuery.of(context).size.height * 0.40,
                          decoration: BoxDecoration(
                           
                            image: DecorationImage(
                              image: Platform.isIOS ? NetworkImage(widget.image,) : CachedNetworkImageProvider(widget.image),
                              fit: BoxFit.fitWidth,
                            ),
                            borderRadius: BorderRadiusDirectional.circular(5),
                          ),
                                                  ),
                        ),
                        SizedBox(height:20),
                        Text(
                          widget.name,
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.almarai(
                              fontSize: 19,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                          overflow: TextOverflow.clip,
                          widget.sub,
                          style: GoogleFonts.almarai(
                            fontSize: 13,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
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
                          child: Slider(
                            value: soundPlayerProvider.position.inSeconds
                                .toDouble(),
                            min: 0.0,
                            max: getDuration().toDouble(),
                            onChanged: (value) {
                              soundPlayerProvider.seekAudio(value);
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.06),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                soundPlayerProvider.formatDuration(
                                    soundPlayerProvider.position),
                                style: GoogleFonts.openSans(
                                  color: Color(0xFF8590A3),
                                  fontSize: 11,
                                ),
                              ),
                              Text(
                                soundPlayerProvider.formatDuration(
                                    Duration(seconds: getDuration())),
                                style: GoogleFonts.openSans(
                                    color: Color(0xFF8590A3), fontSize: 11),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    CustomPageNavigation(
                                      child: Majlis_Text(
                                        duration: getDuration(),
                                        audioPath: widget.audioPath,
                                        index: widget.index,
                                        image: Links.MajlisSoundImage[widget.index],
                                        name: widget.name,
                                        file: Links.majlisText[widget.index],
                                      ),
                                    ));
                              },
                              child: Image.asset(
                                "assets/images/read.png",
                                width: 30,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Previous button, hide if index is 0
                                if (widget.index < 19)
                                  GestureDetector(
                                    onTap: () {
                                      saveAudioPosition(
                                              soundPlayerProvider.position)
                                          .then((_) {
                                        soundPlayerProvider.stopAudio();
                                        navigateToMajlis(widget.index + 1);
                                      });
                                    },
                                    child: Image.asset(
                                      "assets/new_images/next-left.png",
                                      width: 20,
                                    ),
                                  )
                                else
                                  SizedBox(width: 35),
                                SizedBox(width: 5),
                                GestureDetector(
                                  onTap: () => soundPlayerProvider
                                      .togglePlayStop(widget.audioPath),
                                  child: Image.asset(
                                    soundPlayerProvider.isPlaying
                                        ? "assets/images/pause.png"
                                        : "assets/images/play.png",
                                    width: 60,
                                  ),
                                ),
                                SizedBox(width: 5),
                                // Next button, hide if index is 19
                                if (widget.index > 0)
                                  GestureDetector(
                                    onTap: () {
                                      if(Platform.isAndroid){
                                        saveAudioPosition(
                                              soundPlayerProvider.position)
                                          .then((_) {
                                        soundPlayerProvider.stopAudio();
                                        navigateToMajlis(widget.index - 1);
                                      });
                                      }else{
soundPlayerProvider.stopAudio();
                                        navigateToMajlis(widget.index - 1);
                                      }
                                    },
                                    child: Image.asset(
                                      "assets/new_images/next-right.png",
                                      width: 20,
                                    ),
                                  )
                                else
                                  SizedBox(width: 35),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                Share.share(
                                    'Download Qalb-E-Saleem App: https://play.google.com/store/apps/details?id=com.bookreadqbs.qalbesaleem&hl=en');
                              },
                              child: Image.asset(
                                "assets/images/share-grey.png",
                                width: 28,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,)
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  int getDuration() {
    final duration = {
      1: 883,
      2: 1099,
      3: 910,
      4: 3465,
      5: 2072,
      6: 1983,
      7: 981,
      8: 1105,
      9: 730,
      10: 1059,
      11: 1340,
      12: 921,
      13: 1830,
      14: 1083,
      15: 2402,
      16: 1393,
      17: 1756,
      18: 838,
      19: 880,
      20: 2133,
    };
    return duration[widget.index + 1] ?? 0;
  }
}
