import 'package:flutter/material.dart';
import 'package:flutter_features/widgets/widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_features/pages/home_page/chat_page.dart';
import 'package:flutter_features/pages/login/service/database_service.dart';

class GroupTile extends StatefulWidget {
  final String userName;
  final String groupId;
  final String groupName;
  final List url;
  final dynamic fonts;
  final dynamic myID;
  const GroupTile(
      {Key? key,
      required this.groupId,
      required this.groupName,
      required this.url,
      required this.fonts,
      required this.myID,
      required this.userName})
      : super(key: key);

  @override
  State<GroupTile> createState() => _GroupTileState();
}

class _GroupTileState extends State<GroupTile> {
  bool seen = false;
  @override
  void initState() {
    super.initState();
    gettingMsgData();
  }

  gettingMsgData() async {
    var chatData =
        await DatabaseService().getChatData(widget.groupId, widget.myID);
    setState(() {
      seen = chatData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        nextScreen(
            context,
            ChatPage(
              chatId: widget.groupId,
              chatedDM: '',
              groupName: widget.groupName,
              userName: widget.userName,
              fonts: widget.fonts,
            ));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Theme.of(context).primaryColor,
            child: Text(
              widget.groupName.substring(0, 1).toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ),
          title: seen
              ? Text(
                  widget.groupName,
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              : Text(
                  widget.groupName,
                  style: TextStyle(
                      color: Colors.orange, fontWeight: FontWeight.w900),
                ),
          subtitle: Text(
            "Join the conversation as ${widget.userName}",
            style: const TextStyle(fontSize: 13),
          ),
        ),
      ),
    );
  }
}
