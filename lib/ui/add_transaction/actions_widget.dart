import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneygram/models/category.dart';
import 'package:moneygram/utils/utils.dart';

class ActionsWidget extends StatefulWidget {
  const ActionsWidget({Key? key}) : super(key: key);

  @override
  State<ActionsWidget> createState() => _ActionsWidgetState();
}

class _ActionsWidgetState extends State<ActionsWidget> {
  @override
  Widget build(BuildContext context) {
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

  Widget _inputField() {
    return TextField(
      cursorColor: Colors.black,
      decoration:
          InputDecoration(border: InputBorder.none, hintText: "Add notes"),
    );
  }

  Widget _accountCategory() {
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      ..._emojiWidget(category: Category(emoji: "💳", text: "Credit Card")),
      SizedBox(width: 12),
      Icon(Icons.arrow_forward),
      SizedBox(width: 12),
      ..._emojiWidget(category: Category(emoji: "🍿", text: "Entertainment")),
    ]);
  }

  List<Widget> _emojiWidget({required Category category}) {
    List<Widget> widgets = [
      Text(category.emoji, style: GoogleFonts.notoEmoji(fontSize: 24)),
      SizedBox(width: 4),
      Flexible(
        child: Text(
          category.text,
          style: TextStyle(fontSize: 16),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      )
    ];
    return widgets;
  }
}
