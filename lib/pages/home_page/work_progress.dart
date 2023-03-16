import 'package:flutter/material.dart';

class WorkProgress extends StatefulWidget {
  @override
  _WorkProgressState createState() => _WorkProgressState();
}

class _WorkProgressState extends State<WorkProgress> {
  List<String> title = [
    'Version 1.1.04',
    'Previous Version',
    'Page Update',
  ];
  Map<String, String> changes = {
    'Version 1.1.04': 'stets',
    'Previous Version':
        'chicken, garam masala, yogurt, tomato sauce, onion, garlic',
    'Page Update': '',
  };
  List<bool> _expanded = [true, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Versions'),
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
                      Text(changes[title[index]]!),
                    ],
                  ),
                ),
                isExpanded: _expanded[index],
              ),
            ],
          );
        },
      ),
    );
  }
}
