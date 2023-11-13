


import 'package:flutter/material.dart';
import 'package:uber_app/src/share/custom_button.dart';
import 'package:uber_app/src/style/app_color.dart';
import 'package:uber_app/src/style/app_text_style.dart';
import 'package:uber_app/src/view/auth/login_screen.dart';

class StartedPage extends StatefulWidget {
  const StartedPage({Key? key}) : super(key: key);

  @override
  State<StartedPage> createState() => _StartedPageState();
}

class _StartedPageState extends State<StartedPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: AppColor.blueColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text(
                "Uber",
                style: TextStyle(
                  color: AppColor.whiteColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 30,
                ),
              ),
              SizedBox(
                height: height * 0.1,
              ),
              Image.asset(
                "assets/images/shield.png",
                height: height * 0.2,
                width: width * 0.4,
              ),
              SizedBox(
                height: height * 0.1,
              ),
              Text(
                "Move with Safety",
                style: TextStyle(
                  color: AppColor.whiteColor,
                  fontWeight: AppTextStyle.largeThinkness,
                  fontSize: 30,
                ),
              ),
            ],
          ),
          Center(
            child: CustomButton(
              text: "Get Started",
              height: height * 0.065,
              width: width * 0.95,
              textStyle: TextStyle(
                color: AppColor.whiteColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              decoration: BoxDecoration(
                color: AppColor.blackColor,
                borderRadius: BorderRadius.circular(10),
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
