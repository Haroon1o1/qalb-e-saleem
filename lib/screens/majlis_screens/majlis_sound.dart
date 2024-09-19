import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qalb/Transition/CustomPageTransition.dart';
import 'package:qalb/data/data.dart';
import 'package:qalb/providers/DataProvider.dart';
import 'package:qalb/providers/SoundPlayerProvider.dart';
import 'package:qalb/screens/majlis_screens/majlis_text.dart';
import 'package:qalb/screens/sound_screen.dart/sound_player.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Majlis_Sound extends StatefulWidget {
  final String image;
  final String name;
  final String sub;
  final int index;
  final String audioPath;
  

  Majlis_Sound({
    super.key,
    required this.image,
    required this.index,
    required this.name,
    required this.sub,
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
bool _isImageVisible = false;
  @override
  void initState() {
    loadAudioPosition();
    Future.delayed(Duration(milliseconds: 000), () {
      setState(() {
        _isImageVisible = true;
      });
    });
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
    log("Saving position: ${position.inSeconds}");
    if (position.inSeconds > 0) {
      prefs.setInt("majlis${widget.index + 1}", position.inSeconds);
    }
  }

  Future<void> loadAudioPosition() async {
    final prefs = await SharedPreferences.getInstance();
    int? savedPosition = prefs.getInt("majlis${widget.index + 1}");
    log("Loaded position: ${savedPosition} for index ${widget.index + 1}");
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
          image: Provider.of<DataProvider>(context, listen: false)
              .majlisThumb[newIndex],
          index: newIndex,
          name: TextData.majlisUrdu[newIndex],
          sub: TextData.majlisUrdu[newIndex],
          audioPath: Provider.of<DataProvider>(context, listen: false)
              .majlisSound[newIndex],
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
                        AnimatedOpacity(
                         opacity: _isImageVisible ? 1.0 : 0.0,
                          duration: Duration(milliseconds: 800),
                          curve: Curves.easeInOut,
                          child:Container(
                          height: MediaQuery.of(context).size.height * 0.45,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: Platform.isIOS ? NetworkImage(widget.image,) : CachedNetworkImageProvider(widget.image),
                              fit: BoxFit.fitWidth,
                            ),
                            borderRadius: BorderRadiusDirectional.circular(5),
                          ),
                        ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          widget.name,
                          style: GoogleFonts.almarai(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          textDirection: TextDirection.rtl,
                          overflow: TextOverflow.ellipsis,
                          widget.sub,
                          style: GoogleFonts.almarai(
                            fontSize: 13,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 10),
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
                                        image: Provider.of<DataProvider>(
                                                context,
                                                listen: false)
                                            .majlisBookImages[widget.index],
                                        name: widget.name,
                                        file: Provider.of<DataProvider>(context,
                                                listen: false)
                                            .majlisText[widget.index],
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
                                      saveAudioPosition(
                                              soundPlayerProvider.position)
                                          .then((_) {
                                        soundPlayerProvider.stopAudio();
                                        navigateToMajlis(widget.index - 1);
                                      });
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
                                    'Download Qalb-E-Saleem App: https://play.google.com/store/apps/details?id=com.hizburehman.qalb_e_saleem&hl=en');
                              },
                              child: Image.asset(
                                "assets/images/share-grey.png",
                                width: 28,
                              ),
                            ),
                          ],
                        ),
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
      1: 853,
      2: 1046,
      3: 789,
      4: 1229,
      5: 1848,
      6: 1828,
      7: 856,
      8: 1029,
      9: 646,
      10: 968,
      11: 1240,
      12: 827,
      13: 1631,
      14: 932,
      15: 2331,
      16: 1296,
      17: 1608,
      18: 764,
      19: 782,
      20: 1975,
    };
    return duration[widget.index + 1] ?? 0;
  }
}
