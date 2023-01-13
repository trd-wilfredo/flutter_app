import 'package:flutter/material.dart';
import 'package:flutter_features/pages/company_page/comapany_page.dart';
import 'package:flutter_features/pages/login/service/database_service.dart';
import 'package:flutter_features/widgets/cheetah_input.dart';
import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:flutter_features/widgets/widget.dart';

class EditCompany extends StatefulWidget {
  String company = "";
  String avilability = "";
  String uid = "";
  EditCompany(
      {Key? key,
      required this.company,
      required this.avilability,
      required this.uid})
      : super(key: key);

  @override
  State<EditCompany> createState() => _EditCompanyState();
}

class _EditCompanyState extends State<EditCompany> {
  bool _isLoading = false;
  final formKey = GlobalKey<FormState>();
  String companyName = "";
  String avilability = "";
  String timeEdited = "";

  List avilabilities = ['yes', 'no'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'Edit Company',
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
                        initVal: widget.company,
                        onSaved: (String value) {
                          companyName = value;
                        },
                      ),
                      SizedBox(height: 16),
                      DropdownButtonFormField(
                        value: widget.avilability == ""
                            ? null
                            : widget.avilability,
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
                            editCompany(widget.uid, widget.avilability);
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

  editCompany(id, avlty) async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        timeEdited = DateTime.now().millisecondsSinceEpoch.toString();
      });

      if (avilability == "") avilability = avlty;
      await DatabaseService()
          .editCompany(id, companyName, avilability, timeEdited)
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
