import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qalb/Transition/CustomPageTransition.dart';
import 'package:qalb/data/data.dart';
import 'package:qalb/providers/DataProvider.dart';
import 'package:qalb/providers/SoundPlayerProvider.dart';
import 'package:qalb/screens/majlis_screens/majlis_sound.dart';

class Majlis extends StatefulWidget {
  bool isNavBar;
  Majlis({super.key, required this.isNavBar});

  @override
  State<Majlis> createState() => _MajlisState();
}

class _MajlisState extends State<Majlis> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.26,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/upergrad.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.05,
                      vertical: MediaQuery.of(context).size.height * 0.03,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "فهرست مجالس",
                              style: GoogleFonts.almarai(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "امام االولیاء حضرت پیر سّید محّمد عبد اللہ شاہ مشہدی قادری",
                              style: GoogleFonts.almarai(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.025,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 15),
                        Visibility(
                          visible: widget.isNavBar ? false : true,
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Image.asset(
                              "assets/images/back-arrow-white.png",
                              width: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.19,
            left: 0,
            right: 0,
            bottom:
                0, // Ensure the content does not overflow outside the container
            child: Container(
              padding: EdgeInsets.only(top: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  itemCount: Provider.of<DataProvider>(context, listen: false)
                      .majlisBookImages
                      .length,
                  itemBuilder: (context, index) {
                    return majlisContainer(
                      Provider.of<DataProvider>(context, listen: false)
                          .majlisImages[index],
                      index,
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget majlisContainer(String image, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CustomPageNavigation(
            child: Majlis_Sound(
              image: Provider.of<DataProvider>(context, listen: false)
                  .majlisThumb[index],
              index: index,
              name: TextData.majlisUrdu[index],
              sub: TextData.majlisEnglish[index],
              audioPath: Provider.of<DataProvider>(context, listen: false)
                  .majlisSound[index],
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 30, left: 15, right: 15),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
          borderRadius: BorderRadius.circular(15),
        ),
        height: 230,
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: image,
              height: 150,
              width: MediaQuery.of(context).size.width * 0.87,
              fit: BoxFit.fill,
              placeholder: (context, url) => Container(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          "assets/images/clock-white.png",
                          color: Colors.black,
                          height: 12,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          formatDuration(getDuration(index + 1)),
                          style: GoogleFonts.almarai(fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(height: 17),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 170,
                      child: Text(
                        textDirection: TextDirection.rtl,
                        overflow: TextOverflow.ellipsis,
                        TextData.majlisUrdu[index],
                        style: GoogleFonts.almarai(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: 170,
                      child: Text(
                        textAlign: TextAlign.end,
                        textDirection: TextDirection.ltr,
                        overflow: TextOverflow.ellipsis,
                        TextData.majlisEnglish[index],
                        style: GoogleFonts.almarai(
                          fontSize: 9,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 30,
                      child: const VerticalDivider(
                        color: Colors.black,
                        thickness: 1,
                        width: 0,
                        indent: 0,
                        endIndent: 0,
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                    Container(
                      padding: const EdgeInsets.all(5),
                      // margin: const EdgeInsets.only(top: 5),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        "${index + 1}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "مجلس",
                      style: GoogleFonts.almarai(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String formatDuration(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$remainingSeconds';
  }

  int getDuration(int index) {
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
    return duration[index] ?? 0;
  }

  Future<String?> getAudioDuration(String url) async {
    final player = AudioPlayer();
    try {
      await player.setSourceUrl(url);
      Duration? d = await player.getDuration();
      return Provider.of<SoundPlayerProvider>(context, listen: false)
          .formatDuration(d!);
    } catch (e) {
      print('Error loading audio: $e');
      return null;
    } finally {
      await player.dispose();
    }
  }
}
