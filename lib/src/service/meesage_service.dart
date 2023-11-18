

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:uber_app/src/model/message_model.dart';

import '../model/user_model.dart';

class MessageService with ChangeNotifier{

  static final firestore = FirebaseFirestore.instance;
  static final auth = FirebaseAuth.instance.currentUser;
  List<UserModel> users = [];
  List<Message> messages = [];
  UserModel? user;

  sendMessageDriver(
      String reciverId,
      String messages,
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
  }

  sendMessagePassenger(String reciverId,String messages){
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


  List<Message> getMessage(String receiverId){
    firestore
        .collection("Driver")
        .doc(auth!.uid)
        .collection("chat")
        .doc(receiverId)
        .collection("message")
        .orderBy("sentTime",descending: false)
        .snapshots(includeMetadataChanges: true)
        .listen((message){
      this.messages = message
          .docs.map((doc) => Message.fromJson(doc.data()),
      ).toList();
      notifyListeners();
    });
    return messages;
  }
}