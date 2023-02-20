import '../user_page/user_page.dart';
import 'package:flutter/material.dart';
import '../product_page/product_page.dart';
import '../../messaging_app/messaging.dart';
import '../company_page/comapany_page.dart';
import '../company_page/search_company.dart';
import 'package:flutter_features/widgets/widget.dart';
import 'package:flutter_features/pages/home_page/home_page.dart';
import 'package:flutter_features/pages/login/auth/login_page.dart';
import 'package:flutter_features/pages/login/service/auth_service.dart';

class ProfilePage extends StatefulWidget {
  List docs;
  String profilePic;
  ProfilePage({
    Key? key,
    required this.docs,
    required this.profilePic,
  }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "ProFile Page",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 27,
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 50),
          children: [
            widget.docs.first['profilePic'] == ''
                ? Icon(
                    Icons.account_circle,
                    size: 150,
                    color: Colors.grey[700],
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: Image(
                      image: NetworkImage(widget.profilePic),
                      alignment: Alignment.center,
                      height: 200,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
            const SizedBox(
              height: 15,
            ),
            Text(
              widget.docs.first['email'],
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            const Divider(
              height: 2,
            ),
            ListTile(
              onTap: () {
                nextScreen(context, HomePage());
              },
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(Icons.group),
              title: const Text(
                "Groups",
                style: TextStyle(color: Colors.black),
              ),
            ),

            // ListTile(
            //   onTap: () {},
            //   selected: true,
            //   selectedColor: Theme.of(context).primaryColor,
            //   contentPadding:
            //       const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            //   leading: const Icon(Icons.group),
            //   title: const Text(
            //     "Profile",
            //     style: TextStyle(color: Colors.black),
            //   ),
            // ),

            ListTile(
              onTap: () {
                nextScreen(context, UserPage());
              },
              // selectedColor: Theme.of(context).primaryColor,
              // selected: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(Icons.group),
              title: const Text(
                "Users",
                style: TextStyle(color: Colors.black),
              ),
            ),
            ListTile(
              onTap: () {
                nextScreen(context, ProductPage());
              },
              // selectedColor: Theme.of(context).primaryColor,
              // selected: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(Icons.group),
              title: const Text(
                "Products",
                style: TextStyle(color: Colors.black),
              ),
            ),
            ListTile(
              onTap: () {
                nextScreen(context, CompanyPage());
              },
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(Icons.group),
              title: const Text(
                "Companies",
                style: TextStyle(color: Colors.black),
              ),
            ),
            ListTile(
              onTap: () {
                nextScreen(context, CompanySearch());
              },
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(Icons.group),
              title: const Text(
                "Search Company",
                style: TextStyle(color: Colors.black),
              ),
            ),
            ListTile(
              onTap: () {
                nextScreen(context, MessagingApp());
              },
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(Icons.group),
              title: const Text(
                "CS",
                style: TextStyle(color: Colors.black),
              ),
            ),
            ListTile(
              onTap: () async {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Logout"),
                        content: const Text("Are you sure you want to logout?"),
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
                              await authService.signOut();
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()),
                                  (route) => false);
                            },
                            icon: const Icon(
                              Icons.done,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      );
                    });
              },
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(Icons.exit_to_app),
              title: const Text(
                "Logout",
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * .10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            widget.docs.first['profilePic'] == ''
                ? Icon(
                    Icons.account_circle,
                    size: 200,
                    color: Colors.grey[700],
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: Image(
                      image: NetworkImage(widget.profilePic),
                      alignment: Alignment.center,
                      height: 200,
                      width: 200,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Full Name", style: TextStyle(fontSize: 17)),
                Text(widget.docs.first['fullName'],
                    style: const TextStyle(fontSize: 17)),
              ],
            ),
            const Divider(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Email", style: TextStyle(fontSize: 17)),
                Text(
                  widget.docs.first['email'],
                  style: const TextStyle(fontSize: 17),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
