import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneygram/ui/keyboard/keyboard_key.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({Key? key}) : super(key: key);

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

// class _AddTransactionPageState extends State<AddTransactionPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//           child: Column(children: [Container(child: Text("Submit"))])),
//     );
//   }
// }

class _AddTransactionPageState extends State<AddTransactionPage> {
  late List<List<dynamic>> keys;
  String amount = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    keys = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      [
        '7',
        '8',
        '9',
      ],
      [
        '.',
        '0',
        const Icon(
          Icons.backspace,
          color: Colors.black,
        )
      ],
    ];
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
              _topHeader(),
              const SizedBox(height: 16),
              Expanded(child: _amountWidget()),
              // Spacer(),
              _renderActions(),
              Container(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(children: renderKeyboard()),
              ),
              _submitButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget _topHeader() {
    return Container(
        padding: const EdgeInsets.only(left: 12, right: 12, top: 16),
        color: Colors.white,
        child: IntrinsicHeight(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text("Add transaction",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                          fontSize: 18, fontWeight: FontWeight.w600)),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Cancel')),
                )
              ],
            ),
            const SizedBox(height: 16),
            Divider(height: 1, thickness: 0)
          ],
        )));
  }

  Widget _amountWidget() {
    Color textColor = amount.isEmpty ? Colors.grey : Colors.black;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "\$",
          style: TextStyle(color: textColor, fontSize: 40),
        ),
        const SizedBox(width: 2),
        renderAmount(),
        // _inputField(),
      ],
    );
  }

  Widget renderAmount() {
    TextStyle style = const TextStyle(
        color: Colors.grey, fontWeight: FontWeight.w600, fontSize: 48);
    String display = "0";
    if (amount.isNotEmpty) {
      // NumberFormat f = NumberFormat('#,###');
      display = amount;
      // display = f.format(int.parse(amount));
      style = style.copyWith(
        color: Colors.black,
      );
    }
    return Text(display, style: style);
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

  renderKeyboard() {
    return keys
        .map(
          (x) => Row(
            children: x.map(
              (y) {
                print(x);
                print(y);
                return Expanded(
                  child: KeyboardKey(
                    label: y,
                    value: y,
                    onTap: (val) {
                      if (val is Widget) {
                        onBackspacePress();
                      } else {
                        onKeyTap(val);
                      }
                    },
                  ),
                );
              },
            ).toList(),
          ),
        )
        .toList();
  }

  Widget _submitButton() {
    return Container(
      color: Color(0xFAFAFA),
      padding: EdgeInsets.only(top: 12, left: 16, right: 16),
      child: Container(
        height: 48,
        alignment: Alignment.center,
        child: Text(
          "Save",
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        decoration: BoxDecoration(
            color: Colors.black,
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.03),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.all(Radius.circular(24))),
      ),
    );
  }
}
