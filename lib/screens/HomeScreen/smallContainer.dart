import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qalb/Transition/CustomPageTransition.dart';
import 'package:qalb/screens/sound_screen.dart/sound_player.dart';

class SmallContainer extends StatefulWidget {
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
  _SmallContainerState createState() => _SmallContainerState();
}

class _SmallContainerState extends State<SmallContainer> with SingleTickerProviderStateMixin {
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
      begin: const Offset(0, 0.5), // Start off the bottom of the screen
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
                child: SoundPlayer(
                  image: widget.imagePath,
                  name: widget.text,
                  sub: widget.sub,
                ),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 70,
                height: 75,
                padding: EdgeInsets.only(bottom: 4),
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  color: widget.backgroundColor,
                  image: DecorationImage(image: AssetImage(widget.imagePath)),
                  borderRadius: BorderRadiusDirectional.circular(20),
                ),
              ),
              SizedBox(height: 5),
              Text(
                widget.text,
                style: GoogleFonts.almarai(
                  fontSize: 11,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
