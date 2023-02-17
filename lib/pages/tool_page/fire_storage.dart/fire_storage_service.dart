import 'dart:io' as f;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FireStoreService {
  final BuildContext context;
  final String folder;
  FireStoreService({required this.context, required this.folder});

  Future<String> uploadFile(XFile? file, String id) async {
    if (file == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No file was selected'),
        ),
      );
      if (folder == 'profile') {
        return '/$folder/hYEjVm9iqxaF6m8oj6YgEiChZG42';
      }
      return '';
    }
    UploadTask uploadTask;
    var filename = id == 'NA' ? file.name : id;
    var date = DateTime.now().millisecondsSinceEpoch.toString();
    var pathFile = folder == 'chat'
        ? '/$folder/$date$id${file.name}'
        : '/$folder/$filename';
    DateTime.now().millisecondsSinceEpoch.toString();
    Reference ref = FirebaseStorage.instance.ref().child(pathFile);
    final metadata = SettableMetadata(
      contentType: file.mimeType,
      customMetadata: {'picked-file-path': file.path},
    );
    if (kIsWeb) {
      uploadTask = ref.putData(await file.readAsBytes(), metadata);
    } else {
      uploadTask = ref.putFile(f.File(file.path), metadata);
    }
    return pathFile;
  }

  Future<List> multipleUploadFile(List<XFile> files) async {
    var url = [];
    if (files == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No file was selected'),
        ),
      );
      return [];
    }
    UploadTask uploadTask;
    var i = 0;
    while (i < files.length) {
      // Create a Reference to the fileZxcvbnm,.
      try {
        final metadata = SettableMetadata(
          contentType: '${files[i].mimeType}',
          customMetadata: {'picked-file-path': files[i].path},
        );

        Reference ref =
            FirebaseStorage.instance.ref().child('/$folder/${files[i].name}');
        if (kIsWeb) {
          uploadTask = ref.putData(await files[i].readAsBytes(), metadata);
        } else {
          uploadTask = ref.putFile(f.File(files[i].path), metadata);
        }
        url.add('/$folder/${files[i].name}');
        i++;
      } catch (e) {
        print(e.toString());
        // ...
      }
    }
    return url;
  }
}
