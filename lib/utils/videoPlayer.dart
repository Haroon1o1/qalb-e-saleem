import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:provider/provider.dart';
import 'package:qalb/providers/DataProvider.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart'; // For controlling orientation

class FullScreenVideoPlayer extends StatefulWidget {
  @override
  _FullScreenVideoPlayerState createState() => _FullScreenVideoPlayerState();
}

class _FullScreenVideoPlayerState extends State<FullScreenVideoPlayer> {
  ChewieController? _chewieController;
  VideoPlayerController? _videoPlayerController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<DataProvider>(context, listen: false);
      provider.getVideo(); // Fetch video URL
    });

    // Lock orientation to landscape
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  Future<void> _initializeVideo(String videoUrl) async {
    try {
      // Use flutter_cache_manager to download and cache the video
      final file = await DefaultCacheManager().getSingleFile(videoUrl);
      _videoPlayerController = VideoPlayerController.file(file);

      await _videoPlayerController!.initialize();

      setState(() {
        _chewieController = ChewieController(
          videoPlayerController: _videoPlayerController!,
          autoPlay: true,
          looping: false,
          aspectRatio: 16 / 9,
          fullScreenByDefault: true,
        );
        _isLoading = false;
      });
    } catch (e) {
      // Handle video initialization error
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load video: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, provider, child) {
        final videoUrl = provider.video;

        if (videoUrl.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_isLoading) {
          _initializeVideo(videoUrl);
        }

        return Scaffold(
          body: Stack(
            children: [
              _chewieController != null &&
                      _chewieController!.videoPlayerController.value.isInitialized
                  ? Chewie(controller: _chewieController!)
                  : const Center(child: CircularProgressIndicator()),
              Positioned(
                top: 20,
                left: 20,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
       
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    // Dispose of both Chewie and VideoPlayerController
    _chewieController?.dispose();
    _videoPlayerController?.dispose();
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}
