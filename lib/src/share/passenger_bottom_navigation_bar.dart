import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:uber_app/src/style/app_color.dart';
import 'package:uber_app/src/view/Passenger/passenger_history.dart';
import 'package:uber_app/src/view/Passenger/passenger_payment_method.dart';
import 'package:uber_app/src/view/Passenger/passenger_profile.dart';

import '../view/Passenger/show_driver_list.dart';
import '../view/chat/chats_screen.dart';

class PassengerBottomNavigatorBar extends StatefulWidget {
  const PassengerBottomNavigatorBar({Key? key}) : super(key: key);

  @override
  State<PassengerBottomNavigatorBar> createState() => _PassengerBottomNavigatorBarState();
}

class _PassengerBottomNavigatorBarState extends State<PassengerBottomNavigatorBar> {
  final controller = PersistentTabController(initialIndex: 0);
  List<Widget> _buildScreen(){
    return [
      ShowDriverList(),
      PassengerHistory(),
      ChatsPage(),
      PassengerPaymentMethode(),
      PassengerProfile(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarItem() {
    return [
      PersistentBottomNavBarItem(
        // title: 'Dashboard',
          icon: const Icon(Icons.home_filled),
          activeColorPrimary: AppColor.greyColor,
          activeColorSecondary: AppColor.blackColor,
          textStyle: TextStyle(color: AppColor.greyColor),
          inactiveIcon: const Icon(Icons.home_filled, color: Colors.grey,)
      ),
      PersistentBottomNavBarItem(
        // title: 'Shoping',
          icon: const Icon(Icons.history,),
          activeColorSecondary: AppColor.blackColor,
          activeColorPrimary: AppColor.greyColor,
          textStyle: TextStyle(color: Colors.grey),
          inactiveIcon: const Icon(Icons.history, color: Colors.grey,)
      ),
      PersistentBottomNavBarItem(
        // title: 'Post',
          icon: const Icon(Icons.message,),
          activeColorPrimary: AppColor.greyColor,
          activeColorSecondary: AppColor.blackColor,
          textStyle: TextStyle(color: Colors.grey),
          inactiveIcon: const Icon(Icons.message, color: Colors.grey,)
      ),
      PersistentBottomNavBarItem(
        // title: '',
          icon: const Icon(Icons.payment,),
          activeColorPrimary: AppColor.greyColor,
          activeColorSecondary: AppColor.blackColor,
          textStyle: TextStyle(color: Colors.grey),
          inactiveIcon: const Icon(Icons.payment, color: Colors.grey,)
      ),
      PersistentBottomNavBarItem(
        // title: 'Setting',
          icon: const Icon(Icons.person,),
          activeColorSecondary: AppColor.blackColor,
          activeColorPrimary: AppColor.greyColor,
          textStyle: TextStyle(color: Colors.grey),
          inactiveIcon: const Icon(Icons.person, color: Colors.grey,)
      ),
    ];
  }
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      screens: _buildScreen(),
      items: _navBarItem(),
      controller: controller,
      stateManagement: true,
      backgroundColor: Colors.white,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      navBarStyle: NavBarStyle.simple,
    );
  }
}