import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:qalb/providers/DataProvider.dart';
import 'package:qalb/providers/SoundPlayerProvider.dart';

class TextScreen extends StatefulWidget {
  final String image;
  final String name;

  TextScreen({
    super.key,
    required this.image,
    required this.name,
  });

  @override
  State<TextScreen> createState() => _TextScreenState();
}

class _TextScreenState extends State<TextScreen> {
  String fileText = '';
  Map<String, dynamic> images = {};

  @override
  void initState() {
    images = Provider.of<DataProvider>(context, listen: false).imageMap;
    super.initState();
    textFile();
  }

  Future<void> textFile() async {
    String fileContent = await rootBundle.loadString(getTextFile());
    setState(() {
      fileText = fileContent;
    });
  }

  @override
  Widget build(BuildContext context) {
    log("${Provider.of<SoundPlayerProvider>(context, listen: false).position}--------------------");
    return  Scaffold(
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
     
            Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.27,
                        decoration: getColor() == null ?BoxDecoration(
                          image: DecorationImage(image: AssetImage("assets/images/upergrad.png"), fit: BoxFit.fill)
                        ) :  BoxDecoration(color: getColor()),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    getImageAddress() == ""
                                        ? Image.network(
                                            "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png",
                                            width: 80)
                                        : Image.network(
                                            getImageAddress(),
                                            width: 80,
                                          ),
                                    SizedBox(width: 10),
                                    InkWell(
                                      onTap: () {
                                        
                                      },
                                      child: Image.asset(
                                        "assets/images/pause-white.png",
                                        width: 35,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      widget.name,
                                      style: GoogleFonts.almarai(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.pop(context);
                                      },
                                      child: Image.asset(
                                        "assets/images/back-arrow-white.png",
                                        width: 25,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            // Slider added here
                            Consumer<SoundPlayerProvider>(
                              builder: (context, soundPlayerProvider, _) {
                                return Row(
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                            "assets/images/clock-white.png",
                                            width: 15),
                                        SizedBox(width: 5),
                                        Text(
                                          soundPlayerProvider.formatDuration(
                                              soundPlayerProvider.position),
                                          style: GoogleFonts.almarai(
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SliderTheme(
                                      data: SliderTheme.of(context).copyWith(
                                        activeTrackColor: Colors.grey[100],
                                        inactiveTrackColor: Colors.grey[300],
                                        thumbColor: Colors.grey,
                                        thumbShape:
                                            CustomRoundSliderThumbShape(),
                                        overlayColor:
                                            Colors.grey.withOpacity(0.2),
                                        trackHeight: 4.0,
                                      ),
                                      child: Slider(
                                        value: soundPlayerProvider
                                            .position.inSeconds
                                            .toDouble(),
                                        min: 0.0,
                                        max: soundPlayerProvider
                                            .duration.inSeconds
                                            .toDouble(),
                                        onChanged: (value) {
                                          soundPlayerProvider.seekAudio(value);
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          LottieBuilder.asset(
                                            animate:
                                                Provider.of<SoundPlayerProvider>(
                                                        context,
                                                        listen: false)
                                                    .isPlaying,
                                            "assets/images/voice.json",
                                            width: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                            SizedBox(height: 0),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.21,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 25),
                height: MediaQuery.of(context).size.height * 0.8,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.grey.shade300,
                      width: 1.0,
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Image.asset("assets/images/motive.png", width: 100),
SizedBox(height: 30),
                        Text(
                          widget.name,
                          style: TextStyle(
                            fontFamily: "al-quran",
                            fontSize: 25,
                            color: Color.fromARGB(255, 15, 199, 181),
                          ),
                        ),
                        SizedBox(
                            height: widget.name == "شجرٔہ قادریہ نسبیہ" ||
                                    widget.name == "شجرٔہ قادریہ حسبیہ"
                                ? 0
                                : 30),
                        Html(data: fileText),
                        SizedBox(height: 20,),
                                                Image.asset("assets/images/motive.png", width: 100),

                        SizedBox(height: 100,)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      
    );
  }


String getTextFile() {
    final textFileMap = {
      "اظہار تشکر": "assets/textFiles/tashakur.html",
      "مقّدمۃ الکتاب": "assets/textFiles/maqadma.html",
      "الفراق": "assets/textFiles/alfiraq.html",
      "پیش لفظ": "assets/textFiles/peshLafz.html",
      "سوانح حیات": "assets/textFiles/sawana.html",
      "قلبِ سلیم": "assets/textFiles/qalb.html",
      "شجرٔہ قادریہ حسبیہ": "assets/textFiles/hasbia.html",
      "شجرٔہ قادریہ نسبیہ": "assets/textFiles/nasbiya.html",
      "قطعہ تاریخ وصال": "assets/textFiles/qata.html",
      "منقبت": "assets/textFiles/manqabat1.html",
      "2منقبت": "assets/textFiles/manqabat2.html",
    };
    return textFileMap[widget.name] ?? "";
  }
  String getImageAddress() {
    final imageMap = {
      "منقبت": images["manqabat-white"],
      "اظہار تشکر": images["izhar-white"],
      "الفراق": images["alfiraq-white"],
      "مقّدمۃ الکتاب": images["muqadma-white"],
      "پیش لفظ": images["paish_lafz-white"],
      "سوانح حیات": images["sawana-white"],
      "قلبِ سلیم": images["qalbesaleem"],
      "شجرٔہ قادریہ حسبیہ": images["shajra_hasbia"],
      "شجرٔہ قادریہ نسبیہ": images["shajra_nasbia"],
      "قطعہ تاریخ وصال": images["qata-white"],
      "2منقبت": images["manqabat2-white"],
    };
    log("${imageMap[widget.name]}");
    return imageMap[widget.name] ?? "";
  }
  Color? getColor() {
    final color = {
      "منقبت": Color(0xFF10A7E2),
      "اظہار تشکر": Color(0xFF2B3491),
      "الفراق": Color(0xFF281E63),
      "مقّدمۃ الکتاب": Color(0xFF692592),
      "پیش لفظ": Color(0xFF00B771),
      "سوانح حیات": Color(0xFF00BEAE),
      "قلبِ سلیم": Color(0xFF1373BF),
      "شجرٔہ قادریہ حسبیہ": null,
      "شجرٔہ قادریہ نسبیہ": null,
      "قطعہ تاریخ وصال": Color(0xFF1373BF),
      "2منقبت": Color(0xFF00A79D),
    };
    return color[widget.name] ?? null ;
  }

 
}

// -----------------------------------------------SLIDER STYLE

class CustomRoundSliderThumbShape extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(24.0, 24.0);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final Paint outerPaint = Paint()
      ..color = sliderTheme.thumbColor!
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, 12.0, outerPaint);

    final Paint innerPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, 5.0, innerPaint);
  }
}
