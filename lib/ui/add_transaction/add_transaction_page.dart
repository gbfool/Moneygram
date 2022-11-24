import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneygram/ui/add_transaction/amount_widget.dart';
import 'package:moneygram/ui/add_transaction/header_widget.dart';
import 'package:moneygram/ui/add_transaction/keyboard_widget.dart';
import 'package:moneygram/ui/add_transaction/save_button.dart';
import 'package:moneygram/ui/keyboard/keyboard_key.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({Key? key}) : super(key: key);

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  String amount = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        /*This method here will hide the soft keyboard.*/
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Container(
        color: Colors.white,
        child: SafeArea(
          minimum: EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              HeaderWidget(),
              Expanded(child: AmountWidget(amount: amount)),
              _renderActions(),
              KeyboardWidget(
                  onBackPress: onBackspacePress, onKeyPress: onKeyTap),
              SaveButton()
            ],
          ),
        ),
      ),
    );
  }

  onKeyTap(val) {
    setState(() {
      amount = amount + val;
    });
  }

  onBackspacePress() {
    if (amount.isEmpty) {
      return;
    }

    setState(() {
      amount = amount.substring(0, amount.length - 1);
    });
  }

  _renderActions() {
    return Container(
      padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
      child: Column(
        children: [
          Row(children: [
            Text("Today"),
            const SizedBox(width: 4),
            const Text(
              '\u2022',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(width: 4),
            Expanded(child: _inputField())
          ]),
          SizedBox(height: 6),
          Divider(height: 1, thickness: 0),
          SizedBox(height: 12),
          _accountCategory(),
          SizedBox(height: 12),
          Divider(height: 1, thickness: 0)
        ],
      ),
    );
  }

  Widget _accountCategory() {
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Text("💳", style: GoogleFonts.notoEmoji(fontSize: 24)),
      SizedBox(width: 4),
      Text(
        "Credit Card",
        style: GoogleFonts.pacifico(fontSize: 16),
      ),
      SizedBox(width: 12),
      Icon(Icons.arrow_forward),
      SizedBox(width: 12),
      Text("🍿", style: GoogleFonts.notoEmoji(fontSize: 24)),
      SizedBox(width: 4),
      Text(
        "Enterntainment",
        style: TextStyle(fontSize: 16),
      ),
    ]);
  }

  Widget _inputField() {
    return TextField(
      cursorColor: Colors.black,
      decoration:
          InputDecoration(border: InputBorder.none, hintText: "Add notes"),
    );
  }
}
