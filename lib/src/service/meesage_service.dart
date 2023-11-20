import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uber_app/src/model/message_model.dart';

class MessageService{

  static final firestore = FirebaseFirestore.instance;
  static final auth = FirebaseAuth.instance;
  static User get user => auth.currentUser!;

  static String getConversationID(String id) => user.uid.hashCode <= id.hashCode
      ? '${user.uid}_$id'
      : '${id}_${user.uid}';
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(String userId){
    return firestore.collection("chats/${getConversationID("${userId}")}/messages/")
    .orderBy('senderId', descending: true)
    .snapshots();
  }

  static Future<void> sendMessage(String userId,String msg)async{
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final Message message = Message(
        senderId: user.uid,
        receiverId: "${userId}",
        sentTime: time,
        content: msg,
    );
    final ref = firestore.collection("chats/${getConversationID("${userId}")}/messages/");
    await ref.doc(time).set(message.toJson());
  }
}