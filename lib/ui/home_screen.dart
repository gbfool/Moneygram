import 'package:flutter/material.dart';
import 'package:moneygram/ui/add_transaction_page.dart';
import 'package:moneygram/ui/transaction_row_header_widget.dart';
import 'package:moneygram/ui/transaction_row_widget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

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
      itemCount: 20,
      itemBuilder: (context, index) {
        if (index % 4 == 0) {
          return TransactionRowHeaderWidget();
        }
        return const TransactionRowWidget();
      },
    ));
  }

  FloatingActionButton _fab() {
    return FloatingActionButton(
      onPressed: _onFabClick,
      tooltip: 'Add Transaction',
      backgroundColor: Colors.white,
      child: const Icon(
        Icons.add,
        size: 32,
        color: Colors.black,
      ),
    );
  }

  void _onFabClick() {
    showBarModalBottomSheet(
      context: context,
      expand: false,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddTransactionPage(),
    );
  }
}
