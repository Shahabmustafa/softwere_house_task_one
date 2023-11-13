import 'package:flutter/material.dart';
import 'package:uber_app/src/style/app_color.dart';

class TextForm extends StatelessWidget {
  TextForm({Key? key,this.prefixIcon,this.suffixIcon,required this.title}) : super(key: key);
  String title;
  IconData? suffixIcon;
  IconData? prefixIcon;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      height: height * 0.07,
      width: width * 1,
      decoration: BoxDecoration(
        color: AppColor.greyColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: TextFormField(
          decoration: InputDecoration(
            hintText: title,
            suffixIcon: Icon(suffixIcon),
            prefixIcon: Icon(prefixIcon),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
