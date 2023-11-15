import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:uber_app/src/service/driver_service.dart';
import 'package:uber_app/src/share/app_text_field.dart';
import 'package:uber_app/src/share/custom_button.dart';
import 'package:uber_app/src/style/app_color.dart';
import 'package:uber_app/src/view/Driver/driver_buttom_navigator.dart';

class DriverCarFile extends StatefulWidget {
  const DriverCarFile({Key? key}) : super(key: key);

  @override
  State<DriverCarFile> createState() => _DriverCarFileState();
}

class _DriverCarFileState extends State<DriverCarFile> {

  final carDetail = Get.put(DriverService());

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
            Text(
              "Car Detail",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            TextForm(
              title: "Car Name",
              controller: carDetail.carName.value,
              prefixIcon: CupertinoIcons.car,
            ),
            SizedBox(
              height: height * 0.01,
            ),
            TextForm(
              title: "Car Color",
              controller: carDetail.carColor.value,
              prefixIcon: Icons.color_lens,
            ),
            SizedBox(
              height: height * 0.01,
            ),
            TextForm(
              title: "Car Model",
              controller: carDetail.carModel.value,
              prefixIcon: Icons.model_training,
            ),
            SizedBox(
              height: height * 0.01,
            ),
            TextForm(
              title: "Car Number",
              controller: carDetail.carNumber.value,
              prefixIcon: CupertinoIcons.number,
            ),
            SizedBox(
              height: height * 0.04,
            ),
            Obx((){
              return CustomButton(
                text: "Register",
                loading: carDetail.loading.value,
                height: height * 0.07,
                width: width * 1,
                decoration: BoxDecoration(
                  color: AppColor.blackColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                textStyle: TextStyle(
                  color: AppColor.whiteColor,
                  fontWeight: FontWeight.bold,
                ),
                onTap: (){
                  carDetail.addCarDetail(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DriverButtomNavigator()));
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
