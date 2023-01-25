import 'dart:convert';
import 'dart:io' as f;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_features/pages/tool_page/fire_storage.dart/fire_storage_service.dart';
import 'package:flutter_features/widgets/widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class FileUpload extends StatefulWidget {
  const FileUpload({super.key});

  @override
  State<FileUpload> createState() => _FileUploadState();
}

class _FileUploadState extends State<FileUpload> {
  String imageUrl = "";

  final storage = FirebaseStorage.instance;
  List images = [];

  @override
  void initState() {
    super.initState();
    gettingAllImages();
  }

  gettingAllImages() async {
    final listResult = await storage.ref().child('/file_upload').listAll();
    setState(() {
      images = listResult.items;
    });
    // for (var prefix in listResult.prefixes) {// The prefixes under storageRef.// You can call listAll() recursively on them.}
    // for (var item in listResult.items) {// The items under storageRef.}
  }

  @override
  Widget build(BuildContext context) {
    // print(images);
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
      body: SingleChildScrollView(
        child: Container(
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
                  imgUpload();
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              DataTable(
                decoration: BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(color: Color.fromARGB(255, 104, 104, 104)),
                      top:
                          BorderSide(color: Color.fromARGB(255, 104, 104, 104)),
                      left:
                          BorderSide(color: Color.fromARGB(255, 104, 104, 104)),
                      right: BorderSide(
                          color: Color.fromARGB(255, 104, 104, 104))),
                ),
                columns: [
                  DataColumn(
                    label: Text("Name"),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Action',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
                rows: images.map((val) {
                  TextStyle linkStyle = TextStyle(color: Colors.blue);

                  return DataRow(cells: [
                    DataCell(
                      RichText(
                        text: TextSpan(
                          text: val.name,
                          style: linkStyle,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              var imgUlr =
                                  (await val.getDownloadURL() as String);
                              await showDialog(
                                  context: context,
                                  builder: (_) => ImageDialog(
                                      path: val.fullPath, data: imgUlr));
                            },
                        ),
                      ),
                    ),
                    DataCell(
                      Row(
                        children: [
                          ElevatedButton(
                            child: Text('Delete'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                            ),
                            onPressed: () async {
                              // nextScreen(context, AddUser());
                              // deleteCompany(val['id'], val);
                            },
                          ),
                        ],
                      ),
                    ),
                  ]);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  imgUpload() async {
    if (kIsWeb) {
      // running on android or ios device
      final file = await ImagePicker().pickImage(source: ImageSource.gallery);
      await FireStoreService(context: context, folder: 'file_upload')
          .uploadFile(file);
      gettingAllImages();
    } else {
      await Permission.photos.request();
      var permissionStatus = await Permission.photos.status;
      if (permissionStatus.isGranted) {
        final file = await ImagePicker().pickImage(source: ImageSource.gallery);
        await FireStoreService(context: context, folder: 'file_upload')
            .uploadFile(file);
        gettingAllImages();
      } else {
        print('Permission not granted. Try Again with permission access');
      }
    }
  }
}

class ImageDialog extends StatelessWidget {
  final String path;
  final String data;
  ImageDialog({required this.path, required this.data});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        // width: 200,
        // height: 200,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(data),
            // fit: BoxFit.fill,
          ),
        ),
      ),
    );
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