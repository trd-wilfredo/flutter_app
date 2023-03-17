import 'package:flutter/material.dart';
import 'package:flutter_features/pages/home_page/version_page.dart';
import 'progress_table.dart';

class WorkProgress extends StatefulWidget {
  @override
  _WorkProgressState createState() => _WorkProgressState();
}

class _WorkProgressState extends State<WorkProgress> {
  @override
  void initState() {
    super.initState();
  }

  List<String> title = [
    'Work Progress',
    'Version 1.1.04',
    'Previous Version',
  ];
  Map<String, dynamic> changes = {
    'Work Progress': ProgressTable(),
    'Version 1.1.04': VersionPage('1.1.04'),
    'Previous Version': Text(
      'details',
    )
  };

  List<bool> _expanded = [true, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Work Progress'),
      ),
      body: ListView.builder(
        itemCount: title.length,
        itemBuilder: (BuildContext context, int index) {
          return ExpansionPanelList(
            expansionCallback: (int panelIndex, bool isExpanded) {
              setState(() {
                _expanded[index] = !isExpanded;
              });
            },
            children: [
              ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    title: Text(
                      title[index],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
                body: Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Details:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      changes[title[index]]!,
                    ],
                  ),
                ),
                isExpanded: _expanded[index],
              ),
            ],
          );
        },
        padding: const EdgeInsets.only(bottom: 70.0),
      ),
    );
  }
}
