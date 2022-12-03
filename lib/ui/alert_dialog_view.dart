import 'package:flutter/material.dart';

class AlertDialogView extends StatelessWidget {
  final String title;
  final String description;
  final String leftButtonText;
  final String rightButtonText;
  final VoidCallback onTapLeftButton;
  final VoidCallback onTapRightButton;
  const AlertDialogView({
    Key? key,
    required this.title,
    required this.description,
    required this.leftButtonText,
    required this.rightButtonText,
    required this.onTapLeftButton,
    required this.onTapRightButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 20)),
        const SizedBox(height: 12),
        Text(description),
        const SizedBox(height: 12),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          _buildButton(text: leftButtonText, callback: onTapLeftButton),
          const SizedBox(width: 12),
          _buildButton(text: rightButtonText, callback: onTapRightButton),
        ])
      ],
    ));
  }

  Widget _buildButton({required String text, required VoidCallback callback}) {
    return InkWell(
      onTap: callback,
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.black, width: 0.1)),
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 32),
          child: Text(text)),
    );
  }
}
