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
              audioPath: audioPath,
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0), // Radius of the corners
            child: Image.asset(
              imagePath, // Replace with your image asset
              width: 70.0, // Set the desired width
              height: 70.0, // Set the desired height
              fit: BoxFit.fill, // Ensures the image covers the entire area
            ),
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
