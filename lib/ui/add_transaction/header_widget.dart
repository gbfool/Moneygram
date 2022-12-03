import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:moneygram/ui/alert_dialog_view.dart';
import 'package:moneygram/ui/modal_fit.dart';

enum Options { delete }

class HeaderWidget extends StatefulWidget {
  final bool isSync;
  const HeaderWidget({
    required this.isSync,
    Key? key,
  }) : super(key: key);

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 12, right: 12, top: 8),
        child: IntrinsicHeight(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("isSync: ${widget.isSync}",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                          fontSize: 12, fontWeight: FontWeight.w600)),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text("Add transaction",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                          fontSize: 18, fontWeight: FontWeight.w600)),
                ),
                Align(
                    alignment: Alignment.centerRight, child: _buildPopupMenu())
              ],
            ),
            const SizedBox(height: 8),
            Divider(height: 1, thickness: 0)
          ],
        )));
  }

  Widget _buildPopupMenu() {
    return PopupMenuButton(
      padding: EdgeInsets.zero,
      child: Container(
        height: 36,
        width: 48,
        alignment: Alignment.center,
        child: Icon(
          Icons.more_vert,
        ),
      ),
      onSelected: (value) {
        _onMenuItemSelected(value as int);
      },
      offset: Offset(0.0, 40),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8.0),
          bottomRight: Radius.circular(8.0),
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
      ),
      itemBuilder: (ctx) => [
        _buildPopupMenuItem(
            'Delete', Icons.delete_outline, Options.delete.index),
      ],
    );
  }

  PopupMenuItem _buildPopupMenuItem(
      String title, IconData iconData, int position) {
    return PopupMenuItem(
      value: position,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            iconData,
            color: Colors.black,
          ),
          Text(title),
        ],
      ),
    );
  }

  _onMenuItemSelected(int value) async {
    print(value);
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialogView(
              title: "Delete Transaction?",
              description: "Are you sure you want to delete this transaction?",
              leftButtonText: "No",
              rightButtonText: "Yes",
              onTapLeftButton: () {
                Navigator.of(context).pop();
              },
              onTapRightButton: () {});
        });
  }

  void _openMenuOptions() {
    showMaterialModalBottomSheet(
      expand: false,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => ModalFit(),
    );
  }
}
