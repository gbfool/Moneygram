import 'package:flutter/material.dart';
import 'package:moneygram/main.dart';
import 'package:moneygram/utils/analytics_helper.dart';
import 'package:moneygram/utils/custom_colors.dart';

class AppUpdateBottomSheet extends StatelessWidget {
  final VoidCallback onUpdateClick;
  final bool isDismissible;

  const AppUpdateBottomSheet(
      {Key? key, required this.onUpdateClick, required this.isDismissible})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isDismissible) crossIcon(),
            const SizedBox(height: 48),
            const Icon(
              Icons.system_update_outlined,
              size: 80,
            ),
            const SizedBox(height: 48),
            headerWidget(),
            descriptionWidget(),
            const SizedBox(height: 48),
            updateButtonWidget()
          ],
        ),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10), topLeft: Radius.circular(10)),
          color: CustomColors.secondaryColor,
        ));
  }

  Widget crossIcon() {
    return Align(
      alignment: Alignment.topRight,
      child: InkWell(
        child: Icon(
          Icons.cancel,
          size: 30,
          color: CustomColors.primaryColor,
        ),
        onTap: onCrossClick,
      ),
    );
  }

  Widget headerWidget() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Text(
        "New Update Available!",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: CustomColors.primaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget descriptionWidget() {
    return Container(
        child: const Text(
            "A new update of this app is now available. Update now!",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, fontSize: 16)));
  }

  Widget updateButtonWidget() {
    return SafeArea(
        child: SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        child: Text(
          "Update".toUpperCase(),
          style: TextStyle(
              color: CustomColors.secondaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 18),
        ),
        onPressed: onClick,
        style: ElevatedButton.styleFrom(
            backgroundColor: CustomColors.primaryColor,
            padding: const EdgeInsets.all(10)),
      ),
    ));
  }

  void onCrossClick() {
    AnalyticsHelper.logEvent(
        event: AnalyticsHelper.softUpdateCrossButtonClicked);
    Navigator.of(navigatorKey.currentContext!).pop();
  }

  void onClick() {
    updateButtonAnalytics();
    onUpdateClick();
  }

  void updateButtonAnalytics() {
    String eventName = AnalyticsHelper.softUpdateButtonClicked;
    // if sheet's not dismissible, then it's a hard update
    if (!isDismissible) {
      eventName = AnalyticsHelper.hardUpdateButtonClicked;
    }
    AnalyticsHelper.logEvent(event: eventName);
  }
}
