import 'package:flutter/material.dart';

class SkillII extends StatefulWidget {
  const SkillII({super.key});

  @override
  State<SkillII> createState() => _SkillIIState();
}

class _SkillIIState extends State<SkillII> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Center(
                child: Text(
                  'Layouts',
                  style: TextStyle(
                    height: 2,
                    fontSize: 50,
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 1.00,
                child: Image.asset('assets/image_1.jpg'),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.50,
                      child: Image.asset(
                        'assets/image_2.jpg',
                        height: 150,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.50,
                      child: Image.asset(
                        'assets/image_3.jpg',
                        height: 150,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
