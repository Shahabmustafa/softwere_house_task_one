import 'package:flutter/material.dart';
import 'package:uber_app/src/share/app_text_field.dart';
import 'package:uber_app/src/share/custom_button.dart';
import 'package:uber_app/src/style/app_color.dart';
import 'package:uber_app/src/style/app_text_style.dart';
import 'package:uber_app/src/style/social_media_button.dart';
import 'package:uber_app/src/view/auth/phone_otp_send.dart';
import 'package:uber_app/src/view/auth/select_user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              child: Column(
                children: [
                  TextForm(
                    title: "Email",
                    prefixIcon: Icons.alternate_email,
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  TextForm(
                    title: "Password",
                    prefixIcon: Icons.key,
                    suffixIcon: Icons.visibility,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: (){},
                  child: Text(
                    "Forgot Password",
                    style: TextStyle(
                      color: AppColor.blackColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ),
              ],
            ),
            CustomButton(
              text: "Continue",
              height: height * 0.065,
              width: width * 1,
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => SelectUser()));
              },
              textStyle: TextStyle(
                color: AppColor.whiteColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              decoration: BoxDecoration(
                color: AppColor.blackColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            SizedBox(
              height: height * 0.04,
            ),
            Row(
              children: [
                Flexible(child: Divider(thickness: 2,)),
                SizedBox(width: width * 0.03,),
                Text("or"),
                SizedBox(width: width * 0.03,),
                Flexible(child: Divider(thickness: 2,)),
              ],
            ),
            SizedBox(
              height: height * 0.02,
            ),
            CustomButton(
              height: height * 0.06,
              width: width * 1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColor.blackColor
                )
              ),
              text: "Sign Up",
              textStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17
              ),
              onTap: (){

              },
            ),
            SizedBox(
              height: height * 0.02,
            ),
            SocialMediaButton(
                height: height * 0.065,
                width: width * 1,
                title: "Continue with Google",
                imageUrl: "google.png"
            ),
            SizedBox(
              height: height * 0.01,
            ),
            SocialMediaButton(
                height: height * 0.065,
                width: width * 1,
                title: "Continue with Apple",
                imageUrl: "apple-logo.png"
            ),
          ],
        ),
      ),
    );
  }
}
