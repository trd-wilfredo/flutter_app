import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class MessageTile extends StatefulWidget {
  final String message;
  final String sender;
  final String senderUid;
  final bool sentByMe;
  const MessageTile({
    Key? key,
    required this.message,
    required this.sender,
    required this.sentByMe,
    required this.senderUid,
  }) : super(key: key);

  @override
  State<MessageTile> createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
  final storage = FirebaseStorage.instance.ref();
  String url = "";

  @override
  Widget build(BuildContext context) {
    storage
        .child('profile/${widget.senderUid}')
        .getDownloadURL()
        .then((value) => {
              setState(() {
                url = value;
              })
            });
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(
              top: 4,
              bottom: 4,
              left: widget.sentByMe ? 0 : 24,
              right: widget.sentByMe ? 24 : 0),
          alignment:
              widget.sentByMe ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: widget.sentByMe
                ? const EdgeInsets.only(left: 30)
                : const EdgeInsets.only(right: 30),
            padding:
                const EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
            decoration: BoxDecoration(
              borderRadius: widget.sentByMe
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    )
                  : const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
              color: widget.sentByMe
                  ? Theme.of(context).primaryColor
                  : Colors.grey[700],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.sender.toUpperCase(),
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: -0.5),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(widget.message,
                    textAlign: TextAlign.start,
                    style: const TextStyle(fontSize: 16, color: Colors.white))
              ],
            ),
          ),
        ),
        Container(
            alignment: Alignment.centerLeft,
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: 20),
              child: widget.sentByMe
                  ? CircleAvatar(
                      radius: 0,
                      backgroundImage: NetworkImage(url),
                    )
                  : CircleAvatar(
                      backgroundImage: NetworkImage(url),
                      radius: 20,
                    ),
            )),
      ],
    );
  }
}
