import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:uber_app/src/service/passenger_service.dart';

class DriverChatPage extends StatefulWidget {
  const DriverChatPage({Key? key}) : super(key: key);

  @override
  State<DriverChatPage> createState() => _DriverChatPageState();
}

class _DriverChatPageState extends State<DriverChatPage> {

  static final auth = FirebaseAuth.instance.currentUser!.uid;
  final firebase = FirebaseFirestore
      .instance
      .collection("Driver")
      .doc(auth)
      .collection("chat")
      .doc()
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
        centerTitle: true,
      ),
      body: Center(
        child: TextButton(
          onPressed: (){
          },
          child: Text("Hello"),
        ),
      )
      // StreamBuilder(
      //   stream: firebase,
      //   builder: (context,snapshot){
      //     if(snapshot.hasData){
      //       return ListView.builder(
      //           itemCount: snapshot.data!.docs.length,
      //           itemBuilder: (context,index){
      //             var data = snapshot.data!.docs[index];
      //             return Padding(
      //               padding: const EdgeInsets.symmetric(horizontal: 10),
      //               child: Card(
      //                 shape: OutlineInputBorder(
      //                     borderRadius: BorderRadius.circular(20),
      //                     borderSide: BorderSide.none
      //                 ),
      //                 child: ListTile(
      //                   leading: CircleAvatar(),
      //                   title: Text(data["userName"]),
      //                   splashColor: Colors.transparent,
      //                   onTap: (){
      //
      //                   },
      //                 ),
      //               ),
      //             );
      //           }
      //       );
      //     }else{
      //       return Center(child: CircularProgressIndicator());
      //     }
      //   },
      // ),
    );
  }
}
