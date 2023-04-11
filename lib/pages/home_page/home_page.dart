import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_features/widgets/widget.dart';
// import 'package:flutter_features/helper/helper_function.dart';`
// import 'package:flutter_features/messaging_app/messaging.dart';`
import 'package:flutter_features/pages/user_page/user_page.dart';
import 'package:flutter_features/pages/home_page/group_title.dart';
import 'package:flutter_features/pages/home_page/search_page.dart';
import 'package:flutter_features/pages/login/auth/login_page.dart';
import 'package:flutter_features/pages/product_page/product_page.dart';
import 'package:flutter_features/pages/company_page/comapany_page.dart';
import 'package:flutter_features/pages/company_page/search_company.dart';
import 'package:flutter_features/pages/login/service/auth_service.dart';
import 'package:flutter_features/pages/login/service/database_service.dart';
import 'package:flutter_features/pages/profile_page.dart/profile_page.dart';

import '../friend_list.dart/friend_list.dart';
import 'dm_title.dart';

class HomePage extends StatefulWidget {
  dynamic fonts;
  HomePage({
    Key? key,
    required this.fonts,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = "";
  String email = "";
  AuthService authService = AuthService();
  Stream? groups;
  bool _isLoading = false;
  String groupName = "";
  String userLevel = "";
  String companyId = "";
  String profile = "";
  String title = "Chat List";
  String page = "groups";
  List userData = [];
  List companies = [];
  bool isButtonLongPressed = false;

  @override
  void initState() {
    super.initState();
    gettingUserData();
  }

  bool ifDM(String res) {
    var check = res.substring(0, res.indexOf("_"));
    return check == 'dm' ? true : false;
  }

  // string manipulation
  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  String getName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  gettingUserData() async {
    // getting the list of snapshots in our stream
    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getUserGroups()
        .then((snapshot) {
      setState(() {
        groups = snapshot;
      });
    });
    var user =
        await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
            .getUserById();
    // QuerySnapshot snapshot = await DatabaseService(uid: companyId).getAllProduct(companyId);
    // ;
    QuerySnapshot getAllCompany = await DatabaseService().getAllCompany();
    for (var f in getAllCompany.docs) {
      setState(() {
        companies.add({
          'company': f['companyName'],
          'companyId': f['uid'],
        });
      });
    }
    var link = await FirebaseStorage.instance
        .ref()
        .child(user.docs.first['profilePic'])
        .getDownloadURL();
    setState(() {
      profile = link;
      userData = user.docs;
      email = user.docs.first['email'];
      userName = user.docs.first['fullName'];
      userLevel = user.docs.first['level'];
      companyId = user.docs.first['companyId'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 53, 53, 53),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              if (page != null)
                nextScreen(
                    context,
                    SearchPage(
                      fonts: widget.fonts,
                      page: page,
                    ));
            },
            icon: Icon(Icons.search),
          ),
        ],
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 27,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 50),
          children: <Widget>[
            SizedBox(
              height: 200,
              child: IconButton(
                onPressed: () {
                  setState(() {
                    title = "User Profile";
                    page = "profile_page";
                  });
                  // nextScreenReplace(
                  //   context,
                  //   ProfilePage(
                  //     docs: docs,
                  //     profilePic: profile,
                  //   ),
                  // );
                },
                icon: profile == ''
                    ? Icon(
                        Icons.account_circle,
                        size: 150,
                        color: Colors.grey[700],
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(100.0),
                        child: Image(
                          image: NetworkImage(profile),
                          alignment: Alignment.center,
                          height: 200,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
              ),
            ),
            Text(
              email,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            const Divider(
              height: 2,
            ),
            ListTile(
              onTap: () {
                setState(() {
                  title = "Chat List";
                  page = "groups";
                });
              },
              selectedColor: page == "groups"
                  ? Theme.of(context).primaryColor
                  : Colors.black,
              selected: page == "groups" ? true : false,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(Icons.group),
              title: const Text(
                "Groups",
                style: TextStyle(color: Colors.black),
              ),
            ),
            if (userLevel == 'admin')
              ListTile(
                onTap: () {
                  // nextScreen(context, UserPage());
                  setState(() {
                    title = "User";
                    page = "user";
                  });
                },
                selectedColor: page == "user"
                    ? Theme.of(context).primaryColor
                    : Colors.black,
                selected: page == "user" ? true : false,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                leading: const Icon(Icons.group),
                title: const Text(
                  "Users",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ListTile(
              onTap: () {
                // nextScreen(context, ProductPage());
                setState(() {
                  title = "Product Page";
                  page = "product";
                });
              },
              selectedColor: page == "product"
                  ? Theme.of(context).primaryColor
                  : Colors.black,
              selected: page == "product" ? true : false,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(Icons.group),
              title: const Text(
                "Products",
                style: TextStyle(color: Colors.black),
              ),
            ),
            if (userLevel == 'admin')
              ListTile(
                onTap: () {
                  // nextScreen(context, CompanyPage());
                  setState(() {
                    title = "Company Page";
                    page = "company";
                  });
                },
                selectedColor: page == "company"
                    ? Theme.of(context).primaryColor
                    : Colors.black,
                selected: page == "company" ? true : false,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                leading: const Icon(Icons.group),
                title: const Text(
                  "Companies",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            if (userLevel == 'admin')
              ListTile(
                onTap: () {
                  nextScreen(context, CompanySearch());
                },
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                leading: const Icon(Icons.group),
                title: const Text(
                  "Search Company",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ListTile(
              onTap: () {
                if (page != null)
                  nextScreenReplace(
                      context,
                      SearchPage(
                        fonts: widget.fonts,
                        page: "user",
                      ));
              },
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(Icons.group),
              title: const Text(
                "Search",
                style: TextStyle(color: Colors.black),
              ),
            ),
            ListTile(
              onTap: () async {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Logout"),
                        content: const Text("Are you sure you want to logout?"),
                        actions: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.cancel,
                              color: Colors.red,
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              await authService.signOut();
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage(
                                            fonts: widget.fonts,
                                          )),
                                  (route) => false);
                            },
                            icon: const Icon(
                              Icons.done,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      );
                    });
              },
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(Icons.exit_to_app),
              title: const Text(
                "Logout",
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),

      body: switchPage(page),
    );
  }

  switchPage(page) {
    switch (page) {
      case "groups":
        return chatList();
      case "product":
        return ProductPage(
          companies: companies,
          companyId: companyId,
          userLevel: userLevel,
        );
      case "user":
        return UserPage(
          companyId: companyId,
          companies: companies,
          userLevel: userLevel,
        );
      case "company":
        return CompanyPage();
      case "profile_page":
        return ProfilePage(user: userData, profilePic: profile);
    }
  }

  chatList() {
    return Scaffold(
      floatingActionButton: GestureDetector(
        onLongPress: () {
          setState(() {
            isButtonLongPressed = true;
          });
        },
        // onLongPressEnd: (_) {
        //   setState(() {
        //     isButtonLongPressed = false;
        //   });
        // },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (isButtonLongPressed)
              FloatingActionButton(
                onPressed: () {
                  popUpDialog(context, 'create group');
                  setState(() {
                    isButtonLongPressed = false;
                  });
                },
                elevation: 0,
                backgroundColor: Theme.of(context).primaryColor,
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            FloatingActionButton(
              onPressed: () {
                popUpDialog(context, 'direct message');
                setState(() {
                  isButtonLongPressed = false;
                });
              },
              elevation: 0,
              backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(
                Icons.person,
                color: Colors.white,
                size: 30,
              ),
            ),
          ],
        ),
      ),
      body: StreamBuilder(
        stream: groups,
        builder: (context, AsyncSnapshot snapshot) {
          // make some checks
          if (snapshot.hasData) {
            if (snapshot.data['groups'] != null) {
              if (snapshot.data['groups'].length != 0) {
                return ListView.builder(
                  itemCount: snapshot.data['groups'].length,
                  itemBuilder: (context, index) {
                    int reverseIndex =
                        snapshot.data['groups'].length - index - 1;
                    if (!ifDM(snapshot.data['groups'][reverseIndex])) {
                      return GroupTile(
                        groupId: getId(snapshot.data['groups'][reverseIndex]),
                        fonts: widget.fonts,
                        groupName:
                            getName(snapshot.data['groups'][reverseIndex]),
                        userName: snapshot.data['fullName'],
                        url: [],
                      );
                    } else {
                      // personal chat
                      return DMTitle();
                    }
                  },
                );
              } else {
                return noGroupWidget();
              }
            } else {
              return noGroupWidget();
            }
          } else {
            return Center(
              child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor),
            );
          }
        },
      ),
    );
  }

  noGroupWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              popUpDialog(context, 'create group');
            },
            child: Icon(
              Icons.add_circle,
              color: Colors.grey[700],
              size: 75,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "You've not joined any groups, tap on the add icon to create a group or also search from top search button.",
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  popUpDialog(BuildContext context, String addFriend) {
    if (addFriend == 'create group') {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: ((context, setState) {
              return AlertDialog(
                title: const Text(
                  "Create a group",
                  textAlign: TextAlign.left,
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _isLoading == true
                        ? Center(
                            child: CircularProgressIndicator(
                                color: Theme.of(context).primaryColor),
                          )
                        : TextField(
                            onChanged: (val) {
                              setState(() {
                                groupName = val;
                              });
                            },
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor),
                                  borderRadius: BorderRadius.circular(20)),
                              errorBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(20)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor),
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                  ],
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor),
                    child: const Text("CANCEL"),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (groupName != "") {
                        setState(() {
                          _isLoading = true;
                        });
                        DatabaseService(
                                uid: FirebaseAuth.instance.currentUser!.uid)
                            .createGroup(
                                userName,
                                FirebaseAuth.instance.currentUser!.uid,
                                groupName)
                            .whenComplete(() {
                          _isLoading = false;
                        });
                        Navigator.of(context).pop();
                        showSnackBr(context, Colors.green,
                            "Group created successfully.");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor),
                    child: const Text("CREATE"),
                  )
                ],
              );
            }),
          );
        },
      );
    } else {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: ((context, setState) {
              return Container(
                width: 120,
                child: Stack(
                  children: <Widget>[
                    AlertDialog(
                      title: const Text(
                        "Direct Message",
                        textAlign: TextAlign.left,
                      ),
                      content: FriendList(friends: []),
                    ),
                    Positioned(
                      top: 15,
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
  }
}
