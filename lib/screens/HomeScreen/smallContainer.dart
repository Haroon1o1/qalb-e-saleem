import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qalb/Transition/CustomPageTransition.dart';
import 'package:qalb/screens/sound_screen.dart/sound_player.dart';

class SmallContainer extends StatelessWidget {
  final Color backgroundColor;
  final String imagePath;
  final String text;
  final String sub;
  final String audioPath;

  SmallContainer({
    required this.backgroundColor,
    required this.imagePath,
    required this.text,
    required this.sub,
    required this.audioPath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CustomPageNavigation(
            child: SoundPlayer(
              image: imagePath,
              name: text,
              sub: sub,
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 70, height: 75,
            padding: EdgeInsets.only(bottom: 4),
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              color: backgroundColor,
              image: DecorationImage(image: AssetImage(imagePath)),
              borderRadius: BorderRadiusDirectional.circular(20),
            ),
            // Radius of the corners
          ),
          SizedBox(height: 5),
          Text(
            text,
            style: GoogleFonts.almarai(
              fontSize: 11,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
