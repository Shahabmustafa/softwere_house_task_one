import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../model/message_model.dart';
import '../../model/user_model.dart';
import 'firebase_storage_service.dart';

class FirebaseFirestoreService with ChangeNotifier{
  static final auth = FirebaseAuth.instance.currentUser;
  static final firestore = FirebaseFirestore.instance;

  static Future<void> addMessage({required String content,required String receiverId})async{
    final auth = FirebaseAuth.instance.currentUser;
    final MessageModel message = MessageModel(
        senderId: auth!.uid,
        receiverId: receiverId,
        content: content,
        sentTime: DateTime.now(),
        messageType: MessageType.text,
    );
    await _addMessageToChat(receiverId,message);
  }
  static Future<void> _addMessageToChat(String receiverId,MessageModel message)async{
    await firestore
        .collection("users")
        .doc(auth!.uid)
        .collection("chat")
        .doc(receiverId)
        .collection('messages')
        .add(message.toJson());

    await firestore
    .collection("users")
    .doc(receiverId)
    .collection("chat")
    .doc(auth!.uid)
    .collection("messages")
    .add(message.toJson());
  }

  static Future<void> addImageMessage({required String receiverId,required Uint8List file})async{
    final image = await FirebaseStorageService.uploadImage(
        file,
        "image/chat/${DateTime.now()}"
    );
    final message = MessageModel(
        senderId: auth!.uid,
        receiverId: receiverId,
        content: image,
        sentTime: DateTime.now(),
        messageType: MessageType.image,
    );
    await _addMessageToChat(receiverId, message);
  }

  static Future<void> updateUserData(Map<String,dynamic> data)async{
    await firestore
        .collection("users")
        .doc(auth!.uid)
        .update(data);
  }

  static Future<List<UserModel>> searchUser(String name)async{
    final snapshot = await FirebaseFirestore.instance
        .collection("users")
        .where("name",isGreaterThanOrEqualTo: name)
        .get();
    return snapshot.docs.map((doc) => UserModel.fromJson(doc.data())).toList();
  }
}