import 'package:firebase_storage/firebase_storage.dart';

class FirebaseData{


static  final storageRef = FirebaseStorage.instance.ref().child('database');


}