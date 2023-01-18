import 'package:flutter/material.dart';
import 'package:moneygram/utils/custom_colors.dart';

class KeyboardHelper {
  static KeyboardHelper? _instance;
  late List<List<dynamic>> keys;

  static KeyboardHelper get instance {
    if (_instance == null) {
      _instance = KeyboardHelper._internal();
    }

    return _instance!;
  }

  KeyboardHelper._internal() {
    setKeys();
  }

  void setKeys() {
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
        Icon(
          Icons.backspace_outlined,
          color: CustomColors.primaryColor,
        ),
      ],
    ];
  }
}
