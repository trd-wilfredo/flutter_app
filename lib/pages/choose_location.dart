import 'package:flutter/material.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({Key? key}) : super(key: key);

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  int counter = 0;

  void getData() async {
    // simulate network request for a user
    String user = await Future.delayed(Duration(seconds: 3), () {
      return 'Uwuee';
    });
    String reaction = await Future.delayed(Duration(seconds: 2), () {
      return 'Uvuavuawaw';
    });
    print('$user -  $reaction');
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        title: Text('Choose Location Page'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ElevatedButton(
        onPressed: () {
          setState(
            () {
              counter += 1;
            },
          );
        },
        child: Text('counter is $counter'),
      ),
    );
  }
}
