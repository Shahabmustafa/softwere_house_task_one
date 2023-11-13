


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({Key? key,
    this.height,
    required this.text,
    this.width,
    this.onTap,
    this.decoration,
    this.textStyle,
  }) : super(key: key);
  String text;
  VoidCallback? onTap;
  double? height;
  double? width;
  Decoration? decoration;
  TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: decoration,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: textStyle,
            ),
          ],
        ),
      ),
    );
  }
}
