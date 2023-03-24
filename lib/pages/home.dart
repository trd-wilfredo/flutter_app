import 'page.dart';
import 'page_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        barPecent: 1,
        percent: "100%"),
    // PageList(
    //   part: 'null',
    //   page: 'messaging_app',
    //   title: 'Messaging App',
    // ),
    PageList(
        part: 'null',
        page: 'information_registration',
        title: 'Information Registration',
        barPecent: 0.90,
        percent: "90%"),
    PageList(
        part: 'null',
        page: 'company_list',
        title: 'Company List',
        barPecent: 0.80,
        percent: "80%"),
    PageList(
        part: 'bottom',
        page: 'profile_page',
        title: 'Profile Page',
        barPecent: 0.80,
        percent: "80%"),
    PageList(
        part: 'null',
        page: 'andriod_phone',
        title: 'Download For Andiod App',
        barPecent: 1,
        percent: "100%"),
    PageList(
        part: 'null',
        page: 'ios_App',
        title: 'Download For IOS App',
        barPecent: 0.5,
        percent: "50%"),
    PageList(
        part: 'null',
        page: 'file_upload',
        title: 'File Upload',
        barPecent: 100,
        percent: "100%"),
    // PageList(
    //   part: 'bottom',
    //   page: 'company_search',
    //   title: 'Company Search',
    // ),
    PageList(
        part: 'null',
        page: 'skill_i',
        title: 'Buttons',
        barPecent: 1,
        percent: "100%"),
    PageList(
        part: 'bottom',
        page: 'skill_ii',
        title: 'Layouts',
        barPecent: 1,
        percent: "100"),
    PageList(
        part: 'null',
        page: 'about_us',
        title: 'About Us',
        barPecent: 0.5,
        percent: "50%"),
    PageList(
        part: 'null',
        page: 'work_progress',
        title: 'Work Progress',
        barPecent: 1,
        percent: "100%"),
    PageList(
        part: 'bottom',
        page: 'app_version',
        title: 'AppVersion 1.1.05',
        barPecent: 0.7,
        percent: "70%"),
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
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
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
                              style: GoogleFonts.getFont(
                                'Fredoka One',
                                fontSize: 30.0,
                              ),
                            ),
                          ),
                        ),
                        // height: 30.0
                      ),
                      SizedBox(height: 10.0),
                      Padding(
                        padding: EdgeInsets.only(left: 20.0, bottom: 20.0),
                        child: Container(
                          constraints: BoxConstraints(maxWidth: 650),
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
                      ),
                      Row(
                        children: [],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
