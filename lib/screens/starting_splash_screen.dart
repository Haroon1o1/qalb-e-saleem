import 'package:flutter/material.dart';
import 'package:qalb/getAllData.dart';
import 'package:qalb/screens/HomeScreen/HomeScreen.dart';

class SplashScreen2 extends StatefulWidget {
  const SplashScreen2({super.key});

  @override
  State<SplashScreen2> createState() => _SplashScreen2State();
}

class _SplashScreen2State extends State<SplashScreen2> {
  @override
  void initState() {
    GetAllData.getData(context);
    super.initState();

    // Navigate to the next screen after a delay (e.g., 3 seconds)
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (_) => BottomBarscreen()), // Replace with your next screen
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Image.asset(
          'assets/video.gif', // Path to your .gif file
          fit: BoxFit.fill, // This ensures the GIF covers the whole screen
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}
