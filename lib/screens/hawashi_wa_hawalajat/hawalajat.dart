import 'package:flutter/material.dart';
import 'package:qalb/screens/aqwal_wa_irshadaat/widgets/upperPart.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class HawalajatPdf extends StatefulWidget {
   HawalajatPdf({super.key,});

  @override
  State<HawalajatPdf> createState() => _HawalajatPdfState();
}

class _HawalajatPdfState extends State<HawalajatPdf> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          UpperPart(isNavbar: false, mainText: "حواشی و حوالہ جات", subText: "قلب سلیم"),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.21,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              height: MediaQuery.of(context).size.height * 0.8,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset("assets/new_images/arrow-up.png", width: 20),
                    SizedBox(height: 5,),
                    Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: const Offset(1, 2),
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height * 0.66,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: SfPdfViewer.network(
                                                initialZoomLevel: 1.1,
                                                "https://firebasestorage.googleapis.com/v0/b/qalb-e-saleem-c7987.appspot.com/o/hawashiPdf%2Fhawala.pdf?alt=media&token=422a5832-fbd2-42f1-91af-aeeba95ca15c",
                                                canShowScrollHead: false,
                                                pageSpacing: 0,
                                                enableTextSelection: false,
                                                canShowPageLoadingIndicator: false, // Disable page loading indicator
                                                canShowScrollStatus: false,
                                              ),
                    ),
                    SizedBox(height: 5),
                    Image.asset("assets/new_images/arrow-down.png", width: 20),
                  ],
                )
              )
              ),),
        ],
      ),
    );
  }
}