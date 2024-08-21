import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';

class TextList {
  static Future<Widget> doc(String path, BuildContext context) async {
    String data = await rootBundle.loadString('assets/tashakur.html');
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20), // Rounded corners
        border: Border.all(
          color: Colors.grey.shade300, // Light grey border color
          width: 1.0, // Border width
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset("assets/images/motive.png", width: 120),
            Html(data: data),
            SizedBox(height: 50),
            Image.asset("assets/images/motive.png", width: 120),
            SizedBox(height: 200),
          ],
        ),
      ),
    );
  }
}
