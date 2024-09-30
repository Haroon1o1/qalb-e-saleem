import 'package:flutter/material.dart';
import 'package:qalb/screens/HomeScreen/widgets/smallContainer.dart';

class SmallContainerRow extends StatelessWidget {
  const SmallContainerRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SmallContainer(
                          backgroundColor: Color(0xFF10A8E3),
                          imagePath: 'assets/images/manqabat-dark.png',
                          text: 'منقبت',
                          sub:
                              "حضرت سّید محمد ظفر مشہدی قادری رحمة الله تعالى عليه",
                              tag:"manqabat",
                          audioPath: '',
                        ),
                        SmallContainer(
                           tag:"tashakur",
                          backgroundColor: Color(0xFF2C3491),
                          imagePath: 'assets/images/tashakur.png',
                          text: 'اظہار تشکر',
                          sub: 'سید محمد فراز شاہ عفی عنہ',
                          audioPath: '',
                        ),
                        SmallContainer(
                           tag:"maqadma",
                          backgroundColor: Color(0xFF692592),
                          imagePath: 'assets/images/muqadma-dark.png',
                          text: "مقدمہ الکتاب",
                          sub:
                              'حضرت ابو الحقائق پیر سّید امانت علی شاہ چشتی نظامی',
                          audioPath: '',
                        ),
                        SmallContainer(
                           tag:"paish",
                          backgroundColor: Color(0xFF00B771),
                          imagePath: 'assets/images/paish_lafz-dark.png',
                          text: 'پیش لفظ',
                          sub: 'عبد الحمید قادری عفی عنہ',
                          audioPath: '',
                        ),
                      ],
                    );;
  }
}