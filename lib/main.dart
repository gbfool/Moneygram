import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moneygram/di/service_locator.dart';
import 'package:moneygram/ui/bottom_navigation_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await setupLocator();
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
