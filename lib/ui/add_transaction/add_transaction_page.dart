import 'package:flutter/material.dart';
import 'package:moneygram/ui/add_transaction/actions_widget.dart';
import 'package:moneygram/ui/add_transaction/amount_widget.dart';
import 'package:moneygram/ui/add_transaction/header_widget.dart';
import 'package:moneygram/ui/add_transaction/keyboard_widget.dart';
import 'package:moneygram/ui/add_transaction/save_button.dart';

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
              ActionsWidget(),
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
}
