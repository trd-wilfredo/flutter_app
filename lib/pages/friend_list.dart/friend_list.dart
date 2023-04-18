import 'package:flutter/material.dart';
import '../../widgets/widget.dart';
import '../home_page/chat_page.dart';

class FriendList extends StatefulWidget {
  List friends = [];
  final Function onTrigger;
  dynamic fonts;
  dynamic user;
  FriendList(
      {Key? key,
      required this.friends,
      required this.fonts,
      required this.user,
      required this.onTrigger})
      : super(key: key);

  @override
  State<FriendList> createState() => _FriendListState();
}

class _FriendListState extends State<FriendList> {
  int currentIndex = 0;
  int increment = 10;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          for (var i = currentIndex;
              i < currentIndex + increment && i < widget.friends.length;
              i++)
            GestureDetector(
              onTap: () {
                widget.onTrigger();
                nextScreen(
                    context,
                    ChatPage(
                      chatId: widget.user.first['uid'] +
                          '_' +
                          widget.friends[i]['uid'],
                      groupName: widget.friends[i]['fullName'],
                      fonts: widget.fonts,
                      userName: widget.user[i]['fullName'],
                    ));
              },
              child: Container(
                height: 60,
                alignment: Alignment(-1.0, -1.0),
                child: Text(
                  widget.friends[i]['fullName'],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
