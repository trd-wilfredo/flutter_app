import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_features/pages/login/service/database_service.dart';
import 'package:flutter_features/pages/product_page/add_product.dart';
import 'package:flutter_features/pages/user_page/add_user.dart';
import 'package:flutter_features/widgets/widget.dart';

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
  List setProduct = [];
  @override
  void initState() {
    super.initState();
    gettingAllProduct();
  }

  gettingAllProduct() async {
    QuerySnapshot snapshot = await DatabaseService().getAllProduct();
    snapshot.docs.forEach(
      (f) => {
        setProduct.add({
          'name': f['productName'],
          'company': f['companyName'],
          'stocks': f['stocks'],
        }),
      },
    );
    setState(() {
      products = setProduct;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'Product Page',
          style: TextStyle(
            color: Colors.white,
            fontSize: 27,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
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
                  nextScreen(context, AddProduct());
                },
              ),
            ),
            Container(
              height: 500,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(top: 50.0),
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
                        print(['sdfasf', val]);
                        return DataRow(cells: [
                          DataCell(Text(val['name'])),
                          DataCell(Text(val['company'])),
                          DataCell(Text(val['stocks'])),
                          DataCell(
                            Row(
                              children: [
                                ElevatedButton(
                                  child: Text('Edit'),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.blue,
                                  ),
                                  onPressed: () {
                                    // nextScreen(context, AddUser());
                                  },
                                ),
                                ElevatedButton(
                                  child: Text('Delete'),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.red,
                                  ),
                                  onPressed: () {
                                    // nextScreen(context, AddUser());
                                  },
                                ),
                              ],
                            ),
                          ),
                        ]);
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}