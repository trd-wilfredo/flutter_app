import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_features/helper/helper_function.dart';
import 'package:flutter_features/pages/company_page/comapany_page.dart';
import 'package:flutter_features/pages/company_page/search_company.dart';
import 'package:flutter_features/pages/home.dart';
import 'package:flutter_features/pages/info_registeration/info_registeration.dart';
import 'package:flutter_features/components/menu/skill_i.dart';
import 'package:flutter_features/components/menu/skill_ii.dart';
import 'package:flutter_features/messaging_app/messaging.dart';
import 'package:flutter_features/pages/login/login.dart';
import 'package:flutter_features/pages/profile_page.dart/profile_page.dart';
import 'package:flutter_features/pages/tool_page/andiod_app.dart';
import 'package:flutter_features/pages/tool_page/file_upload.dart';
import 'package:flutter_features/pages/tool_page/ios_page.dart';
import 'package:flutter_features/shared/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: Constants.apiKey,
        appId: Constants.appId,
        messagingSenderId: Constants.messagingSenderId,
        projectId: Constants.projectId,
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  var email = await HelperFunction.getUserEmailFromSF().then((val) {
    return '$val!';
  });
  var userName = await HelperFunction.getUserNameFromSF().then((val) {
    return '$val!';
  });
  runApp(
    MaterialApp(
      initialRoute: '/home',
      routes: {
        // '/': (context) => Loading(),
        '/home': (context) => Home(),
        '/login': (context) => LoginApp(),
        '/skill_i': (context) => SkillI(),
        '/skill_ii': (context) => SkillII(),
        '/information_registration': (context) => InfoRegister(),
        '/company_list': (context) => CompanyPage(),
        '/messaging_app': (context) => FileUpload(),
        '/profile_page': (context) =>
            ProfilePage(email: email, userName: userName),
        '/company_search': (context) => CompanySearch(),
        '/file_upload': (context) => FileUpload(),
        '/andriod_phone': (context) => AndiodPage(),
        '/ios_App': (context) => IosPage(),
      },
    ),
  );
}
