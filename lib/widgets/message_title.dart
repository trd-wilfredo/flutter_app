import 'package:flutter/material.dart';
import '../pages/login/service/database_service.dart';
import 'package:flutter_features/pages/tool_page/custom.dart';

class MessageTile extends StatefulWidget {
  final String message;
  final String sender;
  final String senderUid;
  final String url;
  final List attachment;
  final String date;
  final String messageID;
  final String groupId;
  final String seenBy;
  final bool seen;
  final String seentime;
  final bool sentByMe;
  const MessageTile({
    Key? key,
    required this.message,
    required this.seenBy,
    required this.seen,
    required this.sender,
    required this.attachment,
    required this.date,
    required this.sentByMe,
    required this.groupId,
    required this.senderUid,
    required this.messageID,
    required this.seentime,
    required this.url,
  }) : super(key: key);

  @override
  State<MessageTile> createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
  bool moreOnMessage = false;
  bool seen = false;
  List<String> list = <String>['delete', 'unsent'];

  @override
  Widget build(BuildContext context) {
    var date = DateTime.fromMillisecondsSinceEpoch(int.parse(widget.date));
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
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  // show seen on click message
                  setState(() {
                    seen = !seen;
                  });
                },
                onLongPress: () {
                  popUpDialog(context, {
                    'messageId': widget.messageID,
                    'groupId': widget.groupId,
                    'messageSet': list
                  });
                  setState(() {
                    moreOnMessage = true;
                  });
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * .95,
                  child: Container(
                    alignment: widget.sentByMe
                        ? Alignment.topRight
                        : Alignment.topLeft,
                    child: Container(
                      margin: widget.sentByMe
                          ? EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * .15)
                          : EdgeInsets.only(
                              right: MediaQuery.of(context).size.width * .15),
                      padding: const EdgeInsets.only(
                          top: 17, bottom: 17, left: 15, right: 10),
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
                          Text(
                            widget.message,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                fontSize: 16, color: Colors.white),
                          ),
                          for (var image in widget.attachment)
                            if (image.contains('https'))
                              GestureDetector(
                                child: Hero(
                                  tag: 'imageHero',
                                  child: Image(
                                    image: NetworkImage(image),
                                    alignment: Alignment.center,
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return DetailScreen(
                                      image: image,
                                    );
                                  }));
                                },
                              ),
                          Text(
                            date.toString(),
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                                fontSize: 9, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              seen && widget.seen
                  ? Container(
                      alignment: widget.sentByMe
                          ? Alignment.topRight
                          : Alignment.topLeft,
                      margin: widget.sentByMe
                          ? EdgeInsets.only(left: 5)
                          : EdgeInsets.only(right: 5),
                      padding: const EdgeInsets.only(
                          top: 17, bottom: 17, left: 0, right: 0),
                      child: widget.seenBy == ""
                          ? Text(
                              textAlign: TextAlign.start,
                              'Sent',
                            )
                          : Text(
                              textAlign: TextAlign.start,
                              'Seen By ${widget.seenBy} ${widget.seentime}',
                            ),
                    )
                  : SizedBox(
                      width: 0,
                    ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: 20),
            child: widget.sentByMe
                ? CircleAvatar(
                    radius: 0,
                    backgroundImage: NetworkImage('na'),
                  )
                : (widget.url == "na"
                    ? CircleAvatar(
                        backgroundImage: AssetImage(
                            Costum.web ? 'assets/image_2.jpg' : 'image_2.jpg'),
                        radius: 20,
                      )
                    : CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(widget.url),
                      )),
          ),
        ),
      ],
    );
  }
}

delete(messageId, groupId) async {
  var timeDeleted = DateTime.now().millisecondsSinceEpoch.toString();
  await DatabaseService().deleteMessage(groupId, messageId, timeDeleted);
}

popUpDialog(BuildContext context, dynamic messageifo) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      // ignore: no_leading_underscores_for_local_identifiers
      void _toggleDialogdWidget() {
        Navigator.of(context).pop();
      }

      return StatefulBuilder(
        builder: ((context, setState) {
          return Container(
            width: 120,
            child: Stack(
              children: <Widget>[
                AlertDialog(
                  content: Container(
                    child: DropdownButton<String>(
                      icon: const Icon(Icons.more_horiz_outlined),
                      elevation: 16,
                      underline: Container(
                        height: 2,
                      ),
                      onChanged: (String? value) {
                        if (value == "delete") {}
                        delete(messageifo['messageId'], messageifo['groupId']);
                        _toggleDialogdWidget();
                      },
                      items: messageifo['messageSet']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Positioned(
                  top: (MediaQuery.of(context).size.height / 2) - 45,
                  right: (MediaQuery.of(context).size.width / 2) - 150,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.close,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      );
    },
  );
}

class DetailScreen extends StatelessWidget {
  final String image;
  const DetailScreen({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Hero(
            tag: 'image',
            child: Image.network(
              image,
            ),
          ),
        ),
      ),
    );
  }
}
