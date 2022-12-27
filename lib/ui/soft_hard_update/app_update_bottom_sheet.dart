import 'package:flutter/material.dart';

class AppUpdateBottomSheet extends StatelessWidget {
  final VoidCallback onUpdateClick;
  final bool isDismissable;

  const AppUpdateBottomSheet(
      {Key? key, required this.onUpdateClick, required this.isDismissable})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isDismissable) crossIcon(),
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
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10), topLeft: Radius.circular(10)),
          color: Colors.white,
        ));
  }

  Widget crossIcon() {
    return Align(
      alignment: Alignment.topRight,
      child: InkWell(
        child: const Icon(
          Icons.cancel,
          size: 30,
          color: Colors.black,
        ),
        onTap: onCrossClick,
      ),
    );
  }

  Widget headerWidget() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: const Text(
        "New Update Available!",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
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
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
        ),
        onPressed: onClick,
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black, padding: const EdgeInsets.all(10)),
      ),
    ));
  }

  void onCrossClick() {
    // Navigator.pop(navigatorKey.currentContext!);
  }

  void onClick() {
    updateButtonAnalytics();
    onUpdateClick();
  }

  void updateButtonAnalytics() {
    // String eventName = AnalyticsHelper.softUpdateButtonClick;
    // // if sheet's not dismissable, then it's a hard update
    // if (!isDismissable) {
    //   eventName = AnalyticsHelper.hardUpdateButtonClick;
    // }
    // AnalyticsHelper.LogEvent(event: eventName);
  }
}