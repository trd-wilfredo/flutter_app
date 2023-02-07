import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_features/pages/login/service/database_service.dart';

class CompanyInfoPage extends StatefulWidget {
  final String uid;
  final String companyName;
  const CompanyInfoPage(
      {Key? key, required this.uid, required this.companyName})
      : super(key: key);

  @override
  State<CompanyInfoPage> createState() => _CompanyInfoPageState();
}

class _CompanyInfoPageState extends State<CompanyInfoPage> {
  Stream<QuerySnapshot>? companyName;

  @override
  void initState() {
    getCompanyName();
    super.initState();
  }

  getCompanyName() {
    DatabaseService().gettingCompanyInfo(widget.uid).then((val) {
      setState(() {
        companyName = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(widget.companyName),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: Text(widget.companyName + " Information here"),
      ),
    );
  }
}
