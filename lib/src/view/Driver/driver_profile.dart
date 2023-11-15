import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DriverProfile extends StatefulWidget {
  const DriverProfile({Key? key}) : super(key: key);

  @override
  State<DriverProfile> createState() => _DriverProfileState();
}

class _DriverProfileState extends State<DriverProfile> {
  static final auth = FirebaseAuth.instance.currentUser!.uid;
  Stream documentSnapshot = FirebaseFirestore.instance.collection('Driver').doc(auth).snapshots();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: (){
              FirebaseAuth.instance.signOut();
            },
            child: Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: documentSnapshot,
        builder: (context,snapshot){
          if(snapshot.hasData){
            Map<String, dynamic> data = snapshot.data.data() as Map<String, dynamic>;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: (){
                        showModalBottomSheet(
                          context: context,
                          builder: (context){
                            return const Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  leading: Icon(Icons.camera_alt),
                                  title: Text("Camera"),
                                ),
                                ListTile(
                                  leading: Icon(Icons.photo),
                                  title: Text("Gallery"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: CachedNetworkImage(
                        imageUrl: data["profileImage"] != null ?
                        "https://i.pinimg.com/474x/a8/0e/36/a80e3690318c08114011145fdcfa3ddb.jpg" : data["profileImage"],
                        height: 120,
                        width: 120,
                        progressIndicatorBuilder: (context, url, downloadProgress) =>
                            CircularProgressIndicator(value: downloadProgress.progress),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.5),
                    child: Card(
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      child: ListTile(
                        leading: Icon(Icons.person),
                        title: Text("Name"),
                        subtitle: Text(data["userName"]),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.5),
                    child: Card(
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      child: ListTile(
                        leading: Icon(Icons.phone),
                        title: Text("Email"),
                        subtitle: Text(data["email"]),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.5),
                    child: Card(
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      child: ListTile(
                        leading: Icon(Icons.alternate_email),
                        title: Text("Phone Number"),
                        subtitle: Text(data["phoneNumber"]),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.5),
                    child: Card(
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      child: ListTile(
                        leading: Icon(Icons.drive_eta_rounded),
                        title: Text("Type"),
                        subtitle: Text(data["type"]),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.5),
                    child: Card(
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      child: ListTile(
                        leading: Icon(Icons.payment),
                        title: Text("Payment"),
                        subtitle: Text(data["payment"]),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }else{
            return SizedBox();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){

        },
        child: Icon(Icons.edit),
      ),
    );
  }
}
