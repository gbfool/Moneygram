import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';
import 'package:moneygram/category/category_hive_helper.dart';
import 'package:moneygram/di/service_locator.dart';
import 'package:moneygram/feature_flags/feature_flag_helper.dart';
import 'package:moneygram/ui/bottom_navigation_state.dart';
import 'package:moneygram/utils/currency_helper.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
late Mixpanel mixPanel;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await setupLocator();
  // await initSentry();
  initMixpanel();
  await CurrencyHelper.setSettingLevelLocale();
  FeatureFlagHelper.instance.init();
  CategoryHiveHelper().addCategoriesInHive();
  runApp(const MyApp());
}

Future<void> initSentry() async {
  await SentryFlutter.init((options) {
    options.dsn =
        'https://1fdd11a606e64298807d4f68ace0b8ff@o4504464326066176.ingest.sentry.io/4504464334258176';
    // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
    // We recommend adjusting this value in production.
    options.tracesSampleRate = 1.0;
  });
}

Future<void> initMixpanel() async {
  String mixPanelToken = "5dd1a2c11d598f709a4ec52fde4e92d6";
  mixPanel = await Mixpanel.init(mixPanelToken);
  var distinctId = await mixPanel.getDistinctId();
  mixPanel.identify(distinctId);
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
      navigatorKey: navigatorKey,
      title: 'Money',
      home: BottomNavigationState(),
    );
  }
}
