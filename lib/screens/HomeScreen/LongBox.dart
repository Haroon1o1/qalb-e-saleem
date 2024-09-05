import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qalb/Transition/CustomPageTransition.dart';
import 'package:qalb/screens/aqwal_wa_irshadaat/aqwal_wa_irshadaat.dart';
import 'package:qalb/screens/sound_screen.dart/sound_player.dart';

class LongBox extends StatelessWidget {
  final String imagePath;
  final String mainText;
  final String subText1;
  final String subText2;
  final String audioPath;
  final Color backgroundColor;

  const LongBox({
    required this.imagePath,
    required this.mainText,
    required this.subText1,
    required this.subText2,
    required this.audioPath,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CustomPageNavigation(
            child: getImageAddress() == "akwal"
                ? AqwalWaIrshadaatScreen(isNavBar: false,)
                : SoundPlayer(
                    image: getImageAddress(),
                    name: mainText,
                    sub: subText2,
                  ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.only(
          right: 08,
          left: 8,
        ),
        margin: const EdgeInsets.symmetric( vertical: 3),
        height: 120,
        decoration: BoxDecoration(
          color: backgroundColor,
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey.withOpacity(0.5),
          //     spreadRadius: 1,
          //     blurRadius: 3,
          //     offset: const Offset(1, 2),
          //   ),
          // ],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: 15),
                  Text(
                    textDirection: TextDirection.rtl,
                    mainText,
                    style: GoogleFonts.almarai(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                    subText1,
                    textDirection: TextDirection.rtl,
                    style: GoogleFonts.almarai(
                      fontSize: 9,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.clip,
                  ),
                  const SizedBox(height: 02),
                  Text(
                    subText2,
                    textDirection: TextDirection.rtl,
                    style: GoogleFonts.almarai(
                      fontSize: 9,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.clip,
                  ),
                  SizedBox(height:20),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(width: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(0),
              child: Image.asset(
                imagePath,
                width: 105,
                height: 105,
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getImageAddress() {
    switch (mainText) {
      case "سوانح حیات":
        return "assets/images/sawane-dark.png";
      case 'قلبِ سلیم':
        return "assets/images/qalb_e_saleem-dark.png";
      case 'الفراق':
        return "assets/images/alfiraq-dark.png";
      default:
        return "akwal";
    }
  }
}
