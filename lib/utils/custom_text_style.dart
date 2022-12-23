import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextStyle {
  static TextStyle emojiStyle(
      {double fontSize = 14, Color color = Colors.black}) {
    // return TextStyle(fontSize: fontSize, color: color);
    return GoogleFonts.notoEmoji(fontSize: fontSize, color: color);
  }
}
