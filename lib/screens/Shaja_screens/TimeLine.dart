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
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
         // idr last +1 step dalna h
            Container(
                height: 20,
                width: 2,
                color: stepNumber == 1 ? Colors.white : Colors.grey.shade500),
          Container(
            width: double.infinity,
            // height: imagePath == ""
            //     ? 60
            //     :  name == "nasbiya" && stepNumber == 2  ?  190 : stepNumber == 3 ? 185 : 180,
            padding: EdgeInsets.all(
                8),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(1, 2),
                  ),
                ],
                border: imagePath == ""
                    ? Border.all(color: Colors.transparent)
                    : Border.all(color: Colors.transparent),
                color: imagePath == ""
                    ? getColorForStep(stepNumber)
                    : Colors.white,
                borderRadius: BorderRadius.circular(11)),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    children: [
                      SizedBox(height:5),
                      Text(
                        description,
                        style: GoogleFonts.almarai(
                          color: imagePath == "" ? Colors.white : Colors.black,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      name == "hasbiya"
                          ? Text(
                              stepNumber == 1
                                  ? "صلی الله عليه وآله وسلم"
                                  : stepNumber == 2
                                      ? "کّرم الله تعالى وجہہ الکریم"
                                      : stepNumber == 3
                                          ? ""
                                          : (stepNumber > 3 && stepNumber <= 8)
                                              ? "رضي الله تعالى عنه"
                                              : "رحمة الله تعالى عليه",
                              style: GoogleFonts.almarai(
                                color: imagePath == ""
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            )
                          : Text(
                              stepNumber == 1
                                  ? ''
                                  : stepNumber == 2
                                      ? "کّرم الله تعالى وجہہ الکریم"
                                      : stepNumber == 3
                                          ? ""
                                          : (stepNumber > 3 && stepNumber <= 7)
                                              ? "رضي الله تعالى عنه"
                                              : "رحمة الله تعالى عليه",
                              style: GoogleFonts.almarai(
                                color: imagePath == ""
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                    ],
                  ),
                ),
                // SizedBox(height: 30),
              ],
            ),
          ),
          Container(
            height: 20,
            width: 2,
            color: name == "nasbiya"
                ? stepNumber == 37
                    ? Colors.transparent
                    : Colors.grey.shade500
                : stepNumber == 43
                    ? Colors.transparent
                    : Colors.grey.shade500,
          ),
        ],
      ),
    );
  }

  Color getColorForStep(int stepNumber) {
    List<Color> colorList = [];

    List<int> ignoredSteps = [];
    if (name == "hasbiya") {
      colorList.addAll([
        Color(0xFF2ECDBA),
        Color(0xFF6BADE3),
        Color(0xFFB8A5E3),
        Color(0xFF48C6E3),
        Color(0xFFFF9C7E),
        Color(0xFFA8CF84),
        Color(0xFF8B939B),
        Color(0xFF699F98),
        Color(0xFF6FA7DF),
        Color(0xFF728DE3),
        Color(0xFF9C8AE3),
        Color(0xFFF0B378),
        Color(0xFFEC9085),
      ]);
      ignoredSteps.addAll([1, 2, 3, 17, 42, 43]);
    } else {
      colorList.addAll([
        Color(0xFF2ECDBA),
        Color(0xFF6BADE3),
        Color(0xFFB8A5E3),
        Color(0xFF48C6E3),
        Color(0xFFFF9C7E),
        Color(0xFFA8CF84),
        Color(0xFF8B939B),
        Color(0xFF699F98),
        Color(0xFF6FA7DF),
        Color(0xFF728DE3),
        Color(0xFF9C8AE3),
        Color(0xFFF0B378),
        Color(0xFFEC9085),
      ]);
      if (stepNumber > 23) {
        // colorList.add(Color(0xFFED7B92));
      }

      ignoredSteps.addAll([1, 2, 3, 37]);
    }

    if (name == "hasbiya" && ignoredSteps.contains(stepNumber)) {
      return Colors.transparent;
    }

    int nonIgnoredStepIndex =
        stepNumber - ignoredSteps.where((step) => step < stepNumber).length;

    int startingIndex = name == "nasbiya" ? 4 : 0;

    // Calculate the color index considering the starting index
    int colorIndex = (nonIgnoredStepIndex + startingIndex) % colorList.length;

    if (colorIndex == 0) {
      colorIndex = colorList.length;
    }

    return colorList[colorIndex - 1]; // Adjust for 0-based index
  }
}
