import 'dart:io' as f;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FireStoreService {
  final BuildContext context;
  final String folder;
  FireStoreService({required this.context, required this.folder});
  Future<UploadTask?> uploadFile(XFile? file) async {
    if (file == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No file was selected'),
        ),
      );
      return null;
    }
    UploadTask uploadTask;
    // Create a Reference to the fileZxcvbnm,.
    Reference ref =
        FirebaseStorage.instance.ref().child('/$folder/${file.name}');
    final metadata = SettableMetadata(
      contentType: file.mimeType,
      customMetadata: {'picked-file-path': file.path},
    );
    if (kIsWeb) {
      uploadTask = ref.putData(await file.readAsBytes(), metadata);
    } else {
      uploadTask = ref.putFile(f.File(file.path), metadata);
    }
    return Future.value(uploadTask);
  }
}
