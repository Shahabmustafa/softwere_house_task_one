


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uber_app/src/style/app_color.dart';

class CustomButton extends StatelessWidget {
  CustomButton({Key? key,
    this.height,
    required this.text,
    this.width,
    this.onTap,
    this.decoration,
    this.textStyle,
    this.loading = false,
  }) : super(key: key);
  String text;
  VoidCallback? onTap;
  double? height;
  double? width;
  Decoration? decoration;
  TextStyle? textStyle;
  bool loading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: loading ? null : onTap,
      child: Container(
        height: height,
        width: width,
        decoration: decoration,
        child: loading ? Center(child: CircularProgressIndicator(color: AppColor.whiteColor,)) : Center(
          child: Text(
            text,
            style: textStyle,
          ),
        ),
      ),
    );
  }
}
