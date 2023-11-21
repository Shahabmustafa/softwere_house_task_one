import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uber_app/src/model/message_model.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble({Key? key,required this.message,required this.isMe,required this.isImage}) : super(key: key);
  MessageModel message;
  bool isMe;
  bool isImage;
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
          color: isMe ? Colors.grey : Colors.blueAccent,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: [
            isImage ?
            Container(
              height: 200,
              width: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: NetworkImage(message.content),
                  fit: BoxFit.cover,
                ),
              ),
            ) :
            Text(
              message.content,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
