import 'package:flutter/material.dart';

class SettingsRowWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  const SettingsRowWidget(
      {Key? key, required this.title, required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 12),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          title,
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(color: Colors.black.withOpacity(0.7)),
        )
      ]),
    );
  }
}
