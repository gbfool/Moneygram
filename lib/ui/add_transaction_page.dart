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
    keys = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
      [
        '.',
        '0',
        const Icon(
          Icons.backspace,
          color: Colors.black,
        )
      ],
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _topHeader(),
            const SizedBox(height: 16),
            _amountWidget(),
            const Spacer(),
            _renderActions(),
            ...renderKeyboard(),
          ],
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
          style: TextStyle(color: textColor, fontSize: 32),
        ),
        const SizedBox(width: 2),
        renderAmount(),
        // _inputField(),
      ],
    );
  }

  Widget renderAmount() {
    TextStyle style = const TextStyle(
        color: Colors.grey, fontWeight: FontWeight.w600, fontSize: 32);
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
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
      color: Colors.black.withOpacity(0.3),
      child: Row(children: [Spacer(), Icon(Icons.send, size: 24)]),
    );
  }

  renderKeyboard() {
    return keys
        .map(
          (x) => Row(
            children: x.map(
              (y) {
                return Expanded(
                  child: Container(
                    color: Colors.white,
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
                  ),
                );
              },
            ).toList(),
          ),
        )
        .toList();
  }
}
