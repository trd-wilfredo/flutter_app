import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_features/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_features/widgets/message_title.dart';
import 'package:flutter_features/pages/home_page/group_info.dart';
import '../tool_page/fire_storage.dart/fire_storage_service.dart';
import 'package:flutter_features/pages/login/service/database_service.dart';

class ChatPage extends StatefulWidget {
  final String chatId;
  final String groupName;
  final String userName;
  final String chatedDM;
  final dynamic fonts;
  const ChatPage(
      {Key? key,
      required this.chatId,
      required this.groupName,
      required this.chatedDM,
      required this.userName,
      required this.fonts})
      : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  Stream<QuerySnapshot>? chats;
  TextEditingController messageController = TextEditingController();
  FocusNode myFocusNode = FocusNode();
  String admin = "";
  String uid = "";
  String url = "";
  String chatedName = "";
  List imgurl = [];
  dynamic membersNameId;
  List<XFile>? images = [];
  final storage = FirebaseStorage.instance.ref();
  String chatId = '';
  @override
  void initState() {
    getChatandAdmin();
    super.initState();
  }

  getChatandAdmin() async {
    // if not dm
    if (widget.chatId != 'createDMId' && chatId == '') {
      setState(() {
        chatId = widget.chatId;
      });
      var membersImgUrl = await DatabaseService().getMembers(chatId);
      var members = await DatabaseService().getMembersdata(chatId);
      setState(() {
        imgurl = membersImgUrl;
        membersNameId = members;
      });
      var getUser = FirebaseAuth.instance.currentUser;
      DatabaseService().getChats(chatId).then((val) {
        setState(() {
          chats = val;
          uid = getUser!.uid;
        });
      });
      DatabaseService().getChatAdmin(chatId).then((val) {
        setState(() {
          admin = val;
        });
      });
    }
    // var you = await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
    //     .getUserById();
    // print(widget.chatedDM);
    if (widget.chatedDM != '') {
      var chted = await DatabaseService(uid: widget.chatedDM).getUserById();
      setState(() {
        chatedName = chted.docs.first['fullName'];
      });
      //   print([chted.docs.first['fullName'], you.docs.first['fullName']]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(widget.groupName),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            onPressed: () {
              nextScreen(
                context,
                GroupInfo(
                  groupId: chatId,
                  groupName: widget.groupName,
                  fonts: widget.fonts,
                  adminName: admin,
                ),
              );
            },
            icon: const Icon(Icons.info),
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          // chat messages here
          chatMessages(),

          Container(
            alignment: Alignment.bottomCenter,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey[700],
                  child: Row(children: [
                    Expanded(
                      child: TextFormField(
                        onFieldSubmitted: (value) {
                          sendMessage(images, chatedName);
                        },
                        controller: messageController,
                        focusNode: myFocusNode,
                        style:
                            const TextStyle(color: Colors.white, height: 2.0),
                        decoration: const InputDecoration(
                          hintText: "Send a message...",
                          hintStyle:
                              TextStyle(color: Colors.white, fontSize: 16),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (kIsWeb) {
                          var files = await ImagePicker().pickMultiImage();
                          if (files != null && files.length <= 7) {
                            setState(() {
                              images = files;
                            });
                          }
                        } else {
                          await Permission.photos.request();
                          var permissionStatus = await Permission.photos.status;
                          if (permissionStatus.isGranted) {
                            var files = await ImagePicker().pickMultiImage();
                            if (files != null && files.length <= 7) {
                              setState(() {
                                images = files;
                              });
                            }
                          } else {
                            print(
                                'Permission not granted. Try Again with permission access');
                          }
                        }
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Center(
                            child: Icon(
                          Icons.image,
                          color: Colors.white,
                        )),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        sendMessage(images, chatedName);
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Center(
                            child: Icon(
                          Icons.send,
                          color: Colors.white,
                        )),
                      ),
                    )
                  ]),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey[700],
                  child: Row(
                    children: [
                      for (var image in images!)
                        Container(
                          width: 120,
                          child: Stack(
                            children: <Widget>[
                              Image(
                                image: NetworkImage(image.path),
                                alignment: Alignment.center,
                                height: 100,
                                width: 100,
                                fit: BoxFit.fitWidth,
                              ),
                              Positioned(
                                top: 0,
                                right: 15,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      images!.remove(image);
                                    });
                                  },
                                  child: Icon(
                                    Icons.close,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  chatMessages() {
    return StreamBuilder(
      stream: chats,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                reverse: true,
                shrinkWrap: true,
                padding: const EdgeInsets.only(bottom: 100.0),
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  final reversedIndex = snapshot.data.docs.length - 1 - index;

                  var messageId = snapshot.data.docs[reversedIndex].id;
                  var senderId = snapshot.data.docs[reversedIndex]['uid'];
                  var senderName = snapshot.data.docs[reversedIndex]['sender'];
                  var message = snapshot.data.docs[reversedIndex]['message'];
                  var attach = snapshot.data.docs[reversedIndex]['attach'];
                  var massagetime =
                      snapshot.data.docs[reversedIndex]['time'].toString();
                  url = 'na';
                  var userids = [];
                  for (var image in imgurl) {
                    if (image.contains(senderId)) {
                      url = image;
                    }
                  }
                  for (var user in snapshot.data.docs[reversedIndex]
                      ['seenBy']) {
                    // userinchat[user];
                    // userids.add(userinchat[user);
                  }
                  var seenarr = [];
                  var seenby = '';
                  var seentime = '';
                  var seen = false;
                  if (index == 0) {
                    DatabaseService().seenMessage(
                        uid,
                        DateTime.now().millisecondsSinceEpoch,
                        messageId,
                        widget.chatId);

                    for (var seenID in snapshot.data.docs[reversedIndex]
                        ['seenBy']) {
                      if (seenID != uid) {
                        seenarr.add(membersNameId[seenID]);
                        seenby = seenarr.join(' ');
                        var dateseen = DateTime.fromMillisecondsSinceEpoch(
                            snapshot.data.docs[reversedIndex]['timeseen']);
                        seentime = dateseen.toString();
                        seen = true;
                      }
                    }
                  }
                  return Column(
                    children: [
                      MessageTile(
                          message: message,
                          sender: senderName,
                          attachment: attach,
                          date: massagetime,
                          sentByMe: widget.userName == senderName,
                          senderUid: senderId,
                          messageID: messageId,
                          groupId: chatId,
                          seentime: seentime,
                          seenBy: seenby,
                          seen: seen,
                          url: url)
                    ],
                  );
                },
              )
            : Container();
      },
    );
  }

  sendMessage(image, chatedName) async {
    if (widget.chatId == 'createDMId' && chatId == '') {
      var newchat =
          await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
              .createChat(
                  widget.userName,
                  FirebaseAuth.instance.currentUser!.uid,
                  '*98!1DMChat',
                  widget.chatedDM,
                  chatedName);
      setState(() {
        chatId = newchat;
      });
      var members = await DatabaseService().getMembers(chatId);
      setState(() {
        imgurl = members;
      });
      var getUser = FirebaseAuth.instance.currentUser;
      DatabaseService().getChats(chatId).then((val) {
        setState(() {
          chats = val;
          uid = getUser!.uid;
        });
      });
      DatabaseService().getChatAdmin(chatId).then((val) {
        setState(() {
          admin = val;
        });
      });
    }
    if (messageController.text.isNotEmpty || image.length >= 1) {
      var imgPath = FireStoreService(context: context, folder: 'chat');
      var path = await imgPath.chatImageUpload(image, uid);
      Map<String, dynamic> chatMessageMap = {
        "uid": uid,
        "attach": path,
        "sender": widget.userName,
        "message": messageController.text,
        "time": DateTime.now().millisecondsSinceEpoch,
        "deleted": "",
        "seenBy": [],
        "timeseen": '',
      };

      DatabaseService().sendMessage(chatId, chatMessageMap);
      setState(() {
        images = [];
        messageController.clear();
        myFocusNode.requestFocus();
      });
    }
  }
}
