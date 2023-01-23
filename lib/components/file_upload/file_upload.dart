// import 'package:flutter/material.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';

// class ImageUpload extends StatefulWidget {
//   @override
//   _ImageUploadState createState() => _ImageUploadState();
// }

// class _ImageUploadState extends State<ImageUpload> {
//   String imageUrl = "";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Upload Image',
//           style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         elevation: 0.0,
//         backgroundColor: Color.fromRGBO(255, 255, 255, 1),
//       ),
//       body: Container(
//         color: Colors.white,
//         child: Column(
//           children: <Widget>[
//             Container(
//                 margin: EdgeInsets.all(15),
//                 padding: EdgeInsets.all(15),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(15),
//                   ),
//                   border: Border.all(color: Colors.white),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black12,
//                       offset: Offset(2, 2),
//                       spreadRadius: 2,
//                       blurRadius: 1,
//                     ),
//                   ],
//                 ),
//                 child: (imageUrl != null)
//                     ? Image.network(imageUrl)
//                     : Image.network('https://i.imgur.com/sUFH1Aq.png')),
//           ],
//         ),
//       ),
//     );
//   }
// }
