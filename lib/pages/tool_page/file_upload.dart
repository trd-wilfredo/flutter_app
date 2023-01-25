import 'dart:io' as f;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FileUpload extends StatefulWidget {
  const FileUpload({super.key});

  @override
  State<FileUpload> createState() => _FileUploadState();
}

class _FileUploadState extends State<FileUpload> {
  String imageUrl = "";
  late var _imagePicker = PickedFile;

  final storage = FirebaseStorage.instance;

  final ImagePicker _picker = ImagePicker();

  List<UploadTask> _uploadTasks = [];

  //Check Permissions
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Upload Image',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
                border: Border.all(color: Colors.white),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(2, 2),
                    spreadRadius: 2,
                    blurRadius: 1,
                  ),
                ],
              ),
              child: (imageUrl != null)
                  ? Image.asset('assets/image_1.jpg')
                  : Image.network('https://i.imgur.com/sUFH1Aq.png'),
            ),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              child: Text(
                "Upload Image",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              onPressed: () async {
                testing();

                // if (picked != null) {
                //   print(picked.files.first.name);
                // }
              },
            ),
          ],
        ),
      ),
    );
  }

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

    // Create a Reference to the file
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('flutter-tests')
        .child('/some-image.jpg');

    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': file.path},
    );

    if (kIsWeb) {
      uploadTask = ref.putData(await file.readAsBytes(), metadata);
    } else {
      uploadTask = ref.putFile(f.File(file.path), metadata);
    }

    return Future.value(uploadTask);
  }

  testing() async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    UploadTask? task = await uploadFile(file);
  }
}

//   uploadSrorage() {
//     // .future
//   }

//   uploadImage(file) async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     // print(pickedFile!.path);
//     // setState(() {
//     //   if (pickedFile != null) {
//     //     // _photo = File(pickedFile.path, 'sdf');
//     //     // uploadFile();
//     //   } else {
//     //     print('No image selected.');
//     //   }
//     // });
//     //   print(file);
//     //   fileUpload() async {
//     //     FilePickerResult? picked = await FilePicker.platform.pickFiles(
//     //       type: FileType.image,
//     //       withReadStream: true,
//     //     );
//     //     // var test = await ImagePicker()
//     //     //     .getImage(source: ImageSource.gallery)
//     //     //     .then((pickedFile) => pickedFile);
//     //     // setState(() {
//     //     //   _imagePicker = test as Type;
//     //     // });
//     //     if (_imagePicker != null) {
//     FirebaseStorage storage = FirebaseStorage.instance;
//     Reference ref = storage.ref().child("image/" + DateTime.now().toString());
//     UploadTask uploadTask = ref.putString(pickedFile!.path);

//     //       // uploadTask.then((res) {
//     //       //   res.ref.getDownloadURL();
//     //       // });
//     //     } else {
//     //       // User canceled the picker
//     //     }
//     //     // final StorageUploadTask uploadTask = ref.put(await imageFile);
//     //     // final Uri downloadUrl = (await uploadTask.future).downloadUrl;

//     //     // UploadImage().upload(img: image);
//     //     // var imageFile = File(
//     //     //     await ImagePicker()
//     //     //         .getImage(source: ImageSource.gallery)
//     //     //         .then((pickedFile) => pickedFile.path),
//     //     // 'png');
//     //     // if (file != null) {
//     //     //   final dateTime = DateTime.now();
//     //     //   final userId = '110';
//     //     //   final path = '110/$dateTime';
//     //     //   _firebaseStorage.storage
//     //     //       .refFromURL(Constants.storageBucket)
//     //     //       .child(path)
//     //     //       .putFile(imageFile)
//     //     //       // .future
//     //     //       .then((_) {
//     //     //     // FirebaseFirestore.instance
//     //     //     //     .collection('users')
//     //     //     //     .doc('110')
//     //     //     //     .update({'photo_url': path});
//     //     //   });
//     //     //   print(file);
//     //     //   // Create the file metadata
//     //     //   // final metadata = SettableMetadata(contentType: "image/jpeg");
//     //     //   // // Upload to Firebase
//     //     //   // var snapshot = await _firebaseStorage.child("sdfas/sdf").putFile(file);
//     //     //   // print([file, metadata, snapshot]);
//     //     //   // var downloadUrl = await snapshot.ref.getDownloadURL();
//     //     //   // setState(() {
//     //     //   //   imageUrl = downloadUrl;
//     //     //   // });
//     //     // } else {
//     //     //   print('No Image Path Received');
//     //     // }
//     //   }

//     //   if (kIsWeb) {
//     //     //running on android or ios device
//     //     fileUpload();
//     //   }
//     //   // else {
//     //   //   await Permission.photos.request();
//     //   //   var permissionStatus = await Permission.photos.status;
//     //   //   if (permissionStatus.isGranted) {
//     //   //     fileUpload();
//     //   //   } else {
//     //   //     print('Permission not granted. Try Again with permission access');
//     //   //   }
//     //   // }
//   }
// }