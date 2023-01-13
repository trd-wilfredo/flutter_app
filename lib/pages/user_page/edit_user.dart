import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_features/pages/login/service/auth_service.dart';
import 'package:flutter_features/pages/login/service/database_service.dart';
import 'package:flutter_features/pages/user_page/user_page.dart';
import 'package:flutter_features/widgets/cheetah_input.dart';
import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:flutter_features/widgets/widget.dart';

class EditUser extends StatefulWidget {
  String valName = '';
  String valId = '';
  String valCompany = '';
  String valLevel = '';
  String valEmail = '';
  EditUser(
      {Key? key,
      required this.valName,
      required this.valId,
      required this.valEmail,
      required this.valCompany,
      required this.valLevel})
      : super(key: key);

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  bool _isLoading = false;

  final formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String level = '';
  String fullname = '';
  String company = '';
  List levels = ['admin', 'normal'];
  List companies = [];
  AuthService authService = AuthService();
  @override
  void initState() {
    super.initState();
    gettingAllCompany();
  }

  gettingAllCompany() async {
    QuerySnapshot snapshot = await DatabaseService().getAllCompany();

    for (var f in snapshot.docs) {
      setState(() {
        companies.add(
          f['companyName'],
        );
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
        title: Text(
          'Edit User',
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
                        inputFormatters:[],
                        keyboardType: TextInputType.text,
                        hideText: false,
                        labelText: 'Name',
                        initVal: widget.valName,
                        onSaved: (String value) {
                          fullname = value;
                        },
                      ),
                      SizedBox(height: 16),
                      CheetahInput(
                        inputFormatters:[],
                        keyboardType: TextInputType.text,
                        hideText: false,
                        labelText: 'Email',
                        initVal: widget.valEmail,
                        onSaved: (String value) {
                          email = value;
                        },
                      ),
                      SizedBox(height: 16),
                      CheetahInput(
                        inputFormatters:[],
                        keyboardType: TextInputType.text,
                        hideText: true,
                        labelText: 'Password',
                        initVal: '********',
                        onSaved: (String value) {
                          password = value;
                        },
                      ),
                      SizedBox(height: 16),
                      DropdownButtonFormField(
                        value:
                            widget.valCompany == "" ? null : widget.valCompany,
                        items: companies.map((category) {
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
                          setState(() => {company = '$newValue'});
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'select company';
                          } else {
                            return null;
                          }
                        },
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
                        value: widget.valCompany == "" ? null : widget.valLevel,
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
                          // if (defaultTargetPlatform == TargetPlatform.iOS ||
                          //     defaultTargetPlatform == TargetPlatform.android) {
                          // Some android/ios specific code
                          var picked = await FilePickerCross.importFromStorage(
                              type: FileTypeCross
                                  .any, // Available: `any`, `audio`, `image`, `video`, `custom`. Note: not available using FDE
                              fileExtension:
                                  'png, jpeg, ' // Only if FileTypeCross.custom . May be any file extension like `dot`, `ppt,pptx,odp`
                              );

                          if (picked != null) {
                            print(picked.fileName);
                          }
                          // } else if (defaultTargetPlatform == TargetPlatform.linux ||
                          //     defaultTargetPlatform == TargetPlatform.macOS ||
                          //     defaultTargetPlatform == TargetPlatform.windows) {
                          //   // Some desktop specific code there
                          // } else {
                          //   // Some web specific code there
                          // }
                        },
                      ),
                      SizedBox(height: 25),
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () {
                            editUser(widget.valId);
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

  editUser(id) async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      print([fullname, email, password, company, level]);
      var timeEdited = DateTime.now().millisecondsSinceEpoch.toString();
      var userDlt = await DatabaseService(uid: id)
          .editUser(id, fullname, email, company, level, timeEdited);
      if (userDlt == true) {
        setState(() {
          nextScreenReplace(context, UserPage());
          _isLoading = false;
        });
      }
    }
  }
}
