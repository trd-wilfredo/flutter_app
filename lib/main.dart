import 'package:flutter/material.dart';
import 'quotes.dart';
import 'quote_card.dart';

void main() => runApp(MaterialApp(home: QuoteList()));

class QuoteList extends StatefulWidget {
  @override
  _QuoteListState createState() => _QuoteListState();
}

class _QuoteListState extends State<QuoteList> {
  List<Quote> quotes = [
    Quote(artist: 'Dionmar', text: 'Dobido bi dap dap fdghfd'),
    Quote(artist: 'Dionmar', text: 'Dabada bi do dap dap'),
    Quote(artist: 'Dionmar', text: 'Da dap da dap da dap')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('The Quotes'),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: Column(
          children: quotes
              .map((quote) => QuoteCard(
                  quote: quote,
                  delete: () {
                    setState(() {
                      quotes.remove(quote);
                    });
                  }))
              .toList()),
    );
  }
}
