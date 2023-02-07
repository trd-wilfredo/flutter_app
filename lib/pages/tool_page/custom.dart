import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class Costum {
  static bool web = kIsWeb;
  static String usrid = FirebaseAuth.instance.currentUser!.uid;

  // var getUser = FirebaseAuth.instance.currentUser;
  // StatefulWidget profilePage;
  // if (getUser == null) {
  //   profilePage = LoginApp();
  // } else {
  //   var user = await DatabaseService(uid: getUser.uid).getUserById();
  //   profilePage = ProfilePage(docs: user.docs);
  // }

}
