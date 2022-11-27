import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneygram/account/data_source/account_local_data_source.dart';
import 'package:moneygram/category/data_source/category_local_data_source.dart';
import 'package:moneygram/transactions/models/transaction.dart';
import 'package:moneygram/utils/currency_helper.dart';

class TransactionRowWidget extends StatefulWidget {
  final Transaction transaction;
  final AccountLocalDataSource accountLocalDataSource;
  final CategoryLocalDataSource categoryLocalDataSource;
  const TransactionRowWidget(
      {Key? key,
      required this.transaction,
      required this.accountLocalDataSource,
      required this.categoryLocalDataSource})
      : super(key: key);

  @override
  State<TransactionRowWidget> createState() => _TransactionRowWidgetState();
}

class _TransactionRowWidgetState extends State<TransactionRowWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: _body(),
    );
  }

  Widget _body() {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        child: Text(
          widget.categoryLocalDataSource
              .fetchCategory(widget.transaction.categoryId)
              .emoji,
          style: GoogleFonts.notoEmoji(fontSize: 24),
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        widget.categoryLocalDataSource
                            .fetchCategory(widget.transaction.categoryId)
                            .name,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600)),
                    SizedBox(height: 8),
                    Text(widget.transaction.notes ?? "",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black.withOpacity(0.6))),
                  ],
                ),
                const Spacer(),
                const SizedBox(width: 12),
                Text(
                    CurrencyHelper.formattedCurrency(widget.transaction.amount),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600))
              ],
            ),
            const SizedBox(height: 16),
            const Divider(
              height: 1,
              thickness: 1,
            )
          ],
        ),
      )
    ]);
  }
}
