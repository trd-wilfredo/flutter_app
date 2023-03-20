import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../../widgets/widget.dart';
import '../about_us.dart';
import '../app_version.dart';
import '../company_page/add_company.dart';
import '../company_page/comapany_page.dart';
import '../company_page/edit_company.dart';
import '../company_page/search_company.dart';
import '../login/auth/login_page.dart';
import '../login/auth/register_page.dart';
import '../login/service/database_service.dart';
import '../product_page/add_product.dart';
import '../product_page/edit_product.dart';
import '../product_page/product_page.dart';
import '../tool_page/andiod_app.dart';
import '../tool_page/file_upload.dart';
import '../user_page/add_user.dart';
import '../user_page/edit_user.dart';
import '../user_page/user_page.dart';
import 'chat_page.dart';
import 'home_page.dart';
import 'table_list.dart';

class ProgressTable extends StatefulWidget {
  StatefulWidget profile;
  ProgressTable({
    Key? key,
    required this.profile,
  }) : super(key: key);

  @override
  State<ProgressTable> createState() => _ProgressTableState();
}

class _ProgressTableState extends State<ProgressTable> {
  dynamic userDocs;
  String userLink = '';
  String companyId = "";
  String profile = "";
  List companies = [];
  List docs = [];
  String email = "";
  String userName = "";
  String userLevel = "";

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  getUserData() async {
    var user =
        await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
            .getUserById();

    QuerySnapshot getAllCompany = await DatabaseService().getAllCompany();
    for (var f in getAllCompany.docs) {
      setState(() {
        companies.add({
          'company': f['companyName'],
          'companyId': f['uid'],
        });
      });
    }
    var link = await FirebaseStorage.instance
        .ref()
        .child(user.docs.first['profilePic'])
        .getDownloadURL();
    setState(() {
      profile = link;
      docs = user.docs;
      email = user.docs.first['email'];
      userName = user.docs.first['fullName'];
      userLevel = user.docs.first['level'];
      companyId = user.docs.first['companyId'];
    });
  }

  page(title, page) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 27,
          ),
        ),
      ),
      body: page,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<TableList> table_data = [
      TableList(
          page: 'Login Page',
          bar: 1.0,
          pecent: '100%',
          link: LoginPage(),
          color: Color.fromARGB(255, 229, 111, 111)),
      TableList(
          page: 'Register Page',
          bar: 1.0,
          pecent: '100%',
          link: RegisterPage(),
          color: Color.fromARGB(255, 220, 159, 61)),
      TableList(
          page: 'Profile Page',
          bar: 1.0,
          pecent: '100%',
          link: widget.profile,
          color: Color.fromARGB(255, 72, 215, 33)),
      TableList(
          page: 'User Page',
          bar: 1.0,
          pecent: '100%',
          link: UserPage(
            companyId: companyId,
            companies: companies,
            userLevel: userLevel,
          ),
          color: Color.fromARGB(255, 83, 255, 244)),
      TableList(
          page: 'Add User Page',
          bar: 1.0,
          pecent: '100%',
          link: AddUser(companies: companies),
          color: Color.fromARGB(255, 242, 112, 244)),
      TableList(
          page: 'Edit User Page',
          bar: 1.0,
          pecent: '100%',
          link: EditUser(
            valId: 'sample',
            valName: 'sample',
            companies: companies,
            valLevel: 'normal',
            valEmail: 'sample@sample.com',
            companyId: 'MvAkTeoH4W7bj7fXaKKV',
            companyName: 'company 5',
          ),
          color: Color.fromARGB(255, 51, 64, 160)),
      TableList(
          page: 'Company Page',
          bar: 1.0,
          pecent: '100%',
          link: CompanyPage(),
          color: Color.fromARGB(255, 180, 156, 156)),
      TableList(
          page: 'Add Company Page',
          bar: 1.0,
          pecent: '100%',
          link: AddCompany(),
          color: Color.fromARGB(255, 100, 29, 105)),
      TableList(
          page: 'Edit Company Page',
          bar: 1.0,
          pecent: '100%',
          link: EditCompany(
            company: 'sample',
            avilability: 'yes',
            uid: 'sample',
          ),
          color: Color.fromARGB(255, 118, 241, 145)),
      TableList(
          page: 'Product Page',
          bar: 1.0,
          pecent: '100%',
          link: ProductPage(
            companies: companies,
            companyId: companyId,
            userLevel: userLevel,
          ),
          color: Color.fromARGB(255, 234, 254, 21)),
      TableList(
          page: 'Add Product Page',
          bar: 1.0,
          pecent: '100%',
          link: AddProduct(
            companies: companies,
          ),
          color: Color.fromARGB(255, 43, 176, 132)),
      TableList(
          page: 'Edit Product Page',
          bar: 1.0,
          pecent: '100%',
          link: EditProduct(
            producName: 'sample',
            stocks: '',
            companyId: 'sample',
            companyName: 'sample',
            companies: companies,
            avilability: 'yes',
            uid: 'sample',
          ),
          color: Color.fromARGB(255, 255, 196, 35)),
      TableList(
          page: 'File Upload Page',
          bar: 1.0,
          pecent: '100%',
          link: FileUpload(),
          color: Color.fromARGB(255, 116, 116, 116)),
      TableList(
          page: 'Group List Page',
          bar: 1.0,
          pecent: '100%',
          link: HomePage(),
          color: Color.fromARGB(255, 37, 121, 100)),
      TableList(
          page: 'Chat Page',
          bar: 0.9,
          pecent: '90%',
          link: ChatPage(
            groupId: 'sample',
            groupName: 'sample',
            userName: userName,
          ),
          color: Color.fromARGB(255, 162, 255, 168)),
      TableList(
          page: 'Download App for Andriod Page',
          bar: 1.0,
          pecent: '100%',
          link: AndiodPage(),
          color: Color.fromARGB(255, 0, 0, 0)),
      TableList(
          page: 'Search Company Page',
          bar: 1.0,
          pecent: '100%',
          link: CompanySearch(),
          color: Color.fromARGB(255, 178, 152, 152)),
      TableList(
          page: 'About Us Page',
          bar: .7,
          pecent: '70%',
          link: AboutUs(),
          color: Color.fromARGB(255, 183, 169, 44)),
      TableList(
          page: 'Appversion Page',
          bar: 8.8,
          pecent: '80%',
          link: AppVersion(),
          color: Color.fromARGB(255, 74, 255, 195)),
    ];

    return DataTable(
      columns: [
        DataColumn(
          label: Text('Page'),
        ),
        DataColumn(
          label: Text('Bar'),
        ),
        DataColumn(
          label: Text('Percent'),
        ),
        // Lets add one more column to show a delete button
        DataColumn(
          label: Text('Link'),
        )
      ],
      rows: table_data
          .map(
            (tablist) => DataRow(cells: [
              DataCell(
                Text(tablist.page),
                // onTap: () {},
              ),
              DataCell(
                Container(
                  width: 145,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: tablist.color,
                    ),
                  ),
                  child: LinearProgressIndicator(
                    value: tablist.bar, // Defaults to 0.5.
                    color: tablist.color,
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
              DataCell(
                Text(tablist.pecent),
                // onTap: () {},
              ),
              DataCell(
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    child: Text(
                      'open page',
                      style:
                          TextStyle(color: Color.fromARGB(255, 77, 160, 255)),
                    ),
                    onTap: () {
                      nextScreen(context, tablist.link);
                    },
                  ),
                ),
              ),
            ]),
          )
          .toList(),
    );
  }
}
