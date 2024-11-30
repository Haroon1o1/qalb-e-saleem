
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qalb/data/data.dart';
import 'package:qalb/data/links.dart';
import 'package:qalb/providers/DataProvider.dart';
import 'package:qalb/screens/Shaja_screens/TimeLine.dart';

// ignore: must_be_immutable
class ShajrEQadriaScreen extends StatelessWidget {
  bool isNavBar;
  final String text;
  ShajrEQadriaScreen({super.key, required this.text,required this.isNavBar});

  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topRight,
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: text == "nasbiya"
                      ? screenHeight * 0.72
                      : screenHeight * 0.52,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/upergrad.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Position the long paragraph container
                Container(
                  margin: EdgeInsets.only(top: screenHeight * 0.105),
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              text == "nasbiya"
                                  ? "شجرٔہ قادریہ نسبیہ"
                                  : "شجرٔہ قادریہ حسبیہ",
                              style: GoogleFonts.almarai(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.right,
                            ),
                            SizedBox(width: isNavBar? 30 : 10),
                            Visibility(
                              visible: isNavBar ? false : true,
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.pop(context);
                                },
                                child: Image.asset("assets/images/back-arrow-white.png",
                                    width: 25),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                          text == "nasbiya"
                              ? '''سلطان الاولیاء، امام العارفین، شہباز طریقت، مخزن علوم باطنی، منبع انوار رحمانی، حضرت پیر سید محمد عبد اللہ شاہ مشہدی قادری رحمة اللہ علیہ کی پیدائش 1315ھ بمطابق 1898ء موضع قادر بخش نزد کمالیہ، ضلع ٹوبہ ٹیک سنگھ میں ہوئی۔ آپ رحمة اللہ علیہ کا سلسلہ نسب حضرت سیدنا امام موسیٰ کاظم رضی اللہ عنہ سے ملتا ہے۔ اس وجہ سے آپ کو کاظمی سید کہتے ہیں۔ آپ رحمة اللہ علیہ کے آباء و اجداد طویل عرصہ تک مشہد مقدس میں رہے، اس کے بعد وارد ہند ہوئے، اس لیئے مشہدی سادات مشہور ہیں۔'''
                              : '''  آپ رحمة الله عليه کا شجرٔہ حسب اکتالیس (41) واسطوں سے پیارے آقا و مولٰی، محبوب خدا، حضرت سّیدنا احمد مجتبٰی:
 محمد مصطفٰی صلی الله عليه وآله وسلم سے جا ملتا ہے۔ اس کی پوری تفصیل مالحظہ فرمائیے''',
                          style: GoogleFonts.almarai(
                            color: Colors.white,
                            fontSize: 11,
                          ),
                          softWrap: true,
                          textDirection: TextDirection.rtl,
                          maxLines: null,
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        child: Text(
                          text == "nasbiya"
                              ? 'امام الاولیاء حضرت پیر سید محمد عبد اللہ شاہ مشہدی قادری رحمۃ اللہ علیہ کا شجرۂ نسب پینتیس (35) واسطوں سے حضور نبی کریم، رؤف رحیم صلی اللہ علیہ والہ وسلم سے جامعتا ہے۔ اس کی تفصیل حسب ذیل ہے :'
                              : "",
                          textDirection: TextDirection.rtl,
                          style: GoogleFonts.almarai(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                       ListView.builder(
                         shrinkWrap: true,
                         itemCount: text == "nasbiya"
                             ? TextData.shajraNasbia.length
                             : TextData.shajraHasbiya.length,
                         physics: NeverScrollableScrollPhysics(),
                         itemBuilder: (context, index) {
                           
                             return Container(
                             margin: EdgeInsets.symmetric(vertical: 0.0),
                             child: TimelineStep(
                               name: text,
                               stepNumber: index + 1,
                               imagePath: getImageUrl(index) ?? "",
                               description: text == "nasbiya"
                                   ? TextData.shajraNasbia[index]
                                   : TextData.shajraHasbiya[index],
                             ),
                           );
                           }
                         
                       ),
                      SizedBox(height: 200),
                    ],
                  ),
                ),
              ],
            ),
            // Timeline steps
          ],
        ),
      ),
    );
  }

  String? getImageUrl(int index) {
    switch (text) {
      case "nasbiya":
        switch (index + 1) {
          case 1:
            return Links.shajraNasbia[0];
          case 2:
            return Links.shajraNasbia[1];
          case 3:
            return Links.shajraNasbia[2];
          case 37:
            return Links.shajraNasbia[3];
          default:
            return "";
        }
      case "hasbiya":
        switch (index + 1) {
          case 1:
            return Links.shajraHasbia[0];
          case 2:
            return Links.shajraHasbia[1];
          case 3:
            return Links.shajraHasbia[2];
          case 17:
            return Links.shajraHasbia[3];
          
          case 42:
            return Links.shajraHasbia[4];
          case 43:
            return Links.shajraHasbia[5];
          default:
            return "";
        }
      default:
        return "";
    }
  }
}