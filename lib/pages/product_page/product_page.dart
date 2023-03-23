import 'package:firebase_dart/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_features/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_features/pages/product_page/add_product.dart';
import 'package:flutter_features/pages/product_page/edit_product.dart';
import 'package:flutter_features/pages/login/service/database_service.dart';

class ProductPage extends StatefulWidget {
  List companies = [];
  String companyId = "";
  String userLevel = "";
  ProductPage(
      {Key? key,
      required this.companies,
      required this.companyId,
      required this.userLevel})
      : super(key: key);

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
  String uid = '';
  @override
  void initState() {
    super.initState();
    gettingAllProduct();
  }

  gettingAllProduct() async {
    print(widget.companyId);
    QuerySnapshot snapshot = await DatabaseService(uid: uid)
        .getAllProduct(widget.companyId, widget.userLevel);
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
                      companies: widget.companies,
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
                          // if (false)
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
                          return DataRow(
                            cells: [
                              DataCell(
                                Container(
                                  width: 133.3,
                                  child: Text(val['name']),
                                ),
                              ),
                              // if (false)
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
                              DataCell(
                                Container(
                                  width: 150,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.edit, size: 15),
                                        onPressed: () {
                                          nextScreen(
                                              context,
                                              EditProduct(
                                                producName: val['name'],
                                                stocks: val['stocks'],
                                                companyId: val['companyId'],
                                                companyName: val['company'],
                                                companies: widget.companies,
                                                avilability: val['avilability'],
                                                uid: val['id'],
                                              ));
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete, size: 15),
                                        onPressed: () {
                                          showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: const Text("Delete"),
                                                content: const Text(
                                                    "Are you sure you want to delete this product?"),
                                                actions: [
                                                  IconButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    icon: const Icon(
                                                      Icons.cancel,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                  IconButton(
                                                    onPressed: () async {
                                                      deleteProduct(
                                                          val['id'], val);
                                                    },
                                                    icon: const Icon(
                                                      Icons.done,
                                                      color: Colors.green,
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
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
