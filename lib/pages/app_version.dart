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
            Text('App version 1.1.05'),
            Text('Add Search User'),
            Text('Add Search pruduct'),
            Text('Add Search Company in comapny page'),
            Text('Add pop up message when delete user, product, company'),
            Text('Auto search on type in search text feild'),
            Text(
                'Cange button to icon button in user page, company page and product page  '),
            Text('App version 1.1.04'),
            Text('Added Work Progress Page'),
            Text('Change replace page when selecting menu'),
            Text('Send Image in chat page'),
          ],
        ),
      ),
    );
  }
}
