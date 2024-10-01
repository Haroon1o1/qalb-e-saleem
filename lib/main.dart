import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qalb/providers/HomeProvider.dart';
import 'package:qalb/utils/firebase_options.dart';
import 'package:qalb/providers/DataProvider.dart';
import 'package:qalb/providers/SoundPlayerProvider.dart';
import 'package:qalb/screens/Splash_screen/starting_splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  } catch (e) {
    print('Initialization error: $e');
  }

  // Hide the status bar

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DataProvider()),
        ChangeNotifierProvider(create: (context) => SoundPlayerProvider()),
        ChangeNotifierProvider(create: (context) => HomeNavBarProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget{
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Qalb-e-Saleem',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      
      home: Scaffold(
        body: Splashscreen(),
      ),
    );
  }
}
