import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:qalb/providers/HomeProvider.dart';
import 'package:qalb/utils/firebase_options.dart';
import 'package:qalb/providers/DataProvider.dart';
import 'package:qalb/providers/SoundPlayerProvider.dart';
import 'package:qalb/screens/Splash_screen/starting_splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
await FastCachedImageConfig.init(clearCacheAfter: const Duration(days: 15));

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness:
            Brightness.light,
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Splashscreen(),
    );
  }
}
