import 'page.dart';
import 'page_card.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<PageList> pages = [
    PageList(
      part: 'null',
      page: 'login',
      title: 'Login To App',
    ),
    // PageList(
    //   part: 'null',
    //   page: 'messaging_app',
    //   title: 'Messaging App',
    // ),
    PageList(
      part: 'null',
      page: 'information_registration',
      title: 'Information Registration',
    ),
    PageList(
      part: 'null',
      page: 'company_list',
      title: 'Company List',
    ),
    PageList(
      part: 'bottom',
      page: 'profile_page',
      title: 'Profile Page',
    ),
    PageList(
      part: 'null',
      page: 'andriod_phone',
      title: 'Download For Andiod App',
    ),
    PageList(
      part: 'null',
      page: 'ios_App',
      title: 'Download For IOS App',
    ),
    PageList(
      part: 'null',
      page: 'file_upload',
      title: 'File Upload',
    ),
    // PageList(
    //   part: 'bottom',
    //   page: 'company_search',
    //   title: 'Company Search',
    // ),
    PageList(
      part: 'null',
      page: 'skill_i',
      title: 'Buttons',
    ),
    PageList(
      part: 'bottom',
      page: 'skill_ii',
      title: 'Layouts',
    ),
    PageList(
      part: 'null',
      page: 'about_us',
      title: 'About Us',
    ),
    PageList(
      part: 'null',
      page: 'work_progress',
      title: 'Work Progress',
    ),
    PageList(
      part: 'bottom',
      page: 'app_version',
      title: 'AppVersion 1.0.5',
    ),
    // PageList(
    //   part: 'null',
    //   page: 'Linux',
    //   title: 'Download for Linux App',
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 53, 53, 53),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 50.0),
              child: Column(
                children: <Widget>[
                  Container(
                    // color: Colors.cyan,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Text(
                          'Flutter Features',
                          style: TextStyle(
                            fontSize: 30.0,
                          ),
                        ),
                      ),
                    ),
                    // height: 30.0
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    constraints: BoxConstraints(maxWidth: 400),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color.fromARGB(255, 10, 0, 0),
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: pages
                          .map((page) => PageListCard(
                                pageprops: page,
                              ))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
