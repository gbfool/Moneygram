import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneygram/utils/currency_helper.dart';

class TransactionRowHeaderWidget extends StatelessWidget {
  final String title;
  final double total;
  const TransactionRowHeaderWidget(
      {Key? key, required this.title, required this.total})
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Text(
            title,
            style: GoogleFonts.lato(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.black.withOpacity(0.5)),
          ),
        ),
        const Spacer(),
        const SizedBox(width: 12),
        Text(
          CurrencyHelper.formattedCurrency(total),
          style: GoogleFonts.lato(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.black.withOpacity(0.5)),
        ),
      ],
    );
  }
}
