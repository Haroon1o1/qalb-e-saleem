import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qalb/Transition/CustomPageTransition.dart';
import 'package:qalb/screens/aqwal_wa_irshadaat/aqwal_wa_irshadaat.dart';
import 'package:qalb/screens/sound_screen.dart/sound_player.dart';

class LongBox extends StatefulWidget {
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
  _LongBoxState createState() => _LongBoxState();
}

class _LongBoxState extends State<LongBox> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..forward(); // Start animation automatically

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5), // Start from the bottom
      end: Offset.zero, // End at its final position
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0, // Start fully transparent
      end: 1.0, // End fully opaque
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              CustomPageNavigation(
                child: getImageAddress() == "akwal"
                    ? AqwalWaIrshadaatScreen(
                        isNavBar: false,
                      )
                    : SoundPlayer(
                      tag: widget.tag,
                        image: getImageAddress(),
                        name: widget.mainText,
                        sub: widget.subText2,
                      ),
              ),
            );
          },
          child: Hero(
            tag:widget.tag,
            child: Container(
              padding: const EdgeInsets.only(
                right: 8,
                left: 8,
              ),
              margin: const EdgeInsets.symmetric(vertical: 3),
              height: 120,
              decoration: BoxDecoration(
                color: widget.backgroundColor,
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
                        SizedBox(height: 15),
                        Material(
  color: Colors.transparent,  // Make it transparent or choose your preferred color
  child: Text(
    
    widget.mainText,  // The text you want to display
    textDirection: TextDirection.rtl,  // Right-to-left direction
    style: GoogleFonts.almarai(
      decoration: TextDecoration.none,
      fontWeight: FontWeight.bold,
      fontSize: 18,
      color: Colors.white,
    ),
  ),
),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(

                              widget.subText1,
                              textDirection: TextDirection.rtl,
                              style: GoogleFonts.almarai(
                                decoration: TextDecoration.none,
                                fontSize: 11,
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.clip,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              widget.subText2,
                              textDirection: TextDirection.rtl,
                              style: GoogleFonts.almarai(
                                decoration: TextDecoration.none,
                                fontSize: 11,
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.clip,
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Image.asset(
                    widget.imagePath,
                    width: 92,
                    height: 100,
                    fit: BoxFit.fill,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String getImageAddress() {
    switch (widget.mainText) {
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
