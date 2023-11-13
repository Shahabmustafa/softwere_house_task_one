import 'package:flutter/material.dart';
import 'package:uber_app/src/share/custom_button.dart';
import 'package:uber_app/src/style/app_color.dart';
import 'package:uber_app/src/style/app_text_style.dart';
import 'package:uber_app/src/style/social_media_button.dart';
import 'package:uber_app/src/view/auth/phone_otp_send.dart';

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
            Column(
              children: [
                Text(
                  "Enter Your mobile number",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: AppTextStyle.largeThinkness,
                  ),
                ),
                Row(
                  children: [
                    Flexible(
                      child: Container(
                        height: height * 0.06,
                        width: width * 0.17,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10),
                          // border: Border.all(
                          //   color: AppColor.blackColor,
                          // ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.07,
                    ),
                    Container(
                      height: height * 0.06,
                      width: width * 0.7,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10),
                          // border: Border.all(
                          //   color: AppColor.blackColor,
                          // ),
                        ),
                      child: Center(
                        child: TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.phone),
                            hintText: "Mobile number",
                            border: InputBorder.none,
                            suffixIcon: Icon(Icons.person_add)
                        ),
                      ),
                        ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: height * 0.01,
            ),
            SizedBox(),
            CustomButton(
              text: "Continue",
              height: height * 0.065,
              width: width * 1,
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => PhoneoypPage()));
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
              height: height * 0.02,
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
                title: "Continue with email",
                imageUrl: "email.png"
            ),
          ],
        ),
      ),
    );
  }
}
