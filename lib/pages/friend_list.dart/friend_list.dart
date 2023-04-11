import 'package:flutter/material.dart';

class FriendList extends StatefulWidget {
  List friends = [];
  FriendList({Key? key, required this.friends}) : super(key: key);

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
            ListTile(
              title: Text(widget.friends[i]),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: Text('Load More'),
                onPressed: () {
                  setState(() {
                    currentIndex += increment;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
