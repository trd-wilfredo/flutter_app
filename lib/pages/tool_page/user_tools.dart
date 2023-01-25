import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_features/pages/login/service/database_service.dart';

class UserTool {
  late UserCredential userCredential;
  Future createUser(String fullname, String email, String password,
      String level, String company) async {
    FirebaseApp app = await Firebase.initializeApp(
        name: 'Secondary', options: Firebase.app().options);
    try {
      userCredential = await FirebaseAuth.instanceFor(app: app)
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => value);
      if (userCredential != null) {
        await DatabaseService(uid: userCredential.user!.uid)
            .savingUserData(fullname, email, level, company);
        return true;
      }
      // userCredential.user!.uid;
      await app.delete();
    } on FirebaseAuthException catch (e) {
      e.message;
    }
  }
}
