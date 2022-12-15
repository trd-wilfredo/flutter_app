import 'package:flutter/material.dart';
import 'package:flutter_features/fall_queen/components/logo/logo.dart';
import 'package:flutter_features/fall_queen/components/buttons/button.dart';

class FallQueen extends StatefulWidget {
  const FallQueen({super.key});

  @override
  State<FallQueen> createState() => _FallQueenState();
}

class _FallQueenState extends State<FallQueen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(69, 171, 245, 1),
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height * .15),
              MainLogo(),
              SizedBox(height: MediaQuery.of(context).size.height * .10),
              PlayButton(),
              SizedBox(height: 20.0),
              RankListButton(),
              SizedBox(height: 20.0),
              LoginButton(),
            ],
          ),
        ),
      ),
    );
  }
}
