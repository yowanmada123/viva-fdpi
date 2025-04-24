import 'package:flutter/material.dart';

import '../driver/driver_dashboard_screen.dart';
import '../profile/profile_screen.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int currentIndex;

  const CustomBottomNavigationBar({this.currentIndex = 0, super.key});

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  final List<Map<String, dynamic>> _navigationItems = [
    {"label": "Home", "icon": Icons.home, "route": DriverDashboardScreen()},
    {"label": "Profile", "icon": Icons.person, "route": ProfileScreen()},
  ];

  void _onItemTapped(int index) {
    if (index == widget.currentIndex) return;

    if (index == 0) {
      Navigator.popUntil(context, (route) => route.isFirst);
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return _navigationItems[index]['route'];
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Color(0xFFA4C8FF),
      currentIndex: widget.currentIndex,
      items:
          _navigationItems
              .map(
                (item) => BottomNavigationBarItem(
                  icon: Icon(item['icon']),
                  label: item['label'],
                ),
              )
              .toList(),
      selectedItemColor: Colors.white,
      unselectedItemColor: Color(0xff1C3FAA),
      onTap: _onItemTapped,
    );
  }
}
