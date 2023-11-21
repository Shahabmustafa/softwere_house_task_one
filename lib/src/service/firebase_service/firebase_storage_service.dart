import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class FirebaseStorageService{
  static Future<String> uploadImage(
      Uint8List file,
      String storagePath)async =>
    await FirebaseStorage.instance
        .ref()
        .child(storagePath)
        .putData(file)
        .then((p0) => p0.ref.getDownloadURL());

}