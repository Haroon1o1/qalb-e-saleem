import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class FullScreenVideoPlayer extends StatefulWidget {
  FullScreenVideoPlayer({super.key});

  @override
  _FullScreenVideoPlayerState createState() => _FullScreenVideoPlayerState();
}

class _FullScreenVideoPlayerState extends State<FullScreenVideoPlayer> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: )
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    debugPrint("Initializing video player...");

    // Initialize VideoPlayerController with network URL
    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(
          "https://firebasestorage.googleapis.com/v0/b/qalb-e-saleem-c7987.appspot.com/o/home_page_video.mp4?alt=media&token=e583405d-179d-4be6-a00d-6947d640a320"))
      ..initialize().then((_) {
        if (_videoPlayerController.value.isInitialized) {
          debugPrint("Video player initialized successfully.");
          setState(() {
            _chewieController = ChewieController(
              videoPlayerController: _videoPlayerController,
              autoPlay: true,
              looping: true,
              aspectRatio: _videoPlayerController.value.aspectRatio,
              fullScreenByDefault: true,
            );
          });
        } else {
          debugPrint("Video player initialization failed.");
        }
      }).catchError((error) {
        debugPrint("Error initializing video player: $error");
      });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    debugPrint("Disposing video player...");
    _videoPlayerController.dispose();
    _chewieController?.dispose();

    // Reset orientation to portrait when leaving full screen
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Lock orientation to landscape when video player is displayed
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
    statusBarColor: Colors.black, // Make status bar transparent
    statusBarIconBrightness: Brightness.dark,
  ));

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
       
      ),
      body: _chewieController != null &&
              _chewieController!.videoPlayerController.value.isInitialized
          ? Center(
            child: FittedBox(
              fit:BoxFit.cover,
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                  child: Chewie(
                    controller: _chewieController!,
                  ),
                ),
            ),
          )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 10),
                  Text(
                    _videoPlayerController.value.hasError
                        ? "Error loading video."
                        : "Loading video...",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
    );
  }
}
