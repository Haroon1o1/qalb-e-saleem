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
  final String tag;

  const LongBox({
    required this.imagePath,
    required this.mainText,
    required this.subText1,
    required this.subText2,
    required this.tag,
    required this.audioPath,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final String imageAddress = _getImageAddress(mainText);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CustomPageNavigation(
            child: imageAddress == "akwal"
                ?  AqwalWaIrshadaatScreen(isNavBar: false)
                : SoundPlayer(
                    tag: tag,
                    image: imageAddress,
                    name: mainText,
                    sub: subText2,
                  ),
          ),
        );
      },
      child: Hero(
        tag: tag,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          margin: const EdgeInsets.symmetric(vertical: 3),
          height: 120,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(height: 15),
                    _buildText(mainText, 18, FontWeight.bold),
                    _buildSubText(subText1),
                    _buildSubText(subText2),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Image.asset(
                imagePath,
                width: 92,
                height: 100,
                fit: BoxFit.fill,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildText(String text, double size, FontWeight fontWeight) {
    return Material(
      color: Colors.transparent,
      child: Text(
        text,
        textDirection: TextDirection.rtl,
        style: GoogleFonts.almarai(
          decoration: TextDecoration.none,
          fontWeight: fontWeight,
          fontSize: size,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildSubText(String text) {
    return Text(
      text,
      textDirection: TextDirection.rtl,
      style: GoogleFonts.almarai(
        decoration: TextDecoration.none,
        fontSize: 11,
        color: Colors.white,
      ),
      overflow: TextOverflow.clip,
    );
  }

  String _getImageAddress(String mainText) {
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
