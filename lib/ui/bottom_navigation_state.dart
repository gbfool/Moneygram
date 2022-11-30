import 'dart:async';

import 'package:flutter/material.dart';
import 'package:moneygram/ui/home/home_screen.dart';
import 'package:moneygram/ui/settings/settings_screen.dart';

class BottomNavigationState extends StatefulWidget {
  const BottomNavigationState({
    Key? key,
  }) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _BottomNavigationState extends State<BottomNavigationState> {
  int _selectedIndex = 0;

  final int HOME_SCREEN = 0;
  final int SETTINGS_SCREEN = 1;

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(title: "adfad"),
    SettingsScreen()
  ];

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: iconEmojiWidget(Icons.settings, Colors.grey),
              activeIcon: iconEmojiWidget(Icons.settings, Colors.black),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: iconEmojiWidget(Icons.settings, Colors.grey),
              activeIcon: iconEmojiWidget(Icons.settings, Colors.black),
              label: 'Settings',
            ),
          ],
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.black,
          selectedFontSize: 14,
          unselectedFontSize: 14,
          unselectedItemColor: Colors.grey,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
      onWillPop: () => _onWillPop(),
    );
  }

  Widget iconEmojiWidget(IconData iconString, Color color) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 4),
      child: Icon(iconString),
    );
  }

  Future<bool> _onWillPop() async {
    // upon mobile back button press navigate to event tab from other tabs
    if (_selectedIndex != HOME_SCREEN) {
      setState(() {
        _selectedIndex = HOME_SCREEN;
      });
      return false;
    }
    return true;
  }
}
