import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'dowload/download_service.dart';
import 'fire_storage.dart/fire_storage_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:permission_handler/permission_handler.dart';

class FileUpload extends StatefulWidget {
  const FileUpload({super.key});

  @override
  State<FileUpload> createState() => _FileUploadState();
}

class _FileUploadState extends State<FileUpload> {
  String imageUrl = "";
  bool loading = false;
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
  }

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
              loading
                  ? Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 5.0,
                      ),
                    )
                  : ElevatedButton(
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
                              if (val.fullPath.contains('.pdf')) {
                                var imgUlr =
                                    (await val.getDownloadURL() as String);
                                DownloadService downloadService = kIsWeb
                                    ? WebDownloadService()
                                    : MobileDownloadService();
                                await downloadService.download(url: imgUlr);
                              } else {
                                await showDialog(
                                    context: context,
                                    builder: (_) => ImageDialog(
                                        path: val.fullPath, data: imgUlr));
                              }
                            },
                        ),
                      ),
                    ),
                    DataCell(
                      Row(
                        children: [
                          ElevatedButton(
                            child: Text('Download'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                            ),
                            onPressed: () async {
                              var imgUlr =
                                  (await val.getDownloadURL() as String);
                              DownloadService downloadService = kIsWeb
                                  ? WebDownloadService()
                                  : MobileDownloadService();
                              await downloadService.download(url: imgUlr);
                            },
                          ),
                          ElevatedButton(
                            child: Text('Delete'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                            ),
                            onPressed: () async {
                              final desertRef = storage
                                  .ref()
                                  .child('/file_upload/' + val.name);
                              // Delete the file
                              await desertRef.delete();
                              // REMOVE ROW
                              setState(() {
                                images.remove(val);
                              });
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
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      var unit8File = result!.files.first.bytes as Uint8List;
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('/file_upload/${result.files.first.name}');
      setState(() {
        loading = true;
      });
      ref.putData(unit8File).asStream().listen((event) {
        setState(() {
          loading = false;
        });
        gettingAllImages();
      });
    } else {
      await Permission.photos.request();
      var permissionStatus = await Permission.photos.status;
      if (permissionStatus.isGranted) {
        final file = await ImagePicker().pickImage(source: ImageSource.gallery);
        setState(() {
          loading = true;
        });
        await FireStoreService(context: context, folder: 'file_upload')
            .uploadFile(file, 'NA')
            .whenComplete(() async => {
                  setState(() {
                    loading = false;
                  }),
                  gettingAllImages()
                });
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
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(data),
          ),
        ),
      ),
    );
  }
}
