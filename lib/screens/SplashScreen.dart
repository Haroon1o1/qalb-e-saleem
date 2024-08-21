import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qalb/getAllData.dart';
import 'package:qalb/screens/HomeScreen/HomeScreen.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> slideAnimationImage;
  late Animation<Offset> slideAnimationText;
  late Animation<double> fadeAnimation;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    slideAnimationImage = Tween<Offset>(
      begin: const Offset(0, -0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
    slideAnimationText = Tween<Offset>(
      begin: const Offset(0, 3),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));

    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (_) =>
                Homescreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    GetAllData.getData(context);
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height*0.2),
                FadeTransition(
                  opacity: fadeAnimation,
                  child: SlideTransition(
                    position: slideAnimationImage,
                    child: Container(
                      height:180,width:180,decoration: BoxDecoration(
                        
                        image: DecorationImage(image: AssetImage("assets/images/logo.jpg"),),borderRadius: BorderRadiusDirectional.circular(20)),
                    ),
                  ),
                ),
                const SizedBox(height: 100),
                FadeTransition(
                  opacity: fadeAnimation,
                  child: SlideTransition(
                    position: slideAnimationText,
                    child: Column(
                      children: [
                         Text(
                          'فهرست مجالس',
                          style: GoogleFonts.almarai(
                            fontSize: 12,
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                          ),
                         ),
                         Text(
                          'امام االولیاء حضرت پیر سّید محّمد عبد اهلل شاہ مشہدی قادری',
                          style: GoogleFonts.almarai(
                            fontSize: 12,
                            color: Colors.blueAccent,
                            
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
