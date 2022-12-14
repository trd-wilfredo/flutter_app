import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_features/pages/login/service/database_service.dart';
import 'package:flutter_features/helper/helper_function.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // login

  Future loginInWithEmailandPassword(String email, String password) async {
    try {
      User user = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user!;
      if (user != null) {
        print(['login', user]);
        return true;
      }
    } on FirebaseAuthException catch (e) {
      print(['error ni sa login', e]);
      return e.message;
    }
  }
  // // login
  // Future loginWithUserNameandPassword(String email, String password) async {
  //   try {
  //     User user = (await firebaseAuth.signInWithEmailAndPassword(
  //             email: email, password: password))
  //         .user!;

  //     if (user != null) {
  //       return true;
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     return e.message;
  //   }
  // }

  // register

  Future registerUserWithEmailandPassword(String fullname, String email,
      String password, String level, String company) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;
      if (user != null) {
        // database call
        await DatabaseService(uid: user.uid)
            .savingUserData(fullname, email, level, company);

        return true;
      }
    } on FirebaseAuthException catch (e) {
      print(['error ni sa register', e]);
      return e.message;
    }
  }

  // Signout
  Future signOut() async {
    try {
      await HelperFunction.saveUserLoggedInStatus(false);
      await HelperFunction.saveUserEmailSF("");
      await HelperFunction.saveUserNameSF("");
      await firebaseAuth.signOut();
    } catch (e) {
      return null;
    }
  }
}
