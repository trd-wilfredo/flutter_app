import 'package:flutter/material.dart';

class PlayButton extends StatelessWidget {
  const PlayButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Container(
        // padding: EdgeInsets.fromLTRB(60, 25, 60, 25),
        width: 300.0,
        height: 60.0,
        child: Center(
          child: Text('PLAY'),
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: Color.fromARGB(255, 255, 255, 255), // b
        onPrimary: Color.fromARGB(255, 8, 201, 255), // foregroundackground
      ),
    );
  }
}

class RankListButton extends StatelessWidget {
  const RankListButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Container(
        // padding: EdgeInsets.fromLTRB(60, 25, 60, 25),
        width: 300.0,
        height: 60.0,
        color: Color.fromARGB(0, 0, 0, 0),
        child: Center(
          child: Text(
            'RANK LIST',
          ),
        ),
        // ),
      ),
      style: ElevatedButton.styleFrom(
        primary: Color.fromARGB(255, 255, 255, 255), // b
        onPrimary: Color.fromARGB(255, 8, 201, 255), // foregroundackground
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Container(
        // padding: EdgeInsets.fromLTRB(60, 25, 60, 25),
        width: 300.0,
        height: 60.0,
        color: Color.fromARGB(0, 0, 0, 0),
        child: Center(
          child: Text(
            'LOGIN',
          ),
        ),
        // ),
      ),
      style: ElevatedButton.styleFrom(
        primary: Color.fromARGB(255, 255, 255, 255), // b
        onPrimary: Color.fromARGB(255, 8, 201, 255), // foregroundackground
      ),
    );
  }
}
