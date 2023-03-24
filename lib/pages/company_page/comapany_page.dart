import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_features/widgets/widget.dart';
import 'package:flutter_features/pages/company_page/add_company.dart';
import 'package:flutter_features/pages/company_page/edit_company.dart';
import 'package:flutter_features/pages/login/service/database_service.dart';

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
  @override
  void initState() {
    super.initState();
    gettingAllCompany();
  }

  gettingAllCompany() async {
    QuerySnapshot snapshot = await DatabaseService().getAllCompany();

    for (var f in snapshot.docs) {
      setState(() {
        companies.add({
          'name': f['companyName'],
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
                      return DataRow(cells: [
                        DataCell(
                          Container(
                            width: 400,
                            child: Text(val['name']),
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
                                        EditCompany(
                                          company: val['name'],
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
                                              "Are you sure you want to delete this company?"),
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
                                                ;
                                                deleteCompany(val['id'], val);
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
                      ]);
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  deleteCompany(id, i) async {
    var timeDeleted = DateTime.now().millisecondsSinceEpoch.toString();
    var userDlt = await DatabaseService(uid: id).deleteCompany(id, timeDeleted);
    if (userDlt == true) {
      setState(() {
        companies.remove(i);
      });
    }
  }
}
