import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:uber_app/src/style/app_color.dart';
import 'package:uber_app/src/view/Driver/driver_message_screen.dart';

class DriverChatPage extends StatefulWidget {
  const DriverChatPage({Key? key}) : super(key: key);

  @override
  State<DriverChatPage> createState() => _DriverChatPageState();
}

class _DriverChatPageState extends State<DriverChatPage> {
  final auth = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Passenger").snapshots(),
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
                        leading: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage(data["profileImage"]),
                            ),
                            Container(
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(
                                color: data["stats"] == null ? Colors.green : Colors.grey,
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                          ],
                        ),
                        title: Text(data["userName"]),
                        // subtitle: Text(data["e"]),
                        splashColor: Colors.transparent,
                        onTap: (){
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: DriverMessage(
                              userId: data["userId"],
                              profileImage: data["profileImage"],
                              stats: data["stats"],
                              userName: data["userName"],
                            ),
                            withNavBar: false, // OPTIONAL VALUE. True by default.
                            pageTransitionAnimation: PageTransitionAnimation.cupertino,
                          );
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
      ),
    );
  }
}
