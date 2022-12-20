// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_features/pages/home.dart';
import 'package:flutter_features/pages/loading.dart';
import 'package:flutter_features/components/menu/skill_i.dart';
import 'package:flutter_features/components/menu/skill_ii.dart';
import 'package:flutter_features/fall_queen/pages/Home.dart';
import 'package:flutter_features/messaging_app/messaging.dart';
import 'package:flutter_features/pages/login/login.dart';
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
      initialRoute: '/login',
      routes: {
        '/': (context) => Loading(),
        '/login': (context) => LoginApp(),
        '/home': (context) => Home(),
        '/skill_i': (context) => SkillI(),
        '/skill_ii': (context) => SkillII(),
        '/fall_queen': (context) => FallQueen(),
        '/ github_monitoring': (context) => Home(),
        '/cv': (context) => Home(),
        '/messaging_app': (context) => MessagingApp(),
      },
    ),
  );
}
