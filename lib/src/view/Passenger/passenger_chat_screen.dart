import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PassengerChatPage extends StatefulWidget {
  const PassengerChatPage({Key? key}) : super(key: key);

  @override
  State<PassengerChatPage> createState() => _PassengerChatPageState();
}

class _PassengerChatPageState extends State<PassengerChatPage> {
  final firestore = FirebaseFirestore.instance.collection("Driver").snapshots();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: firestore,
        builder: (context,snapshot){
          if(snapshot.hasData){
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context,index){
                  var data = snapshot.data!.docs[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Card(
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none
                      ),
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: CachedNetworkImage(
                            imageUrl: data["profileImage"] != null ?
                            "https://i.pinimg.com/474x/a8/0e/36/a80e3690318c08114011145fdcfa3ddb.jpg" : data["profileImage"],
                            height: 40,
                            width: 40,
                            progressIndicatorBuilder: (context, url, downloadProgress) =>
                                CircularProgressIndicator(value: downloadProgress.progress),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                        ),
                        title: Text(data["userName"]),
                        splashColor: Colors.transparent,
                        onTap: (){
                          print("click");
                        },
                      ),
                    ),
                  );
                }
            );
          }else{
            return Center(child: CircularProgressIndicator());
          }
        },
      )
    );
  }
}
