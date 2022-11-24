import 'package:flutter/material.dart';
import 'package:moneygram/ui/bottom_navigation_state.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          androidOverscrollIndicator: AndroidOverscrollIndicator.stretch),
      title: 'Money',
      home: BottomNavigationState(),
    );
  }
}
