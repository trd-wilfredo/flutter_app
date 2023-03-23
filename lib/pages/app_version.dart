import 'package:flutter/material.dart';

class AppVersion extends StatelessWidget {
  const AppVersion({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Appversion')),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Add pop up message when delete user, product, company'),
            Text(
                'Cange button to icon button in user page, company page and product page  '),
            Text('Added Work Progress Page'),
            Text('Change replace page when selecting menu'),
            Text('Send Image in chat page'),
          ],
        ),
      ),
    );
  }
}
