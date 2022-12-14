import 'package:flutter/material.dart';
import 'page.dart';

class PageListCard extends StatelessWidget {
  final PageList pageprops;
  PageListCard({
    required this.pageprops,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey),
          left: BorderSide(color: Colors.grey),
          bottom: pageprops.part == 'bottom'
              ? BorderSide(color: Color.fromRGBO(0, 0, 0, 1), width: 3.0)
              : BorderSide(color: Color.fromARGB(0, 255, 255, 255)),
          right: BorderSide(color: Colors.grey),
        ),
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          alignment: Alignment.centerLeft,
          primary: Colors.black, // foreground
        ),
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/' + pageprops.page,
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 0.0, bottom: 0.0),
          child: Text(
            pageprops.title,
          ),
        ),
      ),
      height: 40.0,
    );
  }
}
