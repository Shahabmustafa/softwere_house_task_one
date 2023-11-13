import 'package:flutter/material.dart';
import '../../share/passenger_bottom_navigation_bar.dart';

class PassengerNavigator extends StatefulWidget {
  const PassengerNavigator({Key? key}) : super(key: key);

  @override
  State<PassengerNavigator> createState() => _PassengerNavigatorState();
}

class _PassengerNavigatorState extends State<PassengerNavigator> {
  @override
  Widget build(BuildContext context) {
    return PassengerBottomNavigatorBar();
  }
}
