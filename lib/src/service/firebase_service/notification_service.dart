import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../view/chat/chat_screen.dart';

class NotificationService{
  static const key = "AAAAMi777EE:APA91bGsJgqkF8kkkqR2UvPUObADIyGNgVqLPDNHvoYwp9fRiwELfzkPzVeS2xlI3AS05P-2Tbe8SdVSPiq4EjpHMONLgN0rVe1cB5FKq57T9YGTGDrdU2qAUBk5Lh3pC2E9MkDpXHh5";
  final flutterLocalNotificationPlugin = FlutterLocalNotificationsPlugin();

  void _initLocalNotification(){
   const androidSettings = AndroidInitializationSettings(
      "@mipmap/ic_launcher",
    );
   const iOSSettings = DarwinInitializationSettings(
     requestAlertPermission: true,
     requestBadgePermission: true,
     requestCriticalPermission: true,
     requestProvisionalPermission: true,
     requestSoundPermission: true,
   );
   const initializationSettings = InitializationSettings(
     android: androidSettings,
     iOS: iOSSettings,
   );
   flutterLocalNotificationPlugin.initialize(
     initializationSettings,
     onDidReceiveNotificationResponse: (response){
       print(response.payload.toString());
     }
   );
  }

  Future<void> _showLocalNotification(RemoteMessage message)async{
    final StyleInformation = BigTextStyleInformation(
      message.notification!.body.toString(),
      htmlFormatBigText: true,
      contentTitle: message.notification!.title,
      htmlFormatTitle: true,
    );
    final androidDetails = AndroidNotificationDetails(
      "com.example.uber_app",
      "mychannelid",
      importance: Importance.max,
      styleInformation: StyleInformation,
      priority: Priority.max,
    );

    final iOSDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
    );

    final notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iOSDetails,
    );
    await flutterLocalNotificationPlugin.show(
        0,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
      payload: message.data['body'],
    );
  }

  Future<void> requestPermission()async{
    final messaging = FirebaseMessaging.instance;
    final settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if(settings.authorizationStatus == AuthorizationStatus.authorized){
      print("User granted permission");
    }else if(settings.authorizationStatus == AuthorizationStatus.provisional){
      print("User granted provisional permission");
    }else{
      print("User declined or has not accepted permission");
    }
  }

  Future<void> getToken()async{
    final token = await FirebaseMessaging.instance.getToken();
    _saveToken(token!);
  }

  Future<void> _saveToken(String token)async{
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid).set({'token' : token,},SetOptions(merge: true));
  }
  String receiverToken = '';
  Future<void> getRecevierToken(String? receiverId)async{
    final getToken = await FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .get();
    receiverToken = await getToken.data()!['token'];
  }

  void firebaseNotification(context){
    _initLocalNotification();
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message)async{
      await Navigator.of(context).push(MaterialPageRoute(builder: (_) => ChatPage(userId: message.data["senderId"])));
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message)async{
      await _showLocalNotification(message);
    });
  }

  Future<void> sendNotification({required String body,required String senderId})async{
    try{
      await http.post(
        Uri.parse("https://fcm.googleapis.com/fcm/send"),
        headers: <String,String>{
          "Content-Type" : "application/json",
          "Authorization" : "key=$key",
        },
        body: jsonEncode(<String,dynamic>{
          "to" : receiverToken,
          "priority" : "high",
          "notification" : <String,dynamic>{
            "body" : body,
            "title" : "New Message !",
          },
          "data" : <String,String>{
            "click_action" : "FLUTTER_NOTIFICATION_CLICK",
            "status" : "done",
            "senderId" : senderId,
          }
        },
        ),
      );
    }catch(e){
      print(e.toString());
    }
  }
}