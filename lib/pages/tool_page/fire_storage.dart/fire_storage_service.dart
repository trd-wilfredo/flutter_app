import 'dart:io' as f;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
      return '';
    }
    UploadTask uploadTask;
    // Create a Reference to the fileZxcvbnm,.
    var filename = id == 'NA' ? file.name : id;
    print(filename);
    Reference ref = FirebaseStorage.instance.ref().child('/$folder/$filename');
    final metadata = SettableMetadata(
      contentType: file.mimeType,
      customMetadata: {'picked-file-path': file.path},
    );
    if (kIsWeb) {
      uploadTask = ref.putData(await file.readAsBytes(), metadata);

      // print(uploadTask.whenComplete((ytry) => tet));
    } else {
      uploadTask = ref.putFile(f.File(file.path), metadata);
    }
    // var dowurl = await ref.getDownloadURL();

    return '/$folder/$filename';
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
