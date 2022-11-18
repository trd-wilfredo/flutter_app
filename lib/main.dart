import 'package:flutter/material.dart';
import 'quotes.dart';

void main() => runApp(MaterialApp(home: QuoteList()));

class QuoteList extends StatefulWidget {
  @override
  _QuoteListState createState() => _QuoteListState();
}

class _QuoteListState extends State<QuoteList> {
  List<Quote> quotes = [
    Quote(artist: 'Dionmar', text: 'Dobido bi dap dap'),
    Quote(artist: 'Dionmar', text: 'Dabada bi do dap dap'),
    Quote(artist: 'Dionmar', text: 'Da dap da dap da dap')
  ];

  Widget quoteTemplate(quote) {
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
              )
            ],
          ),
        ));
  }

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
          children: quotes.map((quote) => quoteTemplate(quote)).toList()),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'quotes.dart';

// void main() => runApp(MaterialApp(
//       home: Quotelist(),
//     ));

// class Quotelist extends StatefulWidget {
//   const Quotelist({super.key});

//   @override

// class _QuotelistState extends State<Quotelist> {
//   List<Quote> quotes = [
//     Quote(artist: 'Dionmar', text: 'Dobido bi dap dap'),
//     Quote(artist: 'Dionmar', text: 'Dabada bi do dap dap'),
//     Quote(artist: 'Dionmar', text: 'Da dap da dap da dap')
//   ];

//   Widget quoteTemplate(quote) {
//     return Card(
//         margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
//         child: Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: <Widget>[
//               Text(
//                 quote.text,
//                 style: TextStyle(fontSize: 18.0, color: Colors.grey[600]),
//               ),
//               SizedBox(height: 6.0),
//               Text(
//                 quote.artist,
//                 style: TextStyle(fontSize: 14.0, color: Colors.grey[800]),
//               )
//             ],
//           ),
//         ));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.grey[200],
//         appBar: AppBar(
//           title: Text('The Quotes'),
//           centerTitle: true,
//           backgroundColor: Colors.redAccent,
//         ),
//         body: Column(
//             children: quotes.map((quote) => quoteTemplate(quote)).toList()));
//   }
// }
