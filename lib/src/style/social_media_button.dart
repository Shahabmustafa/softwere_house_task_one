import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SocialMediaButton extends StatelessWidget {
  SocialMediaButton({Key? key,
    required this.height,
    required this.width,
    required this.title,
    required this.imageUrl,
  }) : super(key: key);
  double height;
  double width;
  String imageUrl;
  String title;

  @override
  Widget build(BuildContext context) {
    final heights = MediaQuery.sizeOf(context).height;
    final widths = MediaQuery.sizeOf(context).width;
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/icon/$imageUrl",
            height: 25,
            width: 25,
          ),
          SizedBox(
            width: widths * 0.05,
          ),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }
}
