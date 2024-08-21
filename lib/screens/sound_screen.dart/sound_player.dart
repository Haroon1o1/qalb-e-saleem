import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qalb/providers/DataProvider.dart';
import 'package:qalb/screens/sound_screen.dart/text_screen.dart';

class SoundPlayer extends StatefulWidget {
  final String image;
  final String name;
  final String sub;
  final String audioPath; // Add the audioPath parameter

  SoundPlayer({
    super.key,
    required this.image,
    required this.name,
    required this.sub,
    required this.audioPath, // Include the audioPath in the constructor
  });

  @override
  State<SoundPlayer> createState() => _SoundPlayerState();
}
class _SoundPlayerState extends State<SoundPlayer> with WidgetsBindingObserver {
  double position = 0.0;
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); // Add observer for app state
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    WidgetsBinding.instance.removeObserver(this); // Remove observer
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused || state == AppLifecycleState.detached) {
      // Stop the audio when the app goes into the background or is closed
      _audioPlayer.stop();
    }
  }

  void _togglePlayStop() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
      setState(() {
        _isPlaying = false;
      });
    } else {
      try {
        // widget.audioPath
        await _audioPlayer.play(AssetSource("tashakur.mp3"));
        setState(() {
          _isPlaying = true;
        });
      } catch (e) {
        print('Error playing audio: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
        child: Column(
          children: [
            SizedBox(height: 70),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("قلبِ سلیم",
                      style: GoogleFonts.almarai(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[500])),
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset("assets/images/back-arrow-grey.png",
                          width: 25)),
                ],
              ),
            ),
            SizedBox(height: 50),
            Hero(
              tag: "image",
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset(
                  widget.image,
                  width: double.infinity,
                  height: 320.0,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(height: 40),
            Text(
              widget.name,
              style: GoogleFonts.almarai(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              textDirection: TextDirection.rtl,
              overflow: TextOverflow.ellipsis,
              widget.sub,
              style: GoogleFonts.almarai(
                fontSize: 13,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 40),
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.centerLeft,
              children: [
                Container(
                  height: 2.0,
                  width: double.infinity,
                  color: Colors.grey[300],
                ),
                Positioned(
                  left: position,
                  child: GestureDetector(
                    onHorizontalDragUpdate: (details) {
                      setState(() {
                        position = (details.localPosition.dx /
                                MediaQuery.of(context).size.width)
                            .clamp(0.0, 1.0);
                      });
                    },
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3)),
                      child: Image.asset(
                        fit: BoxFit.fill,
                        'assets/images/timeline.png',
                        width: 30.0,
                        height: 30.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TextScreen(
                              image: widget.image,
                              name: widget.name,
                            ),
                          ));
                    },
                    child: Image.asset(
                      "assets/images/read.png",
                      width: 35,
                    )),
                GestureDetector(
                  onTap: _togglePlayStop,
                  child: Image.asset(
                    _isPlaying
                        ? "assets/images/play.png"
                        : "assets/images/play.png",
                    width: 60,
                  ),
                ),
                Image.asset(
                  "assets/images/share-grey.png",
                  width: 35,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }


}
