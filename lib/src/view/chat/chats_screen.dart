import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_app/src/view/chat/search_screen.dart';

import '../../service/auth_service.dart';
import '../../service/firebase_service/firebase_firestore_services.dart';
import '../../service/firebase_service/notification_service.dart';
import '../../service/provider/firebase_provider.dart';
import '../../share/widgets/user_item.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({Key? key}) : super(key: key);

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> with WidgetsBindingObserver {

  final notificationServer = NotificationService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    Provider.of<FirebaseProvider>(context,listen: false).getAllUser();
    notificationServer.firebaseNotification(context);
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state){
    super.didChangeAppLifecycleState(state);
    switch(state){
      case AppLifecycleState.resumed:
        FirebaseFirestoreService.updateUserData({
          "lastActive" : DateTime.now(),
          "isOnline" : true,
        });
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        FirebaseFirestoreService.updateUserData({"isOnline" : false,});
        break;
      case AppLifecycleState.hidden:
        // TODO: Handle this case.
    }
  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage()));
            },
            child: Icon(Icons.search),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Consumer<FirebaseProvider>(
          builder: (context, value, child) {
            return ListView.separated(
              padding:
              const EdgeInsets.symmetric(horizontal: 16),
              itemCount: value.users.length,
              separatorBuilder: (context, index) =>
              const SizedBox(height: 10),
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return value.users[index].userId !=
                    FirebaseAuth.instance.currentUser?.uid
                    ? UserItems(user: value.users[index])
                    : const SizedBox();
              }
            );
          }),
    );
  }
}
