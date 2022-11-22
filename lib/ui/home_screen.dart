import 'package:flutter/material.dart';
import 'package:moneygram/ui/transaction_row_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _body(),
      ),
      floatingActionButton:
          _fab(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _body() {
    return Column(
      children: <Widget>[
        Text(
          'You have pushed the button this many times: ${widget.title}',
        ),
        _listWidget()
      ],
    );
  }

  Widget _listWidget() {
    return Expanded(
        child: ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return const TransactionRowWidget();
      },
    ));
  }

  FloatingActionButton _fab() {
    return const FloatingActionButton(
      onPressed: null,
      tooltip: 'Increment',
      backgroundColor: Colors.white,
      child: Icon(
        Icons.add,
        size: 32,
        color: Colors.black,
      ),
    );
  }
}
