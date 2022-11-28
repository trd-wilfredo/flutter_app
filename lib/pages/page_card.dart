import 'dart:html';
import 'package:flutter/material.dart';
import 'page.dart';

class PageListCard extends StatelessWidget {
  final PageList title;
  final PageList part;
  PageListCard({required this.title, required this.part});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(color: Colors.grey),
                left: BorderSide(color: Colors.grey),
                bottom: title.part == 'bottom'
                    ? BorderSide(color: Color.fromRGBO(0, 0, 0, 1), width: 3.0)
                    : BorderSide(color: Color.fromARGB(0, 255, 255, 255)),
                right: BorderSide(color: Colors.grey))),
        child: Padding(
            padding: EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
            child: Text(
              title.page,
            )),
        height: 30.0);
  }
}
