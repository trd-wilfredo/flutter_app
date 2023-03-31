import 'package:flutter/material.dart';
import 'package:flutter_features/pages/home_page/version_page.dart';
import 'progress_table.dart';

class WorkProgress extends StatefulWidget {
  StatefulWidget profile;
  dynamic fonts;
  WorkProgress({
    Key? key,
    required this.profile,
    required this.fonts,
  }) : super(key: key);
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
    'Version 1.1.06',
    'Version 1.1.05',
    'Version 1.1.04',
    'Previous Version',
  ];

  List<bool> _expanded = [true, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> changes = {
      'Work Progress': ProgressTable(
        profile: widget.profile,
        fonts: widget.fonts,
      ),
      'Version 1.1.06': VersionPage('1.1.06'),
      'Version 1.1.05': VersionPage('1.1.05'),
      'Version 1.1.04': VersionPage('1.1.04'),
      'Previous Version': Text(
        'details',
      )
    };
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
