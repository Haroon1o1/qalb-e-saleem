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

  LongBox({
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
        if (getImageAddress() == "akwal") {
          Navigator.push(
            context,
            CustomPageNavigation(child: AqwalWaIrshadaatScreen()),
          );
        } else {
          Navigator.push(
            context,
            CustomPageNavigation(
              child: SoundPlayer(
                image: getImageAddress(),
                name: mainText,
                sub: subText2,
              ),
            ),
          );
        }
      },
      child: Container(
        
        padding: const EdgeInsets.only(right: 10.0),
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        height: 120,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/new_images/long_container.png"),fit: BoxFit.fill, colorFilter: ColorFilter.mode(
        backgroundColor, // Adjust opacity as needed
        BlendMode.srcATop, // Choose the blend mode that works best
      ),),
            borderRadius: BorderRadiusDirectional.circular(15)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height:20),
                Text(
                  mainText,
                  style: GoogleFonts.almarai(
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                      color: Colors.white),
                ),
                SizedBox(height: 15),
                SizedBox(
                  width: 200,
                  child: Text(
                    overflow: TextOverflow.clip,
                    subText1,
                    textDirection: TextDirection.rtl,
                    style:
                        GoogleFonts.almarai(fontSize: 9, color: Colors.white),
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: Text(
                    overflow: TextOverflow.clip,
                    subText2,
                    textDirection: TextDirection.rtl,
                    style:
                        GoogleFonts.almarai(fontSize: 10, color: Colors.white),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
            SizedBox(width: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.asset(
                imagePath,
                width: 85.0,
                height: 85.0,
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getImageAddress() {
    if (mainText == "سوانح حیات") {
      return "assets/images/sawane-dark.png";
    } else if (mainText == 'قلبِ سلیم') {
      return "assets/images/qalb_e_saleem-dark.png";
    } else if (mainText == 'الفراق') {
      return "assets/images/alfiraq-dark.png";
    } else {
      return "akwal";
    }
  }
}
