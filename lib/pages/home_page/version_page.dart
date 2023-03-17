import 'package:flutter/material.dart';

VersionPage(version) {
  if (version == "1.1.04") {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Added Work Progress Page'),
          Text('Change replace page when selecting menu'),
          Text('Send Image in chat page'),
        ],
      ),
    );
  }
}
