import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/message_model.dart';
import '../../service/provider/firebase_provider.dart';
import 'message_bubble_widget.dart';

class ChatMessages extends StatelessWidget {
  ChatMessages({Key? key,required this.receiverId}) : super(key: key);
  String receiverId;
  @override
  Widget build(BuildContext context) {
    return Consumer<FirebaseProvider>(
        builder: (context,value,child){
          return value.messages.isEmpty ? Expanded(
              child: Center(child: Text("say Hello"))
          ) : ListView.builder(
              controller: Provider.of<FirebaseProvider>(context,listen: false).scrollController,
              itemCount: value.messages.length,
              itemBuilder: (context,index){
                final isTextMessage = value.messages[index].messageType == MessageType.text;
                final isMe = receiverId != value.messages[index].senderId;
                return isTextMessage ?
                MessageBubble(
                  isImage: false,
                  isMe: isMe,
                  message: value.messages[index],
                ) :
                MessageBubble(
                  isImage: true,
                  isMe: isMe,
                  message: value.messages[index],
                );
              }
          );
        }
    );
  }
}
