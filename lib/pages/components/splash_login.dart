import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashLogin extends StatefulWidget {
  const SplashLogin({super.key});

  @override
  State<SplashLogin> createState() => _SplashLoginState();
}

class _SplashLoginState extends State<SplashLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
      child: Column(
        children: <Widget>[
          Text('クーポンと健康で地域経済を応援 ！！'),
          Lottie.network(
              'https://assets2.lottiefiles.com/packages/lf20_0fh7phym.json'),
          Text('Lottie'),
          Text('あなたの街の金融機関が集めた'),
          Text('身近な地域のお店のクーポンがたくさん！'),
          Text('Select dfsgdfgButton'),
          Text('Blue Button'),
        ],
      ),
    )));
  }
}
