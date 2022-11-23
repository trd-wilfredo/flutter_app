import 'package:flutter/material.dart';
import 'quotes.dart';

class QuoteCard extends StatelessWidget {
  final Quote quote;
  final void Function() delete;
  QuoteCard({required this.quote, required this.delete});
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                quote.text,
                style: TextStyle(fontSize: 18.0, color: Colors.grey[600]),
              ),
              SizedBox(height: 6.0),
              Text(
                quote.artist,
                style: TextStyle(fontSize: 14.0, color: Colors.grey[800]),
              ),
              SizedBox(height: 8.0),
              TextButton.icon(
                  onPressed: delete,
                  icon: Icon(Icons.delete),
                  label: Text("Delete"))
            ],
          ),
        ));
  }
}
