import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.width * 1.05,
                    color: const Color(0xE1A9653B),
                  ),
                ],
              ),
              Positioned(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      // Text('クーポンと健康で地域経済を応援 ！！'),
                      SvgPicture.asset(
                        'assets/head-avatar-1.svg',
                        width: MediaQuery.of(context).size.width * 0.65,
                        semanticsLabel: 'testing',
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text("I'm "),
                          Text("Wilfredo Madelo"),
                        ],
                      ),
                      const Text('This is my Curriculum vitae'),
                      Container(
                        height: MediaQuery.of(context).size.width * 0.40,
                        width: MediaQuery.of(context).size.width * 0.80,
                        padding: const EdgeInsets.all(20.0),
                        // color: Colors.amber,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 251, 199, 115),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x43000000),
                              spreadRadius: 1,
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  'assets/quote-1.svg',
                                  width:
                                      MediaQuery.of(context).size.width * 0.15,
                                  semanticsLabel: 'quote-1',
                                ),
                                SvgPicture.asset(
                                  'assets/quote-2.svg',
                                  width:
                                      MediaQuery.of(context).size.width * 0.15,
                                  semanticsLabel: 'quote-2',
                                ),
                                SvgPicture.asset(
                                  'assets/quote-3.svg',
                                  width:
                                      MediaQuery.of(context).size.width * 0.15,
                                  semanticsLabel: 'quote-3',
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                SvgPicture.asset(
                                  'assets/head-avatar-2.svg',
                                  width:
                                      MediaQuery.of(context).size.width * 0.10,
                                  semanticsLabel: 'head-avatar-2',
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                SvgPicture.asset(
                                  'assets/quote-4.svg',
                                  width:
                                      MediaQuery.of(context).size.width * 0.22,
                                  semanticsLabel: 'quote-4',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Lottie.network(
                        'https://assets2.lottiefiles.com/packages/lf20_0fh7phym.json',
                        height: MediaQuery.of(context).size.width * 0.65,
                      ),
                      // Text('あなたの街の金融機関が集めた'),
                      // Text('身近な地域のお店のクーポンがたくさん！'),
                      // Text('Select dfsgdfgButton'),
                      // Text('Blue Button'),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
