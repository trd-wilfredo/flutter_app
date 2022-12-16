import 'package:flutter/material.dart';

class MainLogo extends StatefulWidget {
  const MainLogo({super.key});

  @override
  State<MainLogo> createState() => _MainLogoState();
}

class _MainLogoState extends State<MainLogo> {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Fall \n    Queen',
      style: TextStyle(
        height: 1,
        fontSize: 100.0,
        fontFamily: 'BelloScript',
        color: Colors.white,
        shadows: [
          Shadow(
            // blurRadius: 10.0,
            color: Color.fromARGB(111, 110, 110, 110),
            offset: Offset(10.0, 10.0),
          ),
        ],
      ),
    );
  }
}
