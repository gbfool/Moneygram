import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TransactionRowWidget extends StatefulWidget {
  const TransactionRowWidget({Key? key}) : super(key: key);

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
          "😜",
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
                const Text("Food",
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
                const Spacer(),
                const SizedBox(width: 12),
                const Text("\$200",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600))
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
