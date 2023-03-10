import 'package:firebase_dart/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_features/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_features/pages/product_page/add_product.dart';
import 'package:flutter_features/pages/product_page/edit_product.dart';
import 'package:flutter_features/pages/login/service/database_service.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool _isLoading = false;
  final formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String level = '';
  String fullname = '';
  String company = '';
  List products = [];
  List companies = [];
  String uid = '';
  @override
  void initState() {
    super.initState();
    gettingAllProduct();
  }

  gettingAllProduct() async {
    QuerySnapshot snapshot = await DatabaseService(uid: uid).getAllProduct();
    QuerySnapshot getAllCompany =
        await DatabaseService(uid: uid).getAllCompany();
    for (var f in getAllCompany.docs) {
      setState(() {
        companies.add({
          'company': f['companyName'],
          'companyId': f['uid'],
        });
      });
    }
    for (var f in snapshot.docs) {
      setState(() {
        products.add({
          'name': f['productName'],
          'company': f['companyName'],
          'companyId': f['companyId'],
          'stocks': f['stocks'],
          'avilability': f['avilability'],
          'id': f['uid'],
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: ElevatedButton(
              child: Text('Add Product'),
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
              ),
              onPressed: () {
                nextScreen(
                    context,
                    AddProduct(
                      companies: companies,
                    ));
              },
            ),
          ),
          Center(
            child: Container(
              height: 500,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: 20.0, bottom: 20.0, top: 50.0),
                      child: DataTable(
                        decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Color.fromARGB(255, 104, 104, 104)),
                              top: BorderSide(
                                  color: Color.fromARGB(255, 104, 104, 104)),
                              left: BorderSide(
                                  color: Color.fromARGB(255, 104, 104, 104)),
                              right: BorderSide(
                                  color: Color.fromARGB(255, 104, 104, 104))),
                        ),
                        columns: [
                          DataColumn(
                            label: Text("Name"),
                          ),
                          DataColumn(
                            label: Text("Company"),
                          ),
                          DataColumn(
                            label: Text("Stock/s"),
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
                        rows: products.map((val) {
                          return DataRow(cells: [
                            DataCell(
                              Container(
                                width: 133.3,
                                child: Text(val['name']),
                              ),
                            ),
                            DataCell(
                              Container(
                                width: 133.3,
                                child: Text(val['company']),
                              ),
                            ),
                            DataCell(
                              Container(
                                width: 133.3,
                                child: Text(val['stocks']),
                              ),
                            ),
                            DataCell(Container(
                              width: 150,
                              child: Row(
                                children: [
                                  ElevatedButton(
                                    child: Text('Edit'),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.blue,
                                    ),
                                    onPressed: () {
                                      nextScreen(
                                          context,
                                          EditProduct(
                                            producName: val['name'],
                                            stocks: val['stocks'],
                                            companyId: val['companyId'],
                                            companies: companies,
                                            avilability: val['avilability'],
                                            uid: val['id'],
                                          ));
                                    },
                                  ),
                                  ElevatedButton(
                                    child: Text('Delete'),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.red,
                                    ),
                                    onPressed: () {
                                      deleteProduct(val['id'], val);
                                    },
                                  ),
                                ],
                              ),
                            )),
                          ]);
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  deleteProduct(id, i) async {
    var timeDeleted = DateTime.now().millisecondsSinceEpoch.toString();
    var userDlt = await DatabaseService(uid: id).deleteProduct(id, timeDeleted);
    if (userDlt == true) {
      setState(() {
        products.remove(i);
      });
    }
  }
}
