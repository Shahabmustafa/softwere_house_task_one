import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:uber_app/src/service/auth_service.dart';
import 'package:uber_app/src/view/auth/select_user.dart';

import '../../share/app_text_field.dart';
import '../../share/custom_button.dart';
import '../../style/app_color.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _key = GlobalKey<FormState>();
  final signUp = Get.put(AuthService());
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
              key: _key,
              child: Column(
                children: [
                  TextForm(
                    title: "User Name",
                    prefixIcon: Icons.person,
                    controller: signUp.userName.value,
                    validator: (value){
                      return value!.isEmpty ? "Please Enter your User Name" : null;
                    },
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  TextForm(
                    title: "Phone Number",
                    prefixIcon: Icons.phone,
                    controller: signUp.phoneNumber.value,
                    keyboardType: TextInputType.phone,
                    validator: (value){
                      return value!.isEmpty ? "Please Enter your Phone Number" : null;
                    },
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  TextForm(
                    title: "Email",
                    prefixIcon: Icons.alternate_email,
                    controller: signUp.email.value,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value){
                      return value!.isEmpty ? "Please Enter your Enter Your Number" : null;
                    },
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  TextForm(
                    title: "Password",
                    keyboardType: TextInputType.visiblePassword,
                    prefixIcon: Icons.key,
                    suffixIcon: Icons.visibility,
                    controller: signUp.password.value,
                    obscureText: true,
                    validator: (value){
                      return value!.isEmpty ?
                      "Please Enter your Password" :
                      value.length < 8 ? "Please Enter Your Strong Password" :
                      null;
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.04,
            ),
            Obx((){
              return CustomButton(
                loading: signUp.loading.value,
                text: "Sign Up",
                height: height * 0.065,
                width: width * 1,
                onTap: (){
                  if(_key.currentState!.validate()){
                    signUp.SignIn(context);
                  }
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
            CustomButton(
              height: height * 0.06,
              width: width * 1,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: AppColor.blackColor
                  )
              ),
              text: "Login",
              textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17
              ),
              onTap: (){
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
