import 'package:flutter/material.dart';
import 'package:qalb/screens/HomeScreen/HomeScreen.dart';
import 'package:qalb/utils/getAllData.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen>
    with SingleTickerProviderStateMixin {

  void initState() {
    super.initState();

   
    Future.delayed(const Duration(seconds: 8), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => BottomNavBarScreen()),
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    GetAllData.getData(context);
    return Scaffold(
      body: Container(
        
        height: MediaQuery.of(context).size.height,
        
        child: Image.asset("assets/splash.gif", fit:BoxFit.fill))
    );
  }
}