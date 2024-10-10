

import 'dart:developer';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class DataProvider with ChangeNotifier {
  List<String> _shajraHasbiyaImageUrls = [];
  List<String> _akwalImageUrls = []; 
  List<int> _shajraHasbiyaImageIndex = [];
  List<String> _shajraNasbiyaImageUrls = [];
  List<int> _shajraNasbiyaImageIndex = [];
  List<String> _simpleSound = [];
  List<String> _majlisSound = [];
  List<String> _majlisText = [];
  List<String> _akwalAudio = [];
  String _video = "https://firebasestorage.googleapis.com/v0/b/qalb-e-saleem-c7987.appspot.com/o/home_page_video.mp4?alt=media&token=0a167ebd-5a19-414a-b86e-2c630969e318";
  String _gif = "";

  Map<String, String> _imageMap = {};
  Map<String, String> _audioMap = {};
  Map<String, String> _pdfMap = {};

  Map<String, String> get imageMap => _imageMap;
  String get video => _video;
  String get gif => _gif;
  Map<String, String> get audioMap => _audioMap;
  List<String?> get shajraHasbiyaImageUrls => _shajraHasbiyaImageUrls;
  Map<String, String> get pdfMap => _pdfMap;
  List<int?> get shajraHasbiyaImageIndex => _shajraHasbiyaImageIndex;
  List<String?> get shajraNasbiyaImageUrls => _shajraNasbiyaImageUrls;
  List<String> get simpleSound => _simpleSound;
  List<String> get majlisSound => _majlisSound;
  List<String> get akwalAudio => _akwalAudio;
  List<int> get shajraNasbiyaImageIndex => _shajraNasbiyaImageIndex;
  List<String> get akwalImageUrls => _akwalImageUrls;
  List<String> get majlisText => _majlisText;

  List<String> _majlisImages = [];
  List<String> _majlisThumb = [];
  List<String> _majlisBookImages = [];

  List<String> get majlisImages => _majlisImages;
  List<String> get majlisThumb => _majlisThumb;
  List<String> get majlisBookImages => _majlisBookImages;
  Map<String, String> _pngUrls = {};

  Map<String, String> get pngUrls => _pngUrls;

  final firebaseStorage = FirebaseStorage.instance.ref();

  void getShajraNasbiyaImageUrl() async {
  // Clear the existing lists to avoid duplication
  shajraNasbiyaImageIndex.clear();
  shajraNasbiyaImageUrls.clear();

  // Fetch the list of files from Firebase
  final ListResult result = await firebaseStorage.child("shajra_nasbiya/").listAll();

  for (final Reference ref in result.items) {
    final String url = await ref.getDownloadURL();
    final int index = extractIndexFromFileName(ref.toString());

    // Check if the index and URL already exist to avoid duplicates
    if (!shajraNasbiyaImageIndex.contains(index) && !shajraNasbiyaImageUrls.contains(url)) {
      shajraNasbiyaImageIndex.add(index);
      shajraNasbiyaImageUrls.add(url);
    }
  }

  // Notify listeners to update the UI
  notifyListeners();
}


  

      
    
  

  void getAkwalAudio() async {
    akwalAudio.clear();
    final ListResult result =
        await firebaseStorage.child("aqwal_voice/").listAll();

    for (final Reference ref in result.items) {
      final String url = await ref.getDownloadURL();

      if(!akwalAudio.contains(url)){
        akwalAudio.add(url);
      }
    }

    notifyListeners();
  }

  void getMajlisAudios() async {
    majlisSound.clear();
    final ListResult result =
        await firebaseStorage.child("majlis_audio/").listAll();

    for (final Reference ref in result.items) {
      final String url = await ref.getDownloadURL();

     if(!majlisSound.contains(url)){
       majlisSound.add(url);
     }
    }

    notifyListeners();
  }

  void getAllImageUrl() async {
    imageMap.clear();
    final ListResult result = await firebaseStorage.child("pngs/").listAll();

    for (final Reference ref in result.items) {
      final String url = await ref.getDownloadURL();

      String fileName = ref.name.replaceAll('.png', '');
if(!imageMap.containsKey(fileName)){
 imageMap[fileName] = url;
}
     
    }

    // Print or use the map as needed
    notifyListeners();
  }

  void getSounds() async {
    simpleSound.clear();
    final ListResult result =
        await firebaseStorage.child("aqwal_voice/").listAll();

    for (final Reference ref in result.items) {
      final String url = await ref.getDownloadURL();

      if(simpleSound.contains(url)){
        simpleSound.add(url);
      }
    }

    notifyListeners();
  }

void getakwalImageUrl() async {
  final ListResult result = await firebaseStorage.child("aqwal/").listAll();

  // Clear the existing image URLs list to prevent duplication
  akwalImageUrls.clear();  

  for (final Reference ref in result.items) {
    final String url = await ref.getDownloadURL();
    
    // Check if the URL already exists to avoid duplicates
    if (!akwalImageUrls.contains(url)) {
      akwalImageUrls.add(url);
    }
  }
  
  // Notify listeners to update the UI
  notifyListeners();
}

  void getMajlisText() async {
    majlisText.clear();
    final ListResult result =
        await firebaseStorage.child("majlis_text/").listAll();

    for (final Reference ref in result.items) {
      final String url = await ref.getDownloadURL();

      if(!majlisText.contains(url)){
        majlisText.add(url);
      }
    }

    notifyListeners();
  }



  void getShajraHasbiyaImageUrl() async {
  // Clear the existing lists to avoid duplication
  shajraHasbiyaImageIndex.clear();
    shajraHasbiyaImageUrls.clear();

  // Fetch the list of files from Firebase
  final ListResult result = await firebaseStorage.child("shajra_hasbiya/").listAll();

  for (final Reference ref in result.items) {
    final String url = await ref.getDownloadURL();
    final int index = extractIndexFromFileName(ref.toString());

    // Check if the index and URL already exist to avoid duplicates
    if (!shajraHasbiyaImageIndex.contains(index) && !shajraHasbiyaImageUrls.contains(url)) {
      shajraHasbiyaImageIndex.add(index);
      shajraHasbiyaImageUrls.add(url);
    }
  }

  // Notify listeners to update the UI
  notifyListeners();
}

  void getMajlisThumbUrl() async {
    _majlisThumb.clear();
    final ListResult result =
        await firebaseStorage.child("majlisThumb/").listAll();

    for (final Reference ref in result.items) {
      final String url = await ref.getDownloadURL();
if(!_majlisThumb.contains(url)) {
     _majlisThumb.add(url);
    }
    
    }

    notifyListeners();
  }

  void majlisBookImagesUrl() async {
_majlisBookImages.clear();
    final ListResult result = await FirebaseStorage.instance
        .ref()
        .child("majlisBookImages/")
        .listAll();

    for (final Reference ref in result.items) {
      final String url = await ref.getDownloadURL();
if(!_majlisBookImages.contains(url)) {
     _majlisBookImages.add(url);
    }
      
    }
    

    notifyListeners();
  }

  void getMajlisImagesUrl() async {

 
  
  final ListResult result = await firebaseStorage.child("majlisImages/").listAll();
  _majlisImages.clear();

  for (final Reference ref in result.items) {
    final String url = await ref.getDownloadURL();
    if(!_majlisImages.contains(url)) {
      _majlisImages.add(url);
    }
  }

  // Remove duplicates
  _majlisImages = majlisImages.toSet().toList();

  notifyListeners();
}


  Future<void> getPngs() async {
    pngUrls.clear();
    final ListResult result =
        await FirebaseStorage.instance.ref('pngs/').listAll();

    for (Reference ref in result.items) {
      String fileName = ref.name.split('.').first;

      String url = await ref.getDownloadURL();
  if(!_pngUrls.containsKey(fileName)){
_pngUrls[fileName] = url;
  }
      
    }

    notifyListeners();
  }

  Future<void> getAudios() async {
    audioMap.clear();
    final ListResult result =
        await FirebaseStorage.instance.ref('audio/').listAll();

    for (Reference ref in result.items) {
      String fileName = ref.name.split('.').first;

      String url = await ref.getDownloadURL();

      if(!audioMap.containsKey(fileName)){
        audioMap[fileName] = url;
      }
    }

    notifyListeners();
  }
  Future<void> getPdfs() async {
    pngUrls.clear();
    final ListResult result =
        await FirebaseStorage.instance.ref('pdfs/').listAll();

    for (Reference ref in result.items) {
      String fileName = ref.name.split('.').first;

      String url = await ref.getDownloadURL();

      if(!pdfMap.containsKey(fileName)){
        pdfMap[fileName] = url;
      }
    }

    notifyListeners();
  }
  
  int extractIndexFromFileName(String filePath) {
    final fileName = filePath.split('/').last;
    final nameWithoutExtension = fileName.split('.').first;
    final index = int.tryParse(nameWithoutExtension);
    return index!;
  }
}
