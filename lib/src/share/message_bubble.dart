import 'package:flutter/material.dart';
import 'package:uber_app/src/model/message_model.dart';
import 'package:uber_app/src/style/app_color.dart';

class MessagesBubble extends StatelessWidget {
  MessagesBubble({Key? key,this.isMe = false,this.message}) : super(key: key);
  bool isMe;
  Message? message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.topRight : Alignment.topLeft,
      child: Container(
        margin: EdgeInsets.only(
          top: 10,
          right: 10,
          left: 10,
        ),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isMe ? Colors.blue : Colors.grey,
          borderRadius: isMe ?
          BorderRadius.only(
            topLeft: Radius.circular(30),
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ) :
          BorderRadius.only(
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: [
            Text(message!.content.toString(),style: TextStyle(color: AppColor.whiteColor),)
          ],
        ),
      ),
    );
  }
}
