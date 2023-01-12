import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_features/pages/company_page/comapany_page.dart';
import 'package:flutter_features/pages/home.dart';
import 'package:flutter_features/pages/info_registeration/info_registeration.dart';
import 'package:flutter_features/pages/loading.dart';
import 'package:flutter_features/components/menu/skill_i.dart';
import 'package:flutter_features/components/menu/skill_ii.dart';
import 'package:flutter_features/fall_queen/pages/Home.dart';
import 'package:flutter_features/messaging_app/messaging.dart';
import 'package:flutter_features/pages/login/login.dart';
import 'package:flutter_features/pages/product_page/product_page.dart';
import 'package:flutter_features/pages/user_page/user_page.dart';
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

  runApp(
    MaterialApp(
      initialRoute: '/home',
      routes: {
        '/': (context) => Loading(),
        '/cv': (context) => Home(),
        '/home': (context) => Home(),
        '/login': (context) => LoginApp(),
        '/skill_i': (context) => SkillI(),
        '/skill_ii': (context) => SkillII(),
        '/fall_queen': (context) => FallQueen(),
        '/github_monitoring': (context) => CompanyPage(),
        '/messaging_app': (context) => MessagingApp(),
        '/file_upload': (context) => MessagingApp(),
        '/information_registration': (context) => InfoRegister(),
        '/company_search': (context) => MessagingApp(),
        '/company_list': (context) => MessagingApp(),
      },
    ),
  );
}
