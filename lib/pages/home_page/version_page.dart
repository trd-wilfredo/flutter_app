import 'package:flutter/material.dart';

VersionPage(version) {
  if (version == "1.1.04") {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'App version 1.1.04**',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          SizedBox(height: 15),
          Container(
            margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Added Work Progress Page'),
                Text('Change replace page when selecting menu'),
                Text('Send Image in chat page'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  if (version == "1.1.05") {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'App version 1.1.05**',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          SizedBox(height: 15),
          Container(
            margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('March 24 2023 7:00pm'),
                Text('Add Search User'),
                Text('Add Search pruduct'),
                Text('Add Search Company in comapny page'),
                Text('Add pop up message when delete user, product, company'),
                Text('Auto search on type in search text feild'),
                Text(
                    'Cange button to icon button in user page, company page and product page  '),
              ],
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
