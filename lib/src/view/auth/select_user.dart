import 'package:flutter/material.dart';
import 'package:uber_app/src/style/app_color.dart';
import 'package:uber_app/src/view/Driver/driver_car_file.dart';

class SelectUser extends StatefulWidget {
  const SelectUser({Key? key}) : super(key: key);

  @override
  State<SelectUser> createState() => _SelectUserState();
}

class _SelectUserState extends State<SelectUser> {
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
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => DriverCarFile()));
              },
              child: Container(
                width: width * 1,
                height: height * 0.2,
                decoration: BoxDecoration(
                  color: AppColor.blackColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    "Driver",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                        color: AppColor.whiteColor
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.04,
            ),
            InkWell(
              onTap: (){

              },
              child: Container(
                width: width * 1,
                height: height * 0.2,
                decoration: BoxDecoration(
                  color: AppColor.blackColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    "Passenger",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: AppColor.whiteColor
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
