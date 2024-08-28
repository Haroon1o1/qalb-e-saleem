import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qalb/Transition/CustomPageTransition.dart';
import 'package:qalb/data/data.dart';
import 'package:qalb/providers/DataProvider.dart';
import 'package:qalb/providers/SoundPlayerProvider.dart';
import 'package:qalb/screens/majlis_sound/majlis_sound.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Majlis extends StatefulWidget {
  const Majlis({super.key});

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
                                fontSize: MediaQuery.of(context).size.width * 0.05,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "امام االولیاء حضرت پیر سّید محّمد عبد اهلل شاہ مشہدی قادری",
                              style: GoogleFonts.almarai(
                                color: Colors.white,
                                fontSize: MediaQuery.of(context).size.width * 0.025,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width:15),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Image.asset("assets/images/back-arrow-white.png", width: 25),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.21,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.02,
                horizontal: 0,
              ),
              height: MediaQuery.of(context).size.height * 0.8,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: ListView.builder(
                itemCount: Provider.of<DataProvider>(context, listen: false).majlisImages.length,
                itemBuilder: (context, index) {
                  return majlisContainer(
                    Provider.of<DataProvider>(context, listen: false).majlisImages[index],
                    index,
                  );
                },
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
            image: Provider.of<DataProvider>(context, listen: false).majlisThumb[index],
            index: index,
            name: TextData.majlisUrdu[index],
            sub: TextData.majlisEnglish[index],
            audioPath: Provider.of<DataProvider>(context, listen: false).majlisSound[index],
          ),
        ),
      );
    },
    child: Container(
      margin: EdgeInsets.only(bottom: 30, left: 15, right: 15),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
        borderRadius: BorderRadiusDirectional.circular(15),
      ),
      height: 210,
      child: Column(
        children: [
          CachedNetworkImage(
            imageUrl: image,
            height: 130,
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
                      Image.asset("assets/images/clock-white.png", color: Colors.black, height: 12),
                      const SizedBox(width: 4),
                      FutureBuilder<String?>(
                        future: getAudioDuration(Provider.of<DataProvider>(context, listen: false).majlisSound[index]),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Text(
                              '10:23',
                              style: GoogleFonts.almarai(fontSize: 12),
                            );
                          } else if (snapshot.hasError) {
                            return Container();
                          } else if (snapshot.hasData) {
                            final durationText = snapshot.data ?? '10:23';
                            return Text(
                              durationText,
                              style: GoogleFonts.almarai(fontSize: 12),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 17),
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
                  SizedBox(height: 8),
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
                children: [
                   VerticalDivider(
                    color: Colors.black,
                    thickness: 0.5,
                    width: 0,
                    indent: 0,
                    endIndent: 0,
                                     ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                  Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.only(top: 5),
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

  Future<String?> getAudioDuration(String url) async {
    final player = AudioPlayer();
    try {
      await player.setSourceUrl(url);
      Duration? d = await player.getDuration();
      return Provider.of<SoundPlayerProvider>(context, listen: false).formatDuration(d!);
    } catch (e) {
      print('Error loading audio: $e');
      return null;
    } finally {
      await player.dispose();
    }
  }
}
