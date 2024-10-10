import 'dart:developer';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class SoundPlayerProvider with ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  bool get isPlaying => _isPlaying;
  AudioPlayer get audioPlayer => _audioPlayer;
  Duration get duration => _duration;
  Duration get position => _position;

  SoundPlayerProvider() {
    // Listening to duration changes of the audio file
    _audioPlayer.onDurationChanged.listen((duration) {
      _duration = duration;
      notifyListeners();
    });

    // Listening to position changes
    _audioPlayer.onPositionChanged.listen((position) {
      if (position <= _duration) {
        _position = position;
        notifyListeners();
      }
    });

    // Resetting player when the audio completes
    _audioPlayer.onPlayerComplete.listen((_) {
      _isPlaying = false;
      _position = Duration.zero;
      notifyListeners();
    });
  }

  Future<void> togglePlayStop(String audioPath) async {
  
  if (_isPlaying) {
    await _audioPlayer.pause();
    _isPlaying = false;
  } else {
    try {
      await _audioPlayer.play(UrlSource(audioPath)); 
            
       // For remote URL
      _isPlaying = true;
    } catch (e) {
    }
  }
  notifyListeners();
}

  Future<void> seekAudio(double value) async {
  final position = Duration(seconds: value.toInt());
    await _audioPlayer.seek(position);
    _position = position;
    notifyListeners();

}


  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  Future<void> stopAudio() async {
    if (_isPlaying) {
      await _audioPlayer.stop();
      _isPlaying = false;
      _duration = Duration.zero;
      // _position = Duration.zero; // Reset position to the start
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
