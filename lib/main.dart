import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moneygram/category/category_hive_helper.dart';
import 'package:moneygram/di/service_locator.dart';
import 'package:moneygram/ui/bottom_navigation_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await setupLocator();
  CategoryHiveHelper().addCategoriesInHive();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      title: 'Money',
      home: BottomNavigationState(),
    );
  }
}
