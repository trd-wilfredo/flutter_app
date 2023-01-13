import 'package:flutter/material.dart';

class IosPage extends StatefulWidget {
  const IosPage({super.key});

  @override
  State<IosPage> createState() => _IosPageState();
}

class _IosPageState extends State<IosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Download IOS App'),
      ),
      body: SafeArea(
        child: Container(
          child: Center(
            child: Text("We're Woking on this page"),
          ),
        ),
      ),
    );
  }
}
