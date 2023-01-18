import 'package:flutter/material.dart';
import 'package:moneygram/feedback/feedback_screen.dart';
import 'package:moneygram/settings/currency/currency_screen.dart';
import 'package:moneygram/ui/account/manage_account_screen.dart';
import 'package:moneygram/ui/category/manage_category_screen.dart';
import 'package:moneygram/ui/settings/settings_row_widget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:moneygram/utils/analytics_helper.dart';
import 'package:moneygram/utils/currency_helper.dart';
import 'package:moneygram/utils/custom_colors.dart';
import 'package:moneygram/utils/utils.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 64),
        child: _content(),
      ),
    )));
  }

  Column _content() {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      _settingsLabel(),
      SizedBox(height: 32),
      SettingsGroup(
        title: "Preferences",
        children: [
          SettingsRowWidget(
            title: "Currency",
            subtitle: CurrencyHelper.getCurrencyName(),
            onTap: _openCurrencyScreen,
          ),
          SettingsRowWidget(
            title: "Account",
            subtitle: "view, edit and create accounts",
            onTap: _openManageAccountScreen,
          ),
          SettingsRowWidget(
              title: "Category",
              subtitle: "view, edit and create categories",
              onTap: _openManageCategoryScreen),
          // SettingsRowWidget(
          //   title: "Backup",
          //   subtitle:
          //       "Back up your expenses to Google Drive. You can restore them when you reinstall Moneygram",
          //   onTap: () {
          //     showBarModalBottomSheet(
          //         context: context,
          //         backgroundColor: Colors.transparent,
          //         builder: (context) => GoogleDriveBackupScreen());
          //   },
          // ),
        ],
      ),
      const SizedBox(height: 24),
      SettingsGroup(
        title: "Social",
        children: [
          SettingsRowWidget(
            title: "Give Feedback",
            subtitle:
                "Suggest your feedbacks and requests, to make this app awesome for you",
            onTap: _giveFeedbackClicked,
          ),
          SettingsRowWidget(
            title: "Rate app",
            subtitle: "Share your experience on Play Store",
            onTap: _rateAppClicked,
          ),
        ],
      )
    ]);
  }

  Widget _settingsLabel() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text("Settings",
          style: TextStyle(
              color: CustomColors.primaryColor,
              fontSize: 32,
              fontWeight: FontWeight.w600)),
    );
  }

  void _openCurrencyScreen() {
    AnalyticsHelper.logEvent(
        event: AnalyticsHelper.settingsCurrencySelectorClicked);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => CurrencyScreen()));
  }

  void _openManageAccountScreen() {
    AnalyticsHelper.logEvent(
        event: AnalyticsHelper.settingsManageAccountClicked);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ManageAccountScreen()));
  }

  void _openManageCategoryScreen() {
    AnalyticsHelper.logEvent(
        event: AnalyticsHelper.settingsManageCategoryClicked);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ManageCategoryScreen()));
  }

  void _giveFeedbackClicked() {
    AnalyticsHelper.logEvent(
        event: AnalyticsHelper.settingsGiveFeedbackClicked);
    showBarModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => FeedbackScreen());
  }

  void _rateAppClicked() {
    AnalyticsHelper.logEvent(event: AnalyticsHelper.settingsRateAppClicked);
    Utils.openPlayOrAppStore();
  }
}

class SettingsGroup extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const SettingsGroup({Key? key, required this.title, required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          title,
          style: TextStyle(
              color: CustomColors.primaryColor,
              fontSize: 24,
              fontWeight: FontWeight.w600),
        ),
      ),
      ...children,
    ]);
  }
}
