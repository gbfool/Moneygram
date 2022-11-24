import 'package:flutter/material.dart';

class KeyboardKey extends StatefulWidget {
  final dynamic label;
  final dynamic value;
  final ValueSetter<dynamic> onTap;

  const KeyboardKey({
    Key? key,
    required this.label,
    required this.value,
    required this.onTap,
  }) : super(key: key);

  @override
  _KeyboardKeyState createState() => _KeyboardKeyState();
}

class _KeyboardKeyState extends State<KeyboardKey> {
  renderLabel() {
    if (widget.label is Widget) {
      return widget.label;
    }

    return Container(
      alignment: Alignment.center,
      child: Text(
        widget.label,
        style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.white,
        child: Container(
          margin: EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: InkWell(
            onTap: () {
              widget.onTap(widget.value);
            },
            child: AspectRatio(
              aspectRatio: 1.8,
              child: renderLabel(),
            ),
          ),
        ));
  }
}
