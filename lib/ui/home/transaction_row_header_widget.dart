import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneygram/utils/currency_helper.dart';
import 'package:moneygram/utils/enum/filter_budget.dart';
import 'package:moneygram/utils/time_extension.dart';

class TransactionRowHeaderWidget extends StatelessWidget {
  final DateTime dateTime;
  final double total;
  const TransactionRowHeaderWidget(
      {Key? key, required this.dateTime, required this.total})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
      child: _body(),
    );
  }

  Widget _body() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _date(),
        const Spacer(),
        const SizedBox(width: 12),
        Text(
          CurrencyHelper.formattedCurrency(total),
          style: GoogleFonts.lato(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black.withOpacity(0.5)),
        ),
      ],
    );
  }

  Widget _date2() {
    return Text(
      dateTime.formatted(FilterBudget.daily),
      style: GoogleFonts.lato(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: Colors.black.withOpacity(0.5)),
    );
  }

  Widget _date() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          child: Text(
            dateTime.decoratedDay,
            style: GoogleFonts.lato(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.black.withOpacity(0.8)),
          ),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              dateTime.decoratedWeek,
              style: GoogleFonts.lato(fontSize: 14, color: Colors.black),
            ),
            const SizedBox(height: 2),
            Text(
              dateTime.decoratedMonthAndYear,
              style: GoogleFonts.lato(
                  fontSize: 12, color: Colors.black.withOpacity(0.4)),
            ),
          ],
        ),
      ],
    );
  }
}
