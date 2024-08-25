
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qalb/providers/DataProvider.dart';
import 'package:qalb/providers/SoundPlayerProvider.dart';
import 'package:qalb/screens/majlis_sound/majlis_text.dart';
import 'package:qalb/screens/sound_screen.dart/sound_player.dart';

// ignore: must_be_immutable
class Majlis_Sound extends StatefulWidget {
  String image;
  String name;
  String sub;
  int index;
  String audioPath;
   Majlis_Sound({super.key, required this.image, required this.index, required this.name, required this.sub, required this.audioPath});

  @override
  State<Majlis_Sound> createState() => _Majlis_SoundState();
}

class _Majlis_SoundState extends State<Majlis_Sound> {


    double position = 0.0;



 @override
  Widget build(BuildContext context) {
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                                        alignment: Alignment.center,
                                        decoration:  BoxDecoration(
                    color: Colors.grey[500],
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
                                      SizedBox(width: 5,),
                            Text("مجلس",
                                style: GoogleFonts.almarai(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[500])),
                          ],
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Image.asset(
                                "assets/images/back-arrow-grey.png",
                                width: 25)),
                      ],
                    ),
                    SizedBox(height: 50),
                    Hero(
                      tag: "image",
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.network(
                          widget.image,
                          width: double.infinity,
                          height: 320.0,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      widget.name,
                      style: GoogleFonts.almarai(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      textDirection: TextDirection.rtl,
                      overflow: TextOverflow.ellipsis,
                      widget.sub,
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
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => Majlis_Text(audioPath: widget.audioPath,image: widget.image, name: widget.name,file:Provider.of<DataProvider>(context, listen: false).majlisText[widget.index]),));

                            },
                            child: Image.asset(
                              "assets/images/read.png",
                              width: 35,
                            )),
                        GestureDetector(
                          onTap: () =>
                              soundPlayerProvider.togglePlayStop(widget.audioPath),
                          child: Image.asset(
                            soundPlayerProvider.isPlaying
                                ? "assets/images/pause.png"
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