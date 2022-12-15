import 'package:flutter/material.dart';
import 'package:flutter_features/components/buttons/button_collections_1.dart';

class SkillI extends StatefulWidget {
  const SkillI({Key? key}) : super(key: key);

  @override
  State<SkillI> createState() => _SkillIState();
}

class _SkillIState extends State<SkillI> {
  late String test;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Center(
                child: Text(
                  'Buttons',
                  style: TextStyle(
                    height: 2,
                    fontSize: 50,
                  ),
                ),
              ),
              HomeButton(),
              ButtonType1(),
              ButtonOutLined(),
              ButtonType2(),
            ],
          ),
        ),
      ),
    );
  }
}
