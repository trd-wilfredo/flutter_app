import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_features/pages/company_page/comapany_page.dart';
import 'package:flutter_features/pages/login/service/database_service.dart';
import 'package:flutter_features/widgets/cheetah_input.dart';
import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:flutter_features/widgets/widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class AddCompany extends StatefulWidget {
  const AddCompany({super.key});

  @override
  State<AddCompany> createState() => _AddCompanyState();
}

class _AddCompanyState extends State<AddCompany> {
  bool _isLoading = false;
  final formKey = GlobalKey<FormState>();
  String companyName = "";
  String avilability = "";
  String timeCreated = "";
  XFile? xfile;
  List avilabilities = ['yes', 'no'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'Add Company',
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
                        labelText: 'Company Name',
                        initVal: '',
                        onSaved: (String value) {
                          companyName = value;
                        },
                      ),
                      SizedBox(height: 16),
                      DropdownButtonFormField(
                        items: avilabilities.map((category) {
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
                          setState(() => avilability = '$newValue');
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Select Avilability';
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
                          hintText: 'Avilability',
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
                      xfile == null ? Text('data') : Image.network(xfile!.path),
                      SizedBox(height: 25),
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () {
                            addCompany();
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

  addCompany() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        timeCreated = DateTime.now().millisecondsSinceEpoch.toString();
      });
      await DatabaseService()
          .addSaveCompany(companyName, avilability, timeCreated)
          .then((value) async {
        if (value == true) {
          nextScreenReplace(context, CompanyPage());
        } else {
          showSnackBr(context, Colors.red, value);
          _isLoading = false;
        }
      });
    }
  }
}
