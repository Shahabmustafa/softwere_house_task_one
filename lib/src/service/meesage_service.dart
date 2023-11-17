

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:uber_app/src/model/message_model.dart';

import '../model/user_model.dart';

class MessageService with ChangeNotifier{

  static final firestore = FirebaseFirestore.instance;
  static final auth = FirebaseAuth.instance.currentUser;
  List<UserModel> users = [];
  UserModel? user;

  sendMessage(BuildContext context,
      String reciverId,
      String messages,
      String profileImage,
      String uid,
      String userName,
      )async{
    final Message message = Message(
      senderId: auth!.uid,
      receiverId: reciverId,
      content: messages,
      sentTime: DateTime.now(),
    );
    firestore.collection("Driver")
        .doc(reciverId)
        .collection("chat")
        .doc(auth!.uid)
        .collection("message")
        .add(message.toJson());

    firestore.collection("Driver")
        .doc(reciverId)
        .collection("chat")
        .doc(auth!.uid)
        .set({
      "profileImage" : profileImage,
      "uid" : uid,
      "userName" : userName,
    });
  }

  sendMessageDriver(String reciverId,String messages){
    final Message message = Message(
      senderId: auth!.uid,
      receiverId: reciverId,
      content: messages,
      sentTime: DateTime.now(),
    );
    firestore.collection("Passenger")
        .doc(reciverId)
        .collection("chat")
        .doc(auth!.uid)
        .collection("message")
        .add(message.toJson());
  }
}