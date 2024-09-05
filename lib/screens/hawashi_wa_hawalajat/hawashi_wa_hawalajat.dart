
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:google_fonts/google_fonts.dart';

class hawashiwahawalajatScreen extends StatefulWidget {
  const hawashiwahawalajatScreen({super.key});

  @override
  State<hawashiwahawalajatScreen> createState() =>
      _hawashiwahawalajatScreenState();
}

class _hawashiwahawalajatScreenState extends State<hawashiwahawalajatScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.26,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                "assets/images/upergrad.png",
                              ),
                              fit: BoxFit.fill)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 0.0, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(height: 10),
                              Text(
                                "حواشی و حوالہ جات",
                                style: GoogleFonts.almarai(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "قلب سلیم",
                                style: GoogleFonts.almarai(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    child: Image.asset(
                                      "assets/images/back-arrow-white.png",
                                      width: 26,
                                    ),
                                  ),
                                ),
                              ]),
                          SizedBox(
                            width: 20,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height *
                0.21, // Adjust position as needed
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 25),
              height: MediaQuery.of(context).size.height *
                  0.8, // Adjust height as needed
              decoration: BoxDecoration(
                color: const Color.fromARGB(
                    255, 231, 230, 230), // Container background color
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.7,
                  padding: EdgeInsets.symmetric(vertical: 55),
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      
                      GestureDetector(
                        onTap: (){
                          
                          FileDownloader.downloadFile(url: "https://firebasestorage.googleapis.com/v0/b/qalb-e-saleem-c7987.appspot.com/o/hawashiPdf%2FHawashe-O-Hawalajat%201.pdf?alt=media&token=f24fb3d0-df78-4e05-a3d1-4847ac1ea868" , onDownloadError: (String error){
                          },notificationType: NotificationType.all,
                          name: "Hawalajat-Part01",
                          onDownloadCompleted: (String m){
                          }
                          );
                              // downloadPdf("https://firebasestorage.googleapis.com/v0/b/qalb-e-saleem-c7987.appspot.com/o/hawashiPdf%2FHawashe-O-Hawalajat%201.pdf?alt=media&token=f24fb3d0-df78-4e05-a3d1-4847ac1ea868", "Part01");
                        },
                        child: Image.asset("assets/images/hawalajat1.png", width: 150)),
                      SizedBox(height: 50),
                      GestureDetector(
                         onTap: (){
                          FileDownloader.downloadFile(
                            name: "Hawalajat-Part02",
                            url: "https://firebasestorage.googleapis.com/v0/b/qalb-e-saleem-c7987.appspot.com/o/hawashiPdf%2FHawashe-O-Hawalajat%202.pdf?alt=media&token=60c139ff-4e5f-4f7e-8662-4a56061c1f41" , onDownloadError: (String error){
                          },notificationType: NotificationType.all,
                          onDownloadCompleted: (String m){
                          }
                          );
                              // downloadPdf("https://firebasestorage.googleapis.com/v0/b/qalb-e-saleem-c7987.appspot.com/o/hawashiPdf%2FHawashe-O-Hawalajat%201.pdf?alt=media&token=f24fb3d0-df78-4e05-a3d1-4847ac1ea868", "Part01");
                        },
                        // onTap: (){
                        //   // downloadPdf("https://firebasestorage.googleapis.com/v0/b/qalb-e-saleem-c7987.appspot.com/o/hawashiPdf%2FHawashe-O-Hawalajat%202.pdf?alt=media&token=60c139ff-4e5f-4f7e-8662-4a56061c1f41", "Part02");
                        // },
                        child: Image.asset("assets/images/hawalajat2.png", width: 200, fit: BoxFit.cover,)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }

// void downloadPdf(String url,String name) async {
//   await requestStoragePermission();

//   try{
//   var path = "/storage/emulated/0/Download/$name.pdf";
//   var file = File(path);
//   var res = await get(Uri.parse(url));
  
//     file.writeAsBytes(res.bodyBytes);
//     ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text("File downloaded to $path"),
//             duration: Duration(seconds: 3),
//           ),
//         );
//   }catch(e){
//     log("${e}");
//   }
// }

// Future<void> requestStoragePermission() async {
//   final status = await Permission.storage.request();
//   if (status.isGranted) {
//     print('Storage permission granted');
//   } else {
//     print('Storage permission denied');
//   }
// }



}
