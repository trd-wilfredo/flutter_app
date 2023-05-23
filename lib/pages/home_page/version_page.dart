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
  if (version == "1.1.06") {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'App version 1.1.06**',
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
                Text('March 31 2023 4:00pm'),
                Text('Open other profile in search user'),
                Text('Friend Request to other user'),
                Text('Cancel Friend Request to other user'),
              ],
            ),
          ),
        ],
      ),
    );
  }
  if (version == "1.1.07") {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'App version 1.1.07**',
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
                Text('April 11 2023 5:00pm'),
                Text('Long press button in chat list. show type of message'),
                Text('Create direct message in chat list'),
                Text('Make friend list'),
                Text('Accept Friend Request '),
              ],
            ),
          ),
        ],
      ),
    );
  }
  if (version == "1.1.08") {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'App version 1.1.08**',
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
                Text('April 27 2023 5:00pm'),
                Text('Message a friend in chat page'),
                Text('New chat list include DM'),
              ],
            ),
          ),
        ],
      ),
    );
  }
  if (version == "1.1.09") {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'App version 1.1.09**',
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
                Text('May 5 2023 5:00pm'),
                Text('Seen in Chat page'),
                Text('Seen in Chat List'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
