import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_features/widgets/widget.dart';
import 'package:flutter_features/pages/user_page/add_user.dart';
import 'package:flutter_features/pages/user_page/edit_user.dart';
import 'package:flutter_features/pages/login/service/database_service.dart';

class UserPage extends StatefulWidget {
  List companies = [];
  String companyId = "";
  String userLevel = "";
  UserPage(
      {Key? key,
      required this.companies,
      required this.companyId,
      required this.userLevel})
      : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  bool _isLoading = false;
  final formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String level = '';
  String fullname = '';
  String company = '';
  List users = [];
  String uid = '';
  @override
  void initState() {
    super.initState();
    gettingAllUser();
  }

  gettingAllUser() async {
    QuerySnapshot snapshot =
        await DatabaseService().getAllUser(widget.companyId, widget.userLevel);

    for (var f in snapshot.docs) {
      setState(() {
        users.add({
          'id': f['uid'],
          'name': f['fullName'],
          'company': f['company'],
          'companyId': f['companyId'],
          'level': f['level'],
          'email': f['email'],
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
              child: Text('Add User'),
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
              ),
              onPressed: () {
                nextScreen(context, AddUser(companies: widget.companies));
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
                            label: Expanded(
                              child: Text(
                                'Action',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                        rows: users.map((val) {
                          return DataRow(cells: [
                            DataCell(
                              Container(
                                width: 200,
                                child: Text(val['name']),
                              ),
                            ),
                            DataCell(
                              Container(
                                width: 200,
                                child: Text(val['company']),
                              ),
                            ),
                            DataCell(
                              Container(
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
                                            EditUser(
                                              valId: val['id'],
                                              valName: val['name'],
                                              companies: widget.companies,
                                              valLevel: val['level'],
                                              valEmail: val['email'],
                                              companyId: val['companyId'],
                                              companyName: val['company'],
                                            ));
                                      },
                                    ),
                                    ElevatedButton(
                                      child: Text('Delete'),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.red,
                                      ),
                                      onPressed: () {
                                        deleteUser(val['id'], val);
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
            ),
          ),
        ],
      ),
    );
  }

  deleteUser(id, i) async {
    var timeDeleted = DateTime.now().millisecondsSinceEpoch.toString();
    var userDlt = await DatabaseService(uid: id).deleteUser(id, timeDeleted);
    if (userDlt == true) {
      setState(() {
        users.remove(i);
      });
    }
  }
}
