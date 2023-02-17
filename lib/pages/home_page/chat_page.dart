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
  final String groupId;
  final String groupName;
  final String userName;
  const ChatPage(
      {Key? key,
      required this.groupId,
      required this.groupName,
      required this.userName})
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
  List imgurl = [];
  final storage = FirebaseStorage.instance.ref();

  @override
  void initState() {
    getChatandAdmin();
    super.initState();
  }

  getChatandAdmin() async {
    var members = await DatabaseService().getMembers(widget.groupId);
    setState(() {
      imgurl = members;
    });
    var getUser = FirebaseAuth.instance.currentUser;
    DatabaseService().getChats(widget.groupId).then((val) {
      setState(() {
        chats = val;
        uid = getUser!.uid;
      });
    });
    DatabaseService().getGroupAdmin(widget.groupId).then((val) {
      setState(() {
        admin = val;
      });
    });
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
                      groupId: widget.groupId,
                      groupName: widget.groupName,
                      adminName: admin,
                    ));
              },
              icon: const Icon(Icons.info))
        ],
      ),
      body: Stack(
        children: <Widget>[
          // chat messages here
          chatMessages(),
          Container(
            alignment: Alignment.bottomCenter,
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[700],
              child: Row(children: [
                Expanded(
                  child: TextFormField(
                    onFieldSubmitted: (value) {
                      sendMessage();
                    },
                    controller: messageController,
                    focusNode: myFocusNode,
                    style: const TextStyle(color: Colors.white, height: 2.0),
                    decoration: const InputDecoration(
                      hintText: "Send a message...",
                      hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                GestureDetector(
                  onTap: () async {
                    var file = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    var imgPath =
                        FireStoreService(context: context, folder: 'chat');
                    if (kIsWeb) {
                      // running on android or ios device
                      var path = await imgPath.uploadFile(file, uid);
                      sendImage(path);
                    } else {
                      await Permission.photos.request();
                      var permissionStatus = await Permission.photos.status;
                      if (permissionStatus.isGranted) {
                        var path = await imgPath.uploadFile(file, uid);
                        sendImage(path);
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
                    sendMessage();
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
          )
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
                  url = 'na';
                  for (var image in imgurl) {
                    if (image
                        .contains(snapshot.data.docs[reversedIndex]['uid'])) {
                      url = image;
                    }
                  }
                  print(snapshot.data.docs[reversedIndex]['attach']);
                  return Column(
                    children: [
                      MessageTile(
                          message: snapshot.data.docs[reversedIndex]['message'],
                          sender: snapshot.data.docs[reversedIndex]['sender'],
                          attachment: snapshot.data.docs[reversedIndex]
                              ['attach'],
                          date: snapshot.data.docs[reversedIndex]['time']
                              .toString(),
                          sentByMe: widget.userName ==
                              snapshot.data.docs[reversedIndex]['sender'],
                          senderUid: snapshot.data.docs[reversedIndex]['uid'],
                          url: url)
                    ],
                  );
                },
              )
            : Container();
      },
    );
  }

  sendImage(path) async {
    Map<String, dynamic> chatMessageMap = {
      "uid": uid,
      "attach": path,
      "sender": widget.userName,
      "time": DateTime.now().millisecondsSinceEpoch,
      "message":
          messageController.text.isNotEmpty ? messageController.text : '',
    };
    DatabaseService().sendMessage(widget.groupId, chatMessageMap);
    setState(() {
      messageController.clear();
      myFocusNode.requestFocus();
    });
  }

  sendMessage() {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "uid": uid,
        "attach": '',
        "sender": widget.userName,
        "message": messageController.text,
        "time": DateTime.now().millisecondsSinceEpoch,
      };
      DatabaseService().sendMessage(widget.groupId, chatMessageMap);
      setState(() {
        messageController.clear();
        myFocusNode.requestFocus();
      });
    }
  }
}
