import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneygram/utils/currency_helper.dart';
import 'package:moneygram/utils/custom_colors.dart';
import 'package:moneygram/utils/enum/filter_budget.dart';
import 'package:moneygram/utils/time_extension.dart';

class TransactionRowHeaderWidget extends StatelessWidget {
  final DateTime dateTime;
  final double expense;
  final double income;
  const TransactionRowHeaderWidget(
      {Key? key,
      required this.dateTime,
      required this.expense,
      required this.income})
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
        ..._amountWidget("E", expense),
        const SizedBox(width: 6),
        ..._amountWidget("I", income),
      ],
    );
  }

  // ignore: unused_element
  Widget _date2() {
    return Text(
      dateTime.formatted(FilterBudget.daily),
      style: GoogleFonts.lato(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: CustomColors.primaryColor.withOpacity(0.5)),
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
                color: CustomColors.primaryColor.withOpacity(0.8)),
          ),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              dateTime.decoratedWeek,
              style: GoogleFonts.lato(
                  fontSize: 14, color: CustomColors.primaryColor),
            ),
            Text(
              dateTime.decoratedMonthAndYear,
              style: GoogleFonts.lato(
                  fontSize: 12,
                  color: CustomColors.primaryColor.withOpacity(0.4)),
            ),
          ],
        ),
      ],
    );
  }

  List<Widget> _amountWidget(String symbol, double amount) {
    List<Widget> widgets = [];
    var symbolWidget = Container(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Text(symbol, style: TextStyle(fontWeight: FontWeight.w600)),
      decoration: BoxDecoration(
          color: CustomColors.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(4)),
    );
    widgets.add(symbolWidget);
    widgets.add(SizedBox(width: 4));
    widgets.add(Text(
      CurrencyHelper.formattedCurrency(amount),
      style: GoogleFonts.lato(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: CustomColors.primaryColor.withOpacity(0.5)),
    ));
    return widgets;
  }
}
