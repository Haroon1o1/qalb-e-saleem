import 'dart:developer';

// import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class SoundPlayerProvider with ChangeNotifier {
  // final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  bool get isPlaying => _isPlaying;
  Duration get duration => _duration;
  Duration get position => _position;

  SoundPlayerProvider() {
  // _audioPlayer.onDurationChanged.listen((duration) {
//   _duration = duration;
//   log("Duration updated: $_duration");
//   notifyListeners();
// });


    // _audioPlayer.onPositionChanged.listen((position) {
    //   _position = position;
    //   notifyListeners();
    // });

    // _audioPlayer.onPlayerComplete.listen((_) {
    //   _isPlaying = false;
    //   _position = Duration.zero;
    //   notifyListeners();
    // });
  }

  void togglePlayStop(String audioPath) async {
    log("${audioPath}--------------");
    if (_isPlaying) {
      // await _audioPlayer.pause();
      _isPlaying = false;
    } else {
      try {
        // await _audioPlayer.play(UrlSource(audioPath));
        _isPlaying = true;
      } catch (e) {
        print('Error playing audio: $e');
      }
    }
    notifyListeners();
  }

  void seekAudio(double value) async {
    final position = Duration(seconds: value.toInt());
    // await _audioPlayer.seek(position);
    _position = position;
    notifyListeners();
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  void dispose() {
    // _audioPlayer.dispose();
    super.dispose();
  }
}
