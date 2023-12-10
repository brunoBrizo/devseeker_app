import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class ImageUpoader extends ChangeNotifier {
  var uuid = const Uuid();
  final ImagePicker _picker = ImagePicker();

  String? imageUrl;
  String? imagePath;

  bool _doneUploading = false;

  bool get loggedIn => _doneUploading;

  set uploading(bool newState) {
    _doneUploading = newState;
    notifyListeners();
  }

  List<String> imageFil = [];

  void pickImage() async {
    XFile? imageFile = await _picker.pickImage(source: ImageSource.gallery);

    if (imageFile != null) {
      imageFil.add(imageFile.path);
      imageUpload(imageFile).then((value) {
        uploading = true;
      });
      imagePath = imageFile.path;
    } else {
      return;
    }
  }

  Future<String?> imageUpload(XFile upload) async {
    File image = File(upload.path);

    final ref = FirebaseStorage.instance
        .ref()
        .child("devseeker_app")
        .child("${uuid.v1()}.jpg");
    await ref.putFile(image);

    imageUrl = (await ref.getDownloadURL());

    return imageUrl;
  }
}
