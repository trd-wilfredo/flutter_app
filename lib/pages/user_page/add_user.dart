import 'dart:io' as f;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../login/service/database_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_features/widgets/widget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_features/widgets/cheetah_input.dart';
import 'package:flutter_features/pages/user_page/user_page.dart';
import 'package:flutter_features/pages/tool_page/user_tools.dart';
import '../tool_page/fire_storage.dart/fire_storage_service.dart';
import 'package:flutter_features/pages/login/service/auth_service.dart';

class AddUser extends StatefulWidget {
  List companies = [];
  AddUser({Key? key, required this.companies}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  bool _isLoading = false;

  final formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String level = '';
  String fullname = '';
  String companyName = '';
  String companyId = '';
  String uid = '';
  List levels = ['admin', 'normal'];
  List companIds = [];
  XFile? xfile;
  AuthService authService = AuthService();
  UserTool userTool = UserTool();
  f.File? xfile2;

  @override
  void initState() {
    super.initState();
    gettingAllCompany();
  }

  gettingAllCompany() async {
    QuerySnapshot snapshot = await DatabaseService().getAllCompany();

    var getUser = FirebaseAuth.instance.currentUser;
    uid = getUser!.uid;
    for (var f in snapshot.docs) {
      setState(() {
        companIds.add(f['uid']);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          'Add Product',
          style: TextStyle(
            color: Colors.white,
            fontSize: 27,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            )
          : SingleChildScrollView(
              // backgroundColor: Color.fromARGB(255, 53, 53, 53), // appBar:
              child: Container(
                margin: EdgeInsets.all(24),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CheetahInput(
                        inputFormatters: [],
                        keyboardType: TextInputType.text,
                        hideText: false,
                        initVal: '',
                        labelText: 'Name',
                        onSaved: (String value) {
                          fullname = value;
                        },
                      ),
                      const SizedBox(height: 16),
                      CheetahInput(
                        inputFormatters: [],
                        keyboardType: TextInputType.text,
                        hideText: false,
                        initVal: '',
                        labelText: 'Email',
                        onSaved: (String value) {
                          email = value;
                        },
                      ),
                      const SizedBox(height: 16),
                      CheetahInput(
                        inputFormatters: [],
                        keyboardType: TextInputType.text,
                        hideText: true,
                        labelText: 'Password',
                        initVal: '',
                        onSaved: (String value) {
                          password = value;
                        },
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField(
                        items: companIds.map((category) {
                          var text = getCompany(widget.companies, category);
                          return new DropdownMenuItem(
                              value: category,
                              child: Row(
                                children: <Widget>[
                                  Text(text.toString()),
                                ],
                              ));
                        }).toList(),
                        onChanged: (newValue) {
                          var text = getCompany(widget.companies, newValue);
                          setState(() =>
                              {companyId = "$newValue", companyName = text});
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'select company';
                          } else {
                            return null;
                          }
                        },
                        // value: level,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                          hintText: 'Company',
                          //  errorText: errorSnapshot.data == 0 ? Localization.of(context).categoryEmpty : null),
                        ),
                      ),
                      SizedBox(height: 16),
                      DropdownButtonFormField(
                        items: levels.map((category) {
                          return new DropdownMenuItem(
                              value: category,
                              child: Row(
                                children: <Widget>[
                                  Text(category),
                                ],
                              ));
                        }).toList(),
                        onChanged: (newValue) {
                          // do other stuff with _category
                          setState(() => level = '$newValue');
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'select level';
                          } else {
                            return null;
                          }
                        },
                        // value: Company,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                          hintText: 'level',
                          //  errorText: errorSnapshot.data == 0 ? Localization.of(context).categoryEmpty : null),
                        ),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        child: Text('Select Image'),
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () async {
                          if (kIsWeb) {
                            // running on android or ios device
                            var file = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);
                            setState(() {
                              xfile = file;
                            });
                          } else {
                            await Permission.photos.request();
                            var permissionStatus =
                                await Permission.photos.status;
                            if (permissionStatus.isGranted) {
                              final file = await ImagePicker()
                                  .pickImage(source: ImageSource.gallery);
                              setState(() {
                                xfile = file;
                              });
                            } else {
                              print(
                                  'Permission not granted. Try Again with permission access');
                            }
                          }
                        },
                      ),
                      xfile == null ? Text('') : Image.network(xfile!.path),
                      SizedBox(height: 25),
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () {
                            addUser();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(
                            "Submit",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  getCompany(companies, category) {
    var mapCompany = widget.companies
        .map((e) => e['companyId'] == category ? e['company'] : '')
        .where((e) => e != '' && e != null);
    return mapCompany.first.toString();
  }

  addUser() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      var imgPath = await FireStoreService(context: context, folder: 'profile')
          .uploadFile(xfile, uid);
      await userTool
          .createUser(
              fullname, email, password, level, companyName, companyId, imgPath)
          .then((value) async {
        if (value == true) {
          // nextScreenReplace(context, UserPage());
          Navigator.pop(context);
        } else {
          showSnackBr(context, Colors.red, value);
          _isLoading = false;
        }
      });
    }
  }
}
