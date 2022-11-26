import 'package:flutter/material.dart';
import 'package:moneygram/di/service_locator.dart';
import 'package:moneygram/transactions/models/transaction.dart';
import 'package:moneygram/ui/home/transaction_row_header_widget.dart';
import 'package:moneygram/ui/home/transaction_row_widget.dart';

class TransactionCardWidget extends StatefulWidget {
  final String title;
  final double total;
  final List<Transaction> transactions;
  const TransactionCardWidget(
      {Key? key,
      required this.title,
      required this.total,
      required this.transactions})
      : super(key: key);

  @override
  State<TransactionCardWidget> createState() => _TransactionCardWidgetState();
}

class _TransactionCardWidgetState extends State<TransactionCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        TransactionRowHeaderWidget(title: widget.title, total: widget.total),
        const SizedBox(height: 8),
        _transactionList()
      ]),
    );
  }

  Widget _transactionList() {
    return ListView.builder(
        itemCount: widget.transactions.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          var transaction = widget.transactions[index];
          print(transaction.toJson());
          return TransactionRowWidget(
              transaction: transaction,
              accountLocalDataSource: locator.get(),
              categoryLocalDataSource: locator.get());
        });
  }
}
