import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_features/widgets/widget.dart';
import 'package:flutter_features/pages/user_page/add_user.dart';
import 'package:flutter_features/pages/company_page/add_company.dart';
import 'package:flutter_features/pages/product_page/add_product.dart';

import '../login/service/database_service.dart';

class InfoRegister extends StatefulWidget {
  const InfoRegister({super.key});

  @override
  State<InfoRegister> createState() => _InfoRegisterState();
}

class _InfoRegisterState extends State<InfoRegister> {
  List companies = [];
  @override
  void initState() {
    super.initState();
    getAllCompany();
  }

  getAllCompany() async {
    QuerySnapshot getAllCompany = await DatabaseService().getAllCompany();
    for (var f in getAllCompany.docs) {
      setState(() {
        companies.add({
          'company': f['companyName'],
          'companyId': f['uid'],
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  nextScreen(context, AddUser());
                },
                child: Text('Add User'),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  nextScreen(context, AddCompany());
                },
                child: Text('Add Company'),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  nextScreen(
                      context,
                      AddProduct(
                        companies: companies,
                      ));
                },
                child: Text('Add Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
