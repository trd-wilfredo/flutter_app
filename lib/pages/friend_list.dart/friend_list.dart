import 'package:flutter/material.dart';
import '../../widgets/widget.dart';
import '../home_page/chat_page.dart';

class FriendList extends StatefulWidget {
  List friends = [];
  final Function onTrigger;
  dynamic fonts;
  dynamic user;
  List chated;
  FriendList(
      {Key? key,
      required this.friends,
      required this.fonts,
      required this.user,
      required this.chated,
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
    print(widget);
    return Container(
      child: Column(
        children: [
          for (var i = currentIndex;
              i < currentIndex + increment && i < widget.friends.length;
              i++)
            GestureDetector(
              onTap: () {
                var dmID = widget.chated.contains(widget.friends[i]['uid'])
                    ? widget.friends[i]
                        ['uid'] //  change this to actual DM chat ID
                    : 'createDMId';
                // get dm Id
                widget.onTrigger();
                nextScreen(
                  context,
                  ChatPage(
                    chatId: dmID,
                    chatedDM: widget.friends[i]['uid'],
                    groupName: widget.friends[i]['fullName'],
                    fonts: widget.fonts,
                    userName: widget.user[i]['fullName'],
                  ),
                );
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
