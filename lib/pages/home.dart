import 'package:flutter/material.dart';
import 'page.dart';
import 'page_card.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<PageList> pages = [
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
      page: 'messaging_app',
      title: 'Messaging App',
    ),
    PageList(
      part: 'null',
      page: 'fall_queen',
      title: 'Fall Queen',
    ),
    PageList(
      part: 'null',
      page: 'github_monitoring',
      title: 'Github Monitoring',
    ),
    PageList(
      part: 'null',
      page: 'cv',
      title: 'Sample CV',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
