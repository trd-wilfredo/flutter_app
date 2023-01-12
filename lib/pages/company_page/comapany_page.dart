import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_features/pages/company_page/add_company.dart';
import 'package:flutter_features/pages/login/service/database_service.dart';
import 'package:flutter_features/pages/product_page/add_product.dart';
import 'package:flutter_features/widgets/widget.dart';

class CompanyPage extends StatefulWidget {
  const CompanyPage({Key? key}) : super(key: key);

  @override
  State<CompanyPage> createState() => _CompanyPageState();
}

class _CompanyPageState extends State<CompanyPage> {
  bool _isLoading = false;
  final formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String level = '';
  String fullname = '';
  String company = '';
  List companies = [];
  List setCompany = [];
  @override
  void initState() {
    super.initState();
    gettingAllCompany();
  }

  gettingAllCompany() async {
    QuerySnapshot snapshot = await DatabaseService().getAllCompany();
    snapshot.docs.forEach(
      (f) => {
        setCompany.add({
          'name': f['companyName'],
        }),
      },
    );
    setState(() {
      companies = setCompany;
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
          'Company Page',
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
                child: Text('Add Company'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                ),
                onPressed: () {
                  nextScreen(context, AddCompany());
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
                          label: Expanded(
                            child: Text(
                              'Action',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                      rows: companies.map((val) {
                        print(['sdfasf', val]);
                        return DataRow(cells: [
                          DataCell(Text(val['name'])),
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
