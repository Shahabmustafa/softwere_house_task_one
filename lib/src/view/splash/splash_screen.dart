import 'dart:async';

import 'package:flutter/material.dart';
import 'package:uber_app/src/style/app_color.dart';
import 'package:uber_app/src/view/splash/started_screen.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  isStarted(){
    Timer(Duration(seconds: 3),(){
      Navigator.push(context, MaterialPageRoute(builder: (context) => StartedPage()));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isStarted();
  }
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColor.blackColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
                "Uber",
              style: TextStyle(
                color: AppColor.whiteColor,
                fontSize: 100,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
