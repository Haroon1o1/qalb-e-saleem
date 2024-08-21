import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qalb/data/data.dart';
import 'package:qalb/providers/DataProvider.dart';
import 'package:qalb/screens/majlis_sound/majlis_sound.dart';

class Majlis extends StatefulWidget {
  const Majlis({super.key});

  @override
  State<Majlis> createState() => _MajlisState();
}

class _MajlisState extends State<Majlis> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Provider.of<DataProvider>(context, listen: false).getMajlisImagesUrl();
    // Provider.of<DataProvider>(context, listen: false)
    //     .getMajlisThumbUrl();
  }

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
                        image: AssetImage("assets/images/majlis/upergrad.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0.0, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const SizedBox(height: 10),
                                Text(
                                  "فهرست مجالس",
                                  style: GoogleFonts.almarai(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "امام االولیاء حضرت پیر سّید محّمد عبد اهلل شاہ مشہدی قادری",
                                  style: GoogleFonts.almarai(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 20),
                            Image.asset("assets/images/back-arrow-white.png",
                                width: 25),
                          ],
                        ),
                        const SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              "assets/images/back-arrow-white.png",
                              width: 22,
                            ),
                          ],
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
              padding: const EdgeInsets.symmetric(vertical: 20),
              height: MediaQuery.of(context).size.height * 0.8,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: ListView.builder(
                itemCount: TextData.majlisUrdu.length,
                itemBuilder: (context, index) {
                  return majlisContainer(
                      "assets/images/majlis/${index + 1}.png", index);
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
            MaterialPageRoute(
              builder: (context) => Majlis_Sound(
                image: Provider.of<DataProvider>(context, listen: false)
                    .majlisThumb[index],
                index: index,
                name: TextData.majlisUrdu[index],
                sub: TextData.majlisEnglish[index],
              ),
            ));
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage("assets/images/box-with-shadow.png"),
            fit: BoxFit.cover,
          ),
        ),
        height: 240,
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
        margin:
            const EdgeInsets.only(top: 0), // Added margin for better spacing
        child: Column(
          children: [
            Container(
              height: 115,
              width: MediaQuery.of(context).size.width * 0.87,
              child: Image.asset(image, fit: BoxFit.fill),
            ),
            const SizedBox(height: 5), // Added spacing
            Container(
              height: 70,
              width: MediaQuery.of(context).size.width * 0.87,
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset(
                            "assets/images/clock.svg",
                            width: 15,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "10:23",
                            style: GoogleFonts.almarai(fontSize: 12),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.1,
                          ),
                          SizedBox(
                            width: 140,
                            child: Text(
                              textDirection: TextDirection.rtl,
                              overflow: TextOverflow.ellipsis,
                              TextData.majlisUrdu[index],
                              style: GoogleFonts.almarai(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        TextData.majlisEnglish[index],
                        style: GoogleFonts.almarai(fontSize: 10),
                      ),
                    ],
                  ),
                  const VerticalDivider(
                    color: Colors.black,
                    thickness: 0.5,
                    width: 10,
                    indent: 10,
                    endIndent: 10,
                  ),
                  Container(
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    width: 20,
                    height: 20,
                    child: Text(
                      "${index + 1}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "مجلس",
                    style: GoogleFonts.almarai(
                      fontSize: 13,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _loadImage(String image) async {}
}
