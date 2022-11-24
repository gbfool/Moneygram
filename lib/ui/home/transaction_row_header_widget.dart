import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TransactionRowHeaderWidget extends StatefulWidget {
  const TransactionRowHeaderWidget({Key? key}) : super(key: key);

  @override
  State<TransactionRowHeaderWidget> createState() =>
      _TransactionRowHeaderWidgetState();
}

class _TransactionRowHeaderWidgetState
    extends State<TransactionRowHeaderWidget> {
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
            "12th Nov 2022",
            style: GoogleFonts.lato(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.black.withOpacity(0.5)),
          ),
        ),
        const Spacer(),
        const SizedBox(width: 12),
        Text(
          "\$600",
          style: GoogleFonts.lato(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.black.withOpacity(0.5)),
        ),
      ],
    );
  }
}
