import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qalb/Transition/CustomPageTransition.dart';
import 'package:qalb/screens/Shaja_screens/Shajr_e_Qadria.dart';
import 'package:qalb/screens/sound_screen.dart/sound_player.dart';


class Shajra extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      width: double.infinity,
      height: 490,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/upergrad.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildHeaderText("شجرٔہ قادریہ", 25),
          SizedBox(height: 15),
          _buildSubHeaderText(
            "امام االولیاء حضرت پیر سّید محمد عبد الله شاہ مشہدی قادری رحمة الله تعالى عليه",
            13,
          ),
          SizedBox(height: 20),
          _buildImageRow(context),
          SizedBox(height: 10),
          _buildTextRow(context, "شجرٔہ قادریہ نسبیہ", "nasbiya", "شجرٔہ قادریہ حسبیہ", "hasbiya"),
          SizedBox(height: 10),
          _buildSoundRow(context),
        ],
      ),
    );
  }

  Widget _buildHeaderText(String text, double fontSize) {
    return Text(
      text,
      style: GoogleFonts.almarai(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget _buildSubHeaderText(String text, double fontSize) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: GoogleFonts.almarai(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildImageRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildImageContainer(
          context,
          "assets/images/shajra_nasbia.png",
          "nasbiya",
          false,
        ),
        _buildImageContainer(
          context,
          "assets/new_images/shajra-hasbia.png",
          "hasbiya",
          false,
        ),
      ],
    );
  }

  Widget _buildImageContainer(BuildContext context, String imagePath, String text, bool isNavBar) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CustomPageNavigation(
            child: ShajrEQadriaScreen(text: text, isNavBar: isNavBar),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Image.asset(
          imagePath,
          width: MediaQuery.of(context).size.width * 0.46,
          height: 110.0,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildTextRow(BuildContext context, String leftText, String leftNavText, String rightText, String rightNavText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildTextContainer(context, leftText, leftNavText),
        _buildTextContainer(context, rightText, rightNavText),
      ],
    );
  }

  Widget _buildTextContainer(BuildContext context, String text, String navText) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CustomPageNavigation(child: ShajrEQadriaScreen(text: navText, isNavBar: false)),
        );
      },
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * 0.46,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(20),
          color: Color(0xFF2B3491),
        ),
        child: Text(
          text,
          style: GoogleFonts.almarai(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildSoundRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildSoundContainer(
          context,
          "شجرٔہ قادریہ نسبیہ",
          "منظوم مع تضمین",
          "assets/images/nasbi.png",
          "sajra-nasbi",
        ),
        _buildSoundContainer(
          context,
          "شجرٔہ قادریہ حسبیہ",
          "منظوم مع تضمین",
          "assets/images/shajra_hasbia.png",
          "sajra",
        ),
      ],
    );
  }

  Widget _buildSoundContainer(BuildContext context, String name, String sub, String image, String tag) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CustomPageNavigation(
            child: SoundPlayer(image: image, name: name, sub: sub, tag: tag),
          ),
        );
      },
      child: Hero(
        tag: tag,
        child: Container(
          height: 80,
          width: MediaQuery.of(context).size.width * 0.46,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(20),
            border: Border.all(color: Colors.white),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                name,
                style: GoogleFonts.almarai(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                sub,
                textDirection: TextDirection.rtl,
                style: GoogleFonts.almarai(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
