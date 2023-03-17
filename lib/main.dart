import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_features/pages/home.dart';
import 'package:flutter_features/shared/constants.dart';
import 'package:flutter_features/pages/app_version.dart';
import 'package:flutter_features/pages/login/login.dart';
import 'package:flutter_features/messaging_app/messaging.dart';
import 'package:flutter_features/components/menu/skill_i.dart';
import 'package:flutter_features/components/menu/skill_ii.dart';
import 'package:flutter_features/pages/tool_page/ios_page.dart';
import 'package:flutter_features/pages/tool_page/andiod_app.dart';
import 'package:flutter_features/pages/tool_page/file_upload.dart';
import 'package:flutter_features/pages/company_page/comapany_page.dart';
import 'package:flutter_features/pages/company_page/search_company.dart';
import 'package:flutter_features/pages/login/service/database_service.dart';
import 'package:flutter_features/pages/profile_page.dart/profile_page.dart';
import 'package:flutter_features/pages/info_registeration/info_registeration.dart';

import 'pages/about_us.dart';
import 'pages/home_page/work_progress.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: Constants.apiKey,
        appId: Constants.appId,
        messagingSenderId: Constants.messagingSenderId,
        projectId: Constants.projectId,
        storageBucket: Constants.storageBucket,
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  page(title, page) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 27,
          ),
        ),
      ),
      body: page,
    );
  }

  var getUser = FirebaseAuth.instance.currentUser;
  StatefulWidget profilePage;
  if (getUser == null) {
    profilePage = LoginApp();
  } else {
    var user = await DatabaseService(uid: getUser.uid).getUserById();
    var link = await FirebaseStorage.instance
        .ref()
        .child(user.docs.first['profilePic'])
        .getDownloadURL();
    profilePage =
        page("ProFile Page", ProfilePage(docs: user.docs, profilePic: link));
  }
  runApp(
    MaterialApp(
      initialRoute: '/home',
      routes: {
        // '/': (context) => Loading(),
        '/home': (context) => Home(),
        '/login': (context) => LoginApp(),
        '/skill_i': (context) => SkillI(),
        '/skill_ii': (context) => SkillII(),
        '/about_us': (context) => AboutUs(),
        '/app_version': (context) => IosPage(),
        '/work_progress': (context) => WorkProgress(),
        '/file_upload': (context) => FileUpload(),
        '/profile_page': (context) => profilePage,
        '/company_list': (context) => page('Company Page', CompanyPage()),
        '/andriod_phone': (context) => AndiodPage(),
        '/messaging_app': (context) => MessagingApp(),
        '/company_search': (context) => CompanySearch(),
        '/information_registration': (context) => InfoRegister(),
        //
        '/update_collection': (context) => InfoRegister(),
      },
    ),
  );
}
