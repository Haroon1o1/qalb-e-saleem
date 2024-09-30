import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UpperContainer extends StatefulWidget {
  const UpperContainer({super.key});

  @override
  State<UpperContainer> createState() => _UpperContainerState();
}

class _UpperContainerState extends State<UpperContainer> with SingleTickerProviderStateMixin {
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
      begin: const Offset(0, 1), // Start off the screen below
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
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.32,
          margin: EdgeInsets.only(top: 30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadiusDirectional.circular(20),
            image: DecorationImage(
              image: AssetImage("assets/images/darbar.png"),
              fit: BoxFit.cover, // Ensures the image covers the entire container
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 20),
              Text(
                "فهرست مجالس",
                style: GoogleFonts.almarai(
                   decoration: TextDecoration.none,
                  fontSize: 18,
                  color: Color(0xFF02DBC6),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Text(
                textAlign: TextAlign.center,
                "امام االولیاء حضرت پیر سّید محّمد عبد اللہ شاہ مشہدی قادری",
                style: GoogleFonts.almarai(
                   decoration: TextDecoration.none,
                  fontSize: 10,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                
                "رحمة الله تعالى عليه",
                style: GoogleFonts.almarai(
                   decoration: TextDecoration.none,
                  fontSize: 10,
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
