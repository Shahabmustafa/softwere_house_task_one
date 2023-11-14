import 'package:flutter/material.dart';
import 'package:uber_app/src/style/app_color.dart';

class TextForm extends StatelessWidget {
  TextForm({
    Key? key,
    this.prefixIcon,
    this.suffixIcon,
    required this.title,
    this.controller,
    this.validator,
    this.keyboardType,
    this.obscureText = false,
  }) : super(key: key);
  String title;
  TextEditingController? controller;
  IconData? suffixIcon;
  IconData? prefixIcon;
  String? Function(String?)? validator;
  TextInputType? keyboardType;
  bool obscureText;

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
          keyboardType: keyboardType,
          validator: validator,
          controller: controller,
          obscureText: obscureText,
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
