import 'package:flutter/material.dart';
import '../tool_page/page.dart';

class DMTitle extends StatefulWidget {
  dynamic fonts;
  String name;
  DMTitle({
    Key? key,
    required this.fonts,
    required this.name,
  }) : super(key: key);
  @override
  State<DMTitle> createState() => _DMTitleState();
}

class _DMTitleState extends State<DMTitle> {
  @override
  Widget build(BuildContext context) {
    return page(
        widget.name,
        Container(
          child: Text('sdfasdg'),
        ));
  }
}
