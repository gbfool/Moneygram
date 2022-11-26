import 'package:flutter/material.dart';

class AmountWidget extends StatelessWidget {
  final String? amount;
  const AmountWidget({
    required this.amount,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color textColor =
        (amount == null || amount!.isEmpty) ? Colors.grey : Colors.black;
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
    if (amount != null && amount!.isNotEmpty) {
      // NumberFormat f = NumberFormat('#,###');
      display = amount!;
      // display = f.format(int.parse(amount));
      style = style.copyWith(
        color: Colors.black,
      );
    }
    return Text(display, style: style);
  }
}
