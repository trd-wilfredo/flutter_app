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
    PageList(part: 'null', page: 'splash_login_3_1'),
    PageList(part: 'null', page: 'splash_login_4_2'),
    PageList(part: 'null', page: 'splash_login_5_1'),
    PageList(part: 'null', page: 'signup'),
    PageList(part: 'null', page: 'index'),
    PageList(part: 'null', page: 'card'),
    PageList(part: 'null', page: 'main_message_all'),
    PageList(part: 'null', page: 'graph_page'),
    PageList(part: 'bottom', page: 'google_link'),
    PageList(part: 'null', page: 'tenpo_menu'),
    PageList(part: 'null', page: 'tenpo_menu_list'),
    PageList(part: 'bottom', page: 'store_user_info_1_6'),
    PageList(part: 'null', page: 'tenpo_menu_coupon_9'),
    PageList(part: 'null', page: 'store_user_information_picture'),
    PageList(part: 'null', page: 'coupon_detail_01'),
    PageList(part: 'bottom', page: 'coupon_usage_inquiry'),
    PageList(part: 'null', page: 'map'),
    PageList(part: 'null', page: 'mental_check'),
    PageList(part: 'null', page: 'quest_view_00'),
    PageList(part: 'null', page: 'quest_view_01'),
    PageList(part: 'null', page: 'main_record_1'),
    PageList(part: 'null', page: 'main_record_3'),
    PageList(part: 'null', page: 'main_record_4'),
    PageList(part: 'null', page: 'questioneare_02'),
    PageList(part: 'bottom', page: 'medical_check'),
    PageList(part: 'null', page: 'bank_branch_store_information'),
    PageList(part: 'null', page: 'record_walk'),
    PageList(part: 'null', page: 'special_coupon_1'),
    PageList(part: 'bottom', page: 'special_coupon_7'),
    PageList(part: 'null', page: 'stamp_seal'),
    PageList(part: 'null', page: 'benefits_note'),
    PageList(part: 'null', page: 'change_benefits'),
    PageList(part: 'null', page: 'confirm_benefits'),
    PageList(part: 'null', page: 'used_benefits'),
    PageList(part: 'bottom', page: 'local_tickets'),
    PageList(part: 'null', page: 'guide'),
    PageList(part: 'null', page: 'FAQ'),
    PageList(part: 'null', page: 'lp'),
    PageList(part: 'bottom', page: 'lp_web_event'),
    PageList(part: 'null', page: 'stamp_rally'),
    PageList(part: 'null', page: 'stress_check'),
    PageList(part: 'null', page: 'smoking_check'),
    PageList(part: 'bottom', page: 'kfg_menu')
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
                child: Column(children: <Widget>[
                  Container(
                    // color: Colors.cyan,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Text(
                          'NTT Health Mockup Menu',
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
                                  color: Color.fromARGB(255, 10, 0, 0)))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: pages
                            .map(
                                (page) => PageListCard(title: page, part: page))
                            .toList(),
                      ))
                ]),
              ))),
    ));
  }
}
