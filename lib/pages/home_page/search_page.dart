import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_features/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_features/helper/helper_function.dart';
import 'package:flutter_features/pages/home_page/chat_page.dart';
import 'package:flutter_features/pages/login/service/database_service.dart';

import '../profile_page.dart/profile_page.dart';
import '../tool_page/page.dart';

class SearchPage extends StatefulWidget {
  dynamic fonts;
  String page;
  SearchPage({
    Key? key,
    required this.fonts,
    required this.page,
  }) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  bool isLoading = false;
  QuerySnapshot? searchSnapshot;
  bool hasUserSearched = false;
  String userName = "user";
  List friend = [];
  List request = [];
  List friendlist = [];
  bool isJoined = false;
  User? user;

  @override
  void initState() {
    super.initState();
    getCurrentUserIdandName();
  }

  getCurrentUserIdandName() async {
    user = FirebaseAuth.instance.currentUser;
    QuerySnapshot snapshot =
        await DatabaseService(uid: user!.uid).getUserById();
    setState(() {
      userName = snapshot.docs.first['fullName'];
    });
  }

  String getName(String r) {
    return r.substring(r.indexOf("_") + 1);
  }

  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          "Search",
          style: TextStyle(
              fontSize: 27, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (text) {
                      initiateSearchMethod();
                    },
                    controller: searchController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search ${widget.page}....",
                        hintStyle:
                            TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    initiateSearchMethod();
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(40)),
                    child: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor),
                )
              : searchList(),
        ],
      ),
    );
  }

  initiateSearchMethod() async {
    setState(() {
      request = [];
      friend = [];
      friendlist = [];
    });
    if (searchController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      await DatabaseService()
          .searchByName(searchController.text, widget.page)
          .then((snapshot) {
        if (widget.page == 'user') {
          for (var users in snapshot['data'].docs) {
            var userfr = users['addFriend'] as List;
            if (userfr.contains(user!.uid)) {
              setState(() {
                friend.add(true);
              });
            } else {
              setState(() {
                friend.add(false);
              });
            }
          }
          for (var users in snapshot['data'].docs) {
            var userfl = users['friendList'] as List;
            if (userfl.contains(user!.uid)) {
              setState(() {
                friendlist.add(true);
              });
            } else {
              setState(() {
                friendlist.add(false);
              });
            }
          }
          for (var users in snapshot['data'].docs) {
            var userfr = users['friendRequest'] as List;
            if (userfr.contains(user!.uid)) {
              setState(() {
                request.add(true);
              });
            } else {
              setState(() {
                request.add(false);
              });
            }
          }
        }
        setState(() {
          searchSnapshot = snapshot['data'];
          isLoading = false;
          hasUserSearched = true;
        });
      });
    }
  }

  searchList() {
    return hasUserSearched
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: searchSnapshot!.docs.length,
            itemBuilder: (context, index) {
              if (widget.page == "chats") {
                return groupTile(
                  userName,
                  searchSnapshot!.docs[index]['chatId'],
                  searchSnapshot!.docs[index]['chatName'],
                  searchSnapshot!.docs[index]['admin'],
                );
              }
              if (widget.page == "user") {
                return userList(searchSnapshot!.docs[index], friend[index],
                    request[index], friendlist[index], index);
              }
              if (widget.page == "product") {
                return productList(
                  searchSnapshot!.docs[index],
                );
              }
              if (widget.page == "company") {
                return companttList(
                  searchSnapshot!.docs[index],
                );
              }
              return Container();
            },
          )
        : Container();
  }

  joinedOrNot(
      String userName, String groupId, String groupname, String admin) async {
    await DatabaseService(uid: user!.uid)
        .isUserJoined(groupname, groupId, userName)
        .then((value) {
      setState(() {
        isJoined = value;
      });
    });
  }

  Widget companttList(dynamic user) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      leading: CircleAvatar(
        radius: 30,
        backgroundColor: Theme.of(context).primaryColor,
        child: Text(
          user['companyName'].substring(0, 1).toUpperCase(),
          style: const TextStyle(color: Colors.white),
        ),
      ),
      title: Text(
        user['companyName'],
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget productList(dynamic user) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      leading: CircleAvatar(
        radius: 30,
        backgroundColor: Theme.of(context).primaryColor,
        child: Text(
          user['productName'].substring(0, 1).toUpperCase(),
          style: const TextStyle(color: Colors.white),
        ),
      ),
      title: Text(
        user['productName'],
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget userList(dynamic otheruser, bool heFR, bool youRequested, bool friends,
      int index) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      leading: CircleAvatar(
        radius: 30,
        backgroundColor: Theme.of(context).primaryColor,
        child: Text(
          otheruser['fullName'].substring(0, 1).toUpperCase(),
          style: const TextStyle(color: Colors.white),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Text(
              otheruser['fullName'],
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            child: Row(
              children: [
                youRequested || heFR
                    ? (heFR
                        ? Tooltip(
                            message: 'accect request',
                            child: IconButton(
                              icon: Icon(Icons.contacts, size: 25),
                              onPressed: () async {
                                await DatabaseService().accecptRequest(
                                    otheruser['uid'], user!.uid);
                                setState(() {
                                  friend[index] = true;
                                  friendlist[index] = true;
                                });
                              },
                            ),
                          )
                        : Tooltip(
                            message: 'cancel request',
                            child: IconButton(
                              icon: Icon(Icons.cancel_rounded, size: 25),
                              onPressed: () async {
                                await DatabaseService()
                                    .cancelRequest(otheruser['uid'], user!.uid);
                                setState(() {
                                  request[index] = false;
                                });
                              },
                            ),
                          ))
                    : friends
                        ? Tooltip(
                            message: 'unfriend',
                            child: IconButton(
                              icon: Icon(Icons.remove_rounded, size: 25),
                              onPressed: () async {
                                await DatabaseService()
                                    .unfriend(otheruser['uid'], user!.uid);
                                setState(() {
                                  friend[index] = false;
                                });
                              },
                            ),
                          )
                        : Tooltip(
                            message: 'add friend',
                            child: IconButton(
                              icon: Icon(Icons.add_rounded, size: 25),
                              onPressed: () async {
                                await DatabaseService()
                                    .addFriend(otheruser['uid'], user!.uid);
                                setState(() {
                                  request[index] = true;
                                });
                              },
                            ),
                          ),
                Tooltip(
                  message: 'message',
                  child: IconButton(
                    icon: Icon(Icons.message_rounded, size: 25),
                    onPressed: () {
                      // deleteUser(val['id'], val);
                    },
                  ),
                ),
                Tooltip(
                  message: 'view profile',
                  child: IconButton(
                    icon: Icon(Icons.person_rounded, size: 25),
                    onPressed: () async {
                      var userData =
                          await DatabaseService(uid: otheruser['uid'])
                              .getUserById();
                      var link = await FirebaseStorage.instance
                          .ref()
                          .child(otheruser['profilePic'])
                          .getDownloadURL();
                      nextScreen(
                        context,
                        page(
                          otheruser['fullName'],
                          ProfilePage(user: userData.docs, profilePic: link),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget groupTile(
      String userName, String groupId, String groupName, String admin) {
    // function to check whether user already exists in group
    joinedOrNot(userName, groupId, groupName, admin);
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      leading: CircleAvatar(
        radius: 30,
        backgroundColor: Theme.of(context).primaryColor,
        child: Text(
          groupName.substring(0, 1).toUpperCase(),
          style: const TextStyle(color: Colors.white),
        ),
      ),
      title:
          Text(groupName, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text("Admin: ${getName(admin)}"),
      trailing: InkWell(
        onTap: () async {
          await DatabaseService(uid: user!.uid)
              .toggleChatJoin(groupId, userName, groupName);
          if (isJoined) {
            setState(() {
              isJoined = !isJoined;
            });
            showSnackBr(context, Colors.green, "Successfully joined he group");
            Future.delayed(const Duration(seconds: 2), () {
              nextScreen(
                  context,
                  ChatPage(
                      fonts: widget.fonts,
                      groupId: groupId,
                      groupName: groupName,
                      userName: userName));
            });
          } else {
            setState(() {
              isJoined = !isJoined;
              showSnackBr(context, Colors.red, "Left the group $groupName");
            });
          }
        },
        child: isJoined
            ? Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black,
                  border: Border.all(color: Colors.white, width: 1),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: const Text(
                  "Joined",
                  style: TextStyle(color: Colors.white),
                ),
              )
            : Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).primaryColor,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: const Text("Join Now",
                    style: TextStyle(color: Colors.white)),
              ),
      ),
    );
  }
}
