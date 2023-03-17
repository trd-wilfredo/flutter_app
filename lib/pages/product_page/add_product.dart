import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_features/widgets/widget.dart';
import 'package:flutter_features/widgets/cheetah_input.dart';
import '../tool_page/fire_storage.dart/fire_storage_service.dart';
import 'package:flutter_features/pages/product_page/product_page.dart';
import 'package:flutter_features/pages/login/service/database_service.dart';

class AddProduct extends StatefulWidget {
  List companies = [];
  AddProduct({Key? key, required this.companies}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  bool _isLoading = false;
  final formKey = GlobalKey<FormState>();
  String producName = "";
  String stocks = "";
  String companyName = '';
  String companyId = '';
  String avilability = '';
  String timeCreated = "";
  String currentSelectedValue = '';
  List avilabilities = ['yes', 'no'];
  List companIds = [];
  List<XFile>? images = [];
  void initState() {
    super.initState();
    gettingAllCompany();
  }

  gettingAllCompany() async {
    QuerySnapshot snapshot = await DatabaseService().getAllCompany();
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
          'Add Product',
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
                  initVal: '',
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
                  initVal: '',
                  labelText: 'Stocks',
                  onSaved: (String value) {
                    stocks = value;
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
                  },
                ),
                for (var image in images!) Image.network(image.path),
                SizedBox(height: 25),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      addProduct();
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

  addProduct() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        timeCreated = DateTime.now().millisecondsSinceEpoch.toString();
      });
      var imgPaths =
          await FireStoreService(context: context, folder: 'products')
              .multipleUploadFile(images!);
      await DatabaseService()
          .addSaveProduct(producName, companyId, companyName, stocks,
              avilability, timeCreated, imgPaths)
          .then((value) async {
        if (value == true) {
          // nextScreenReplace(context, ProductPage());
          Navigator.pop(context);
        } else {
          showSnackBr(context, Colors.red, value);
          _isLoading = false;
        }
      });
    }
  }
}
