import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_features/widgets/widget.dart';
import 'package:flutter_features/pages/user_page/add_user.dart';
import 'package:flutter_features/pages/user_page/edit_user.dart';
import 'package:flutter_features/pages/login/service/database_service.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

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
  @override
  void initState() {
    super.initState();
    gettingAllUser();
  }

  gettingAllUser() async {
    QuerySnapshot snapshot = await DatabaseService().getAllUser();
    for (var f in snapshot.docs) {
      setState(() {
        users.add({
          'id': f['uid'],
          'name': f['fullName'],
          'company': f['company'],
          'level': f['level'],
          'email': f['email'],
        });
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
          'User Page',
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
                child: Text('Add User'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                ),
                onPressed: () {
                  nextScreenReplace(context, AddUser());
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
                          DataCell(Text(val['name'])),
                          DataCell(Text(val['company'])),
                          DataCell(
                            Row(
                              children: [
                                ElevatedButton(
                                  child: Text('Edit'),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.blue,
                                  ),
                                  onPressed: () {
                                    nextScreenReplace(
                                        context,
                                        EditUser(
                                          valName: val['name'],
                                          valId: val['id'],
                                          valCompany: val['company'],
                                          valLevel: val['level'],
                                          valEmail: val['email'],
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
