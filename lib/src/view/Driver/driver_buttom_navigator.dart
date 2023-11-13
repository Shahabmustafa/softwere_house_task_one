import 'package:flutter/material.dart';

import '../../share/driver_bottom_navigation_bar.dart';

class DriverButtomNavigator extends StatefulWidget {
  const DriverButtomNavigator({Key? key}) : super(key: key);

  @override
  State<DriverButtomNavigator> createState() => _DriverButtomNavigatorState();
}

class _DriverButtomNavigatorState extends State<DriverButtomNavigator> {
  @override
  Widget build(BuildContext context) {
    return DriverBottomNavigatorBar();
  }
}
