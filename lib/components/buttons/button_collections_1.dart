import 'package:flutter/material.dart';

class HomeButton extends StatefulWidget {
  const HomeButton({super.key});

  @override
  State<HomeButton> createState() => _HomeButtonState();
}

class _HomeButtonState extends State<HomeButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(
          context,
          '/home',
        );
      },
      child: Text('home'),
    );
  }
}

class ButtonType1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(
          context,
          '/home',
        );
      },
      child: Text('ButtonType1'),
    );
  }
}

class ButtonType2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(
          context,
          '/home',
        );
      },
      child: Text('ElevatedButton'),
    );
  }
}

class ButtonOutLined extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      child: Text('Outlined'),
    );
  }
}
