import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_app/src/share/message_bubble.dart';

import '../model/message_model.dart';
import '../service/meesage_service.dart';

class ChatMessage extends StatelessWidget {
  ChatMessage({Key? key,required this.receiverId}) : super(key: key);
  String receiverId;
  final message = [
    Message(
      senderId: "vZDGYdPrVQNdyPz2Tl2vNL6z2jm2",
      receiverId: "1",
      content: "Hello",
      sentTime: DateTime.now(),
    ),
    Message(
      senderId: "1",
      receiverId: "vZDGYdPrVQNdyPz2Tl2vNL6z2jm2",
      content: "Hello",
      sentTime: DateTime.now(),
    ),
    Message(
      senderId: "vZDGYdPrVQNdyPz2Tl2vNL6z2jm2",
      receiverId: "1",
      content: "How are you",
      sentTime: DateTime.now(),
    ),
    Message(
      senderId: "1",
      receiverId: "vZDGYdPrVQNdyPz2Tl2vNL6z2jm2",
      content: "I am Good and You",
      sentTime: DateTime.now(),
    ),
    Message(
      senderId: "vZDGYdPrVQNdyPz2Tl2vNL6z2jm2",
      receiverId: "1",
      content: "I am well",
      sentTime: DateTime.now(),
    ),
    Message(
      senderId: "1",
      receiverId: "vZDGYdPrVQNdyPz2Tl2vNL6z2jm2",
      content: "What are you doing",
      sentTime: DateTime.now(),
    ),
    Message(
      senderId: "vZDGYdPrVQNdyPz2Tl2vNL6z2jm2",
      receiverId: "1",
      content: "I am Working",
      sentTime: DateTime.now(),
    ),
    Message(
      senderId: "1",
      receiverId: "vZDGYdPrVQNdyPz2Tl2vNL6z2jm2",
      content: "https://i.pinimg.com/474x/ae/2d/65/ae2d65d73a98f127fdc0b320b2482c8b.jpg",
      sentTime: DateTime.now(),
    ),
    Message(
      senderId: "vZDGYdPrVQNdyPz2Tl2vNL6z2jm2",
      receiverId: "1",
      content: "https://i.pinimg.com/474x/43/c3/8a/43c38af968d3b8be468d64837b32b3fe.jpg",
      sentTime: DateTime.now(),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<MessageService>(
        builder: (context,value,child){
          return value.messages.isEmpty ? Expanded(
              child: Center(child: Text("say Hello"))
          ) : ListView.builder(
              itemCount: value.messages.length,
              itemBuilder: (context,index){
                final isMe = receiverId != value.messages[index].senderId;
                return MessagesBubble(
                  isMe: isMe,
                  message: value.messages[index],
                );
              }
          );
        }
    );
    //   Consumer<MessageService>(
    //     builder: (context,value,child){
    //       return value.messages.isEmpty ?
    //       Expanded(child: Center(child: Text("say Hello!"))) :
    //
    //     }
    // );
  }
}
