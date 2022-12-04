import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isEnable;
  const SaveButton({Key? key, required this.isEnable, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isEnable ? onTap : null,
      child: Container(
        height: 48,
        margin: EdgeInsets.only(top: 12, left: 16, right: 16),
        alignment: Alignment.center,
        child: Text(
          "Save",
          style: TextStyle(
              fontSize: 20, color: isEnable ? Colors.white : Color(0xff81818d)),
        ),
        decoration: BoxDecoration(
            color: isEnable ? Colors.black : Color(0xffebeaef),
            borderRadius: BorderRadius.all(Radius.circular(24))),
      ),
    );
  }
}
