import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qalb/providers/DataProvider.dart';
import 'package:video_player/video_player.dart';

class FullScreenVideoPlayer extends StatefulWidget {
  @override
  _FullScreenVideoPlayerState createState() => _FullScreenVideoPlayerState();
}

class _FullScreenVideoPlayerState extends State<FullScreenVideoPlayer> {
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    // Fetch video URL when widget is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<DataProvider>(context, listen: false);
      provider.getVideo(); // Fetch video URL
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, provider, child) {
        final videoUrl = provider.video;

        if (videoUrl.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }

        if (_chewieController == null) {
          _chewieController = ChewieController(
            videoPlayerController: VideoPlayerController.network(videoUrl),
            autoPlay: true,
            looping: false,
            aspectRatio: 16 / 9,
            fullScreenByDefault: true,
          );
        }

        return Scaffold(
          body: _chewieController != null &&
                  _chewieController!.videoPlayerController.value.isInitialized
              ? Chewie(controller: _chewieController!)
              : Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    super.dispose();
  }
}
