import 'package:flutter/material.dart';
import 'package:qalb/screens/HomeScreen/HomeScreen.dart';
import 'package:qalb/screens/HomeScreen/widgets/bottomNavBar.dart';
import 'package:qalb/utils/getAllData.dart';
import 'package:video_player/video_player.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen>
    with SingleTickerProviderStateMixin {

  late VideoPlayerController _controller;

  @override
  void initState() {
    GetAllData.getData(context);
    super.initState();
    _controller = VideoPlayerController.asset(
      
      'assets/splash.mp4', // Replace with your video URL
    )
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized
        setState(() {});
      })
      ..setLooping(false)..setPlaybackSpeed(1)  // Loop the video
      ..play();      
      Future.delayed(const Duration(milliseconds: 5000), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => BottomNavBarScreen()),
      );
    });     
  }

  @override
  void dispose() {
    _controller.dispose();  // Clean up the controller when the widget is disposed
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        
        height: MediaQuery.of(context).size.height,
        
        child: AspectRatio(
          aspectRatio: 9/16,
          
          
          child: VideoPlayer(_controller)),
          )
    );
  }
}