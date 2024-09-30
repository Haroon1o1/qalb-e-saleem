import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterContainer extends StatelessWidget {
  const FooterContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
      width: double.infinity,
      decoration: BoxDecoration(color: const Color(0xFF2B3491)),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              _launchUrl("https://www.hizb-ur-rahman.com/");
            },
            child: Container(
              height: 240,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xFF162170),
              ),
              child: Image.asset(
                "assets/images/hizb.png",
                fit: BoxFit.contain,
                height: 300,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "© 2024",
            style: GoogleFonts.almarai(fontSize: 20, color: Colors.white),
          ),
          const SizedBox(height: 20),
          _buildFooterText("جملہ حقوق بحِق ناشر محفوظ ہیں"),
          _buildFooterText("ادارہ تحقیقاِت نواز"),
          const SizedBox(height: 20),
          _buildFooterText("مکتبہ حزب الرحمٰن", highlight: true),
          _buildFooterText("آستانہ عالیہ قادریہ", highlight: true),
          _buildFooterText("حضرت پیر سید محمد عبداللہ شاہ مشہدی قادری", highlight: true),
          _buildFooterText("رحمة الله تعالى عليه", highlight: true),
          const SizedBox(height: 20),
          _buildFooterText("موضع قادر بخش شریف، تحصیل کمالیہ"),
          _buildFooterText("ضلع ٹوبہ ٹیک سنگھ، پاکستان"),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildFooterText(String text, {bool highlight = false}) {
    return Text(
      text,
      textDirection: TextDirection.rtl,
      style: GoogleFonts.almarai(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: highlight
            ? const Color.fromARGB(255, 69, 221, 255)
            : Colors.white,
      ),
    );
  }

  void _launchUrl(String url)async {
     if (!await launchUrl(Uri.parse(url))) {
      throw new Exception("NAI CHALA");
    }
  }
}
