import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_features/widgets/widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_features/widgets/cheetah_input.dart';
import '../tool_page/fire_storage.dart/fire_storage_service.dart';
import 'package:flutter_features/pages/product_page/product_page.dart';
import 'package:flutter_features/pages/login/service/database_service.dart';

class EditProduct extends StatefulWidget {
  String producName = "";
  String stocks = "";
  List companies = [];
  String companyId = "";
  String companyName = "";
  String avilability = "";
  String timeEdited = "";
  String uid = "";
  EditProduct(
      {Key? key,
      required this.producName,
      required this.stocks,
      required this.companies,
      required this.companyId,
      required this.companyName,
      required this.avilability,
      required this.uid})
      : super(key: key);
  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  bool _isLoading = false;
  final formKey = GlobalKey<FormState>();
  String producName = "";
  String stocks = "";
  String companyId = '';
  String avilability = '';
  String timeEdited = "";
  String companyName = "";
  List avilabilities = ['yes', 'no'];
  List companIds = [];
  List? urlImge = [];
  List<XFile>? images = [];
  @override
  void initState() {
    super.initState();
    gettingAllCompany();
  }

  gettingAllCompany() async {
    QuerySnapshot snapshot = await DatabaseService().getAllCompany();
    QuerySnapshot companyInfo =
        await DatabaseService().getProductById(widget.uid);
    for (var f in companyInfo.docs) {
      for (var t in f['productImages']) {
        var test = await FirebaseStorage.instance
            .ref()
            .child(t)
            .getDownloadURL() as String;
        setState(() {
          urlImge?.add(test);
        });
      }
    }

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
        title: Text(
          'Edit Product',
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
                  inputFormatters: [],
                  keyboardType: TextInputType.text,
                  hideText: false,
                  labelText: 'Product Name',
                  initVal: widget.producName,
                  onSaved: (String value) {
                    producName = value;
                  },
                ),
                SizedBox(height: 16),
                CheetahInput(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  hideText: false,
                  initVal: widget.stocks,
                  labelText: 'Stocks',
                  onSaved: (String value) {
                    stocks = value;
                  },
                ),
                SizedBox(height: 16),
                DropdownButtonFormField(
                  value: widget.avilability == "" ? null : widget.avilability,
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
                DropdownButtonFormField(
                  value: widget.companyId == "" ? null : widget.companyId,
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
                    setState(
                        () => {companyId = "$newValue", companyName = text});
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Select Company';
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
                      var files = await ImagePicker().pickMultiImage();

                      if (files != null && files.length <= 7) {
                        setState(() {
                          images = files;
                        });
                      }
                    }),
                for (var image in urlImge!) Image.network(image),
                for (var image in images!) Image.network(image.path),
                SizedBox(height: 25),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      editProduct(
                        widget.uid,
                        widget.avilability,
                        widget.companyId,
                        widget.companyName,
                      );
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
    var mapCompany = companies
        .map((e) => e['companyId'] == category ? e['company'] : '')
        .where((e) => e != '' && e != null);
    return mapCompany.first.toString();
  }

  editProduct(id, avlty, cpny, cpnyname) async {
    if (formKey.currentState!.validate()) {
      setState(() {
        // _isLoading = true;
        timeEdited = DateTime.now().millisecondsSinceEpoch.toString();
      });
      if (avilability == "") avilability = avlty;
      if (companyId == "") {
        companyId = cpny;
        companyName = cpnyname;
      }
      var imgPaths =
          await FireStoreService(context: context, folder: 'products')
              .multipleUploadFile(images!);

      await DatabaseService()
          .editProduct(id, producName, stocks, companyId, companyName,
              avilability, timeEdited, imgPaths)
          .then((value) async {
        if (value == true) {
          Navigator.pop(context);
        } else {
          showSnackBr(context, Colors.red, value);
          _isLoading = false;
        }
      });
    }
  }
}
