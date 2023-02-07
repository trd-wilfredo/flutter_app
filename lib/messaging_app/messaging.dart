import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_features/widgets/message_title.dart';
import 'package:flutter_features/helper/helper_function.dart';
import 'package:flutter_features/pages/login/service/database_service.dart';

class MessagingApp extends StatefulWidget {
  const MessagingApp({super.key});
  @override
  State<MessagingApp> createState() => _MessagingAppState();
}

class _MessagingAppState extends State<MessagingApp> {
  Stream<QuerySnapshot>? chats;
  String email = "";
  String uid = "";

  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    gettingUserData();
  }

  // string manipulation
  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  String getName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  gettingUserData() async {
    await HelperFunction.getUserEmailFromSF().then((value) {
      setState(() {
        email = value!;
      });
    });
    var getUser = FirebaseAuth.instance.currentUser;
    setState(() {
      uid = getUser!.uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Message'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 53, 135, 229),
      ),
      body: Stack(
        children: <Widget>[
          chatMessages(),
          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _textController,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10.0),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 1.0,
                        ),
                      ),
                      filled: true,
                      // prefixIcon: Icon(Icons.message),
                      // labelText: "Message",
                      fillColor: Colors.grey[200],
                      hintText: 'Type a message...',
                    ),
                    maxLines: 4,
                    style: const TextStyle(
                      height: 1.1,
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    sendMessage();
                  },
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
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return MessageTile(
                      message: snapshot.data.docs[index]['message'],
                      sender: snapshot.data.docs[index]['sender'],
                      senderUid: snapshot.data.docs[index]['sender'],
                      sentByMe: snapshot.data.docs[index]['sender'],
                      url: '');
                },
              )
            : Container();
      },
    );
  }

  sendMessage() {
    if (_textController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageCS = {
        "uid": uid,
        "sender": email,
        "message": _textController.text,
        "time": DateTime.now().millisecondsSinceEpoch,
      };

      DatabaseService().csSendMessage(email, chatMessageCS);
      setState(() {
        _textController.clear();
      });
    }
  }
}
