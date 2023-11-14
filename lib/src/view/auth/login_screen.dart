import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:uber_app/src/service/auth_service.dart';
import 'package:uber_app/src/share/app_text_field.dart';
import 'package:uber_app/src/share/custom_button.dart';
import 'package:uber_app/src/share/passenger_bottom_navigation_bar.dart';
import 'package:uber_app/src/style/app_color.dart';
import 'package:uber_app/src/style/social_media_button.dart';
import 'package:uber_app/src/view/Driver/driver_buttom_navigator.dart';
import 'package:uber_app/src/view/Passenger/passenger_buttom_navigator.dart';
import 'package:uber_app/src/view/auth/sign_up.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final logIn = Get.put(AuthService());
  final _key = GlobalKey<FormState>();
  static final auth = FirebaseAuth.instance.currentUser?.uid;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
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
              key: _key,
              child: Column(
                children: [
                  TextForm(
                    title: "Email",
                    prefixIcon: Icons.alternate_email,
                    controller: logIn.logEmail.value,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value){
                      return value!.isEmpty ? "Please Enter your Email" : null;
                    },
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  TextForm(
                    title: "Password",
                    prefixIcon: Icons.key,
                    suffixIcon: Icons.visibility,
                    controller: logIn.logPassword.value,
                    obscureText: true,
                    validator: (value){
                      return value!.isEmpty ? "Please Enter your Password" : null;
                    },
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
            Obx((){
              return CustomButton(
                loading: logIn.loading.value,
                text: "Login",
                height: height * 0.065,
                width: width * 1,
                onTap: (){
                  logIn.Login(context).then((value){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PassengerNavigator()));
                  });
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
              );
            }),
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
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
