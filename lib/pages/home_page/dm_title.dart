import 'package:flutter/material.dart';
import '../../widgets/widget.dart';
import '../tool_page/page.dart';
import 'chat_page.dart';

class DMTitle extends StatefulWidget {
  dynamic fonts;
  String dmId;
  dynamic data;
  String chatTo;
  DMTitle({
    Key? key,
    required this.fonts,
    required this.dmId,
    required this.data,
    required this.chatTo,
  }) : super(key: key);
  @override
  State<DMTitle> createState() => _DMTitleState();
}

class _DMTitleState extends State<DMTitle> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        nextScreen(
            context,
            ChatPage(
              chatId: widget.dmId,
              chatedDM: '',
              groupName: widget.chatTo,
              fonts: widget.fonts,
              userName: widget.data['fullName'],
            ));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Theme.of(context).primaryColor,
            child: Text(
              widget.chatTo.substring(0, 1).toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ),
          title: Text(
            widget.chatTo,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          // subtitle: Text(
          //   "Join the conversation as ${widget.data['fallName']}",
          //   style: const TextStyle(fontSize: 13),
          // ),
        ),
      ),
    );
  }
}
