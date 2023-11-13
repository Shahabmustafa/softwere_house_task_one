


import 'package:flutter/material.dart';
import 'package:uber_app/src/share/app_text_field.dart';
import 'package:uber_app/src/share/custom_button.dart';
import 'package:uber_app/src/style/app_color.dart';

class DriverPaymentMethode extends StatefulWidget {
  const DriverPaymentMethode({Key? key}) : super(key: key);

  @override
  State<DriverPaymentMethode> createState() => _DriverPaymentMethodeState();
}

class _DriverPaymentMethodeState extends State<DriverPaymentMethode> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Methode"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Card(
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    "assets/images/icon/download.png",
                    height: 40,
                    width: 40,
                  ),
                ),
                title: Text("Jazz Cash"),
                onTap: (){
                  showModalBottomSheet(
                      context: context,
                      builder: (context){
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage("assets/images/icon/download.png"),
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              TextForm(
                                title: "Enter Your Name",
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              TextForm(
                                title: "Enter Your CNIC",
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              TextForm(
                                title: "Enter Your Number",
                              ),
                              SizedBox(
                                height: height * 0.04,
                              ),
                              CustomButton(
                                text: "Save",
                                decoration: BoxDecoration(
                                  color: AppColor.blackColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                height: height * 0.07,
                                width: width * 1,
                                textStyle: TextStyle(
                                  color: AppColor.whiteColor,
                                  fontWeight: FontWeight.bold
                                ),
                                onTap: (){

                                },
                              ),
                            ],
                          ),
                        );
                      }
                  );
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    "assets/images/icon/easypaisa.png",
                    height: 40,
                    width: 40,
                  ),
                ),
                title: Text("Easy Paisa"),
                onTap: (){
                  showModalBottomSheet(
                      context: context,
                      builder: (context){
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage("assets/images/icon/easypaisa.png"),
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              TextForm(
                                title: "Enter Your Name",
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              TextForm(
                                title: "Enter Your CNIC",
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              TextForm(
                                title: "Enter Your Number",
                              ),
                              SizedBox(
                                height: height * 0.04,
                              ),
                              CustomButton(
                                text: "Save",
                                decoration: BoxDecoration(
                                  color: AppColor.blackColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                height: height * 0.07,
                                width: width * 1,
                                textStyle: TextStyle(
                                    color: AppColor.whiteColor,
                                    fontWeight: FontWeight.bold
                                ),
                                onTap: (){

                                },
                              ),
                            ],
                          ),
                        );
                      }
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}