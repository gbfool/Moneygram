import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneygram/utils/custom_colors.dart';

class CustomTextStyle {
  static TextStyle emojiStyle(
      {double fontSize = 14,
      Color? color,
      FontWeight fontWeight = FontWeight.w400}) {
        color = color ?? CustomColors.primaryColor;
    // return TextStyle(fontSize: fontSize, color: color);
    return GoogleFonts.notoEmoji(
        fontSize: fontSize, color: color, fontWeight: fontWeight);
  }
}
