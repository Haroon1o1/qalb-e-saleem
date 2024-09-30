import 'package:flutter/material.dart';
import 'package:qalb/screens/HomeScreen/widgets/LongBox.dart';

class LongContainerRow extends StatelessWidget {
  const LongContainerRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [
                          LongBox(
                            tag: "sawana",
                            audioPath: '',
                            imagePath: 'assets/images/sawaneh-hayat.png',
                            mainText: "سوانح حیات",
                            subText1: "از رشحاِت قلم:",
                            subText2:
                                " حضرت سّید محمد ظفر قادری رحمة الله تعالى عليه",
                            backgroundColor: Color(0xFF00BEAE),
                          ),
                          SizedBox(height: 10),
                          LongBox(
                            tag: "qalb",
                            audioPath: '',
                            imagePath: 'assets/images/qalb-e-saleem.png',
                            mainText: 'قلبِ سلیم',
                            subText1: 'از رشحاِت قلم',
                            subText2: 'سّید محمد فراز شاہ مشہدی قادری عفی عنہ',
                            backgroundColor: Color(0xFF1373BF),
                          ),
                          SizedBox(height: 10),
                          LongBox(
                            tag: "",
                              audioPath: '',
                              imagePath: 'assets/images/aqwal-white.png',
                              mainText: 'اقوال و ارشاداِت عالیہ',
                              subText1:
                                  'امام االولیاء حضرت پیر سّید محّمد عبد الله شاہ',
                              subText2: 'مشہدی قادری رحمة الله تعالى عليه',
                              backgroundColor: Color(0xFF2B3491)),
                        ],
                      ),
                    );
  }
}