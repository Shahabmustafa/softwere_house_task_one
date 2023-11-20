import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uber_app/src/view/Passenger/passenger_map.dart';

class ShowDriverList extends StatefulWidget {
  const ShowDriverList({Key? key}) : super(key: key);

  @override
  State<ShowDriverList> createState() => _ShowDriverListState();
}

class _ShowDriverListState extends State<ShowDriverList> {
  final firebase = FirebaseFirestore.instance.collection("Driver").snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Driver List"),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: firebase,
        builder: (context,snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context,index){
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(snapshot.data!.docs[index]["profileImage"]),
                    ),
                    title: Text(snapshot.data!.docs[index]["userName"].toString()),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PassengerMap(
                        latitude: snapshot.data!.docs[index]["latitude"],
                        longitude: snapshot.data!.docs[index]["longitude"],
                        profileImage: snapshot.data!.docs[index]["profileImage"],
                      )));
                    },
                  ),
                );
              },
            );
          }else{
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
