import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TimelineStep extends StatelessWidget {
  final int stepNumber;
  final String? imagePath;
  final String description;
  final String name;

  const TimelineStep({
    Key? key,
    required this.stepNumber,
    required this.description,
    required this.imagePath,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor:
                stepNumber == 1 ? Colors.white : Colors.grey.shade500,
            child: Text(
              stepNumber.toString(),
              style: TextStyle(
                  color: stepNumber == 1 ? Colors.black : Colors.white),
            ),
          ),
          if (stepNumber != 28) // idr last +1 step dalna h
            Container(
                height: 20,
                width: 2,
                color: stepNumber == 1 ? Colors.white : Colors.grey.shade500),
          Container(
            width: double.infinity,
            height: imagePath == "" ? 70 : 180,
            padding: EdgeInsets.only(
                top: imagePath == "" ? 0 : 8,
                right: 8,
                left: 8,
                bottom: imagePath == "" ? 0 : 15),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
                border: imagePath == ""
                    ? Border.all(color: Colors.transparent)
                    : Border.all(color: Colors.transparent),
                color: imagePath == ""
                    ? getRandomColor().withOpacity(0.5)
                    : Colors.white,
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: imagePath == ""
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadiusDirectional.circular(10),
                  child: imagePath == ""
                      ? Container()
                      : imagePath == "" 
    ? Container() 
    : Image.network(
        imagePath!,
        fit: BoxFit.cover,
      ),

                ),

                Text(
                  description,
                  style: GoogleFonts.almarai(
                    color: imagePath == "" ? Colors.white : Colors.black,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                // SizedBox(height: 30),
              ],
            ),
          ),
            Container(
              height: 20,
              width: 2,
              color: name == "nasbiya" ? stepNumber == 37 ? Colors.transparent : Colors.grey.shade500 : stepNumber == 43 ? Colors.transparent : Colors.grey.shade500,
            ),
        ]
      ),
    );
  }

  Color getRandomColor() {
    Random random = Random();
    // Generating random RGB values
    int red = random.nextInt(200); // 0 to 255
    int green = random.nextInt(150); // 0 to 255
    int blue = random.nextInt(24); // 0 to 255

    return Color.fromRGBO(
        red, green, blue, 1.0); // Opacity set to 1.0 (fully opaque)
  }
}
