import 'page.dart';
import 'package:flutter/material.dart';

class PageListCard extends StatelessWidget {
  final PageList pageprops;
  PageListCard({
    required this.pageprops,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 400,
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
        ),
        Container(
          width: 15,
        ),
        Container(
          width: 145,
          height: 30,
          decoration: BoxDecoration(
            border: Border.all(
              color: Color.fromARGB(255, 10, 0, 0),
            ),
          ),
          child: LinearProgressIndicator(
            value: pageprops.barPecent, // Defaults to 0.5.
            color: Color.fromARGB(255, 0, 0, 0),
            backgroundColor: Colors.white,
          ),
        ),
        Container(
          width: 5,
        ),
        Text(pageprops.percent)
      ],
    );
  }
}
