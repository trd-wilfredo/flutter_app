import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_features/pages/login/service/database_service.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // login

  Future loginInWithEmailandPassword(String email, String password) async {
    try {
      User user = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user!;
      if (user != null) {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      return e.message;
    }
  }

  // register

  Future registerUserWithEmailandPassword(
      String fullname, String email, String password) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;
      if (user != null) {
        // database call
        await DatabaseService(uid: user.uid).updateUserData(fullname, email);

        return true;
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      return e.message;
    }
  }

  // Signout
}
