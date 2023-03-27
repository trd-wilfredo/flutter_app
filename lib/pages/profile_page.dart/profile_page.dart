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
  List user;
  String profilePic;
  ProfilePage({
    Key? key,
    required this.user,
    required this.profilePic,
  }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * .10,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 30,
          ),
          widget.user.first['profilePic'] == ''
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
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Full Name", style: TextStyle(fontSize: 17)),
              Text(widget.user.first['fullName'],
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
                widget.user.first['email'],
                style: const TextStyle(fontSize: 17),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
