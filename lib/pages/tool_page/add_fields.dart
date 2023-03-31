import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../login/service/database_service.dart';
import 'page.dart';

class AddFields extends StatefulWidget {
  String companyId = "";
  String userLevel = "";
  AddFields({
    Key? key,
    required this.userLevel,
    required this.companyId,
  }) : super(key: key);

  @override
  State<AddFields> createState() => _AddFieldsState();
}

class _AddFieldsState extends State<AddFields> {
  List users = [];
  @override
  void initState() {
    super.initState();
    gettingAllUser();
  }

  gettingAllUser() async {
    QuerySnapshot snapshot =
        await DatabaseService().getAllUser(widget.companyId, widget.userLevel);

    setState(() {
      users = snapshot.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return page(
        "Add Field",
        Container(
          child: Column(
            children: [
              Container(
                child: Row(
                  children: [
                    Text('Add Field'),
                    ElevatedButton(
                      onPressed: () async {
                        for (var user in users) {
                          await DatabaseService().addField(user['uid']);
                        }
                      },
                      child: Text('add'),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
