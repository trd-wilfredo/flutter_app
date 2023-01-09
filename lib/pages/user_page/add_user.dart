import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_features/helper/helper_function.dart';
import 'package:flutter_features/pages/login/service/auth_service.dart';
import 'package:flutter_features/pages/user_page/user_page.dart';
import 'package:flutter_features/widgets/cheetah_input.dart';
import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:flutter_features/widgets/widget.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

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
  String company = '';
  List levels = ['admin', 'normal'];
  List companies = ['company1', 'company2'];
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'Add User',
          style: TextStyle(
            color: Colors.white,
            fontSize: 27,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        // backgroundColor: Color.fromARGB(255, 53, 53, 53), // appBar:
        child: Container(
          margin: EdgeInsets.all(24),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CheetahInput(
                  obscureText: false,
                  labelText: 'Name',
                  onSaved: (String value) {
                    fullname = value;
                  },
                ),
                SizedBox(height: 16),
                CheetahInput(
                  obscureText: false,
                  labelText: 'Email',
                  onSaved: (String value) {
                    email = value;
                  },
                ),
                SizedBox(height: 16),
                CheetahInput(
                  obscureText: true,
                  labelText: 'Password',
                  onSaved: (String value) {
                    password = value;
                  },
                ),
                SizedBox(height: 16),
                DropdownButtonFormField(
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
                    print([newValue, 'asd']);
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

  addUser() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService
          .registerUserWithEmailandPassword(
              fullname, email, password, level, company)
          .then((value) async {
        if (value == true || Platform.isAndroid || Platform.isIOS) {
          await HelperFunction.saveUserLoggedInStatus(true);
          await HelperFunction.saveUserNameSF(fullname);
          await HelperFunction.saveUserEmailSF(email);
          nextScreenReplace(context, UserPage());
        } else {
          showSnackBr(context, Colors.red, value);
          _isLoading = false;
        }
      });
    }
  }
}
