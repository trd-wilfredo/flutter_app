import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Costum {
  static bool web = kIsWeb;
  static String usrid = FirebaseAuth.instance.currentUser!.uid;
}
