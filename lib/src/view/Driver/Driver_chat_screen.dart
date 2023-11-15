import 'package:flutter/material.dart';

class DriverChatPage extends StatefulWidget {
  const DriverChatPage({Key? key}) : super(key: key);

  @override
  State<DriverChatPage> createState() => _DriverChatPageState();
}

class _DriverChatPageState extends State<DriverChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
        centerTitle: true,
      ),
      // body: StreamBuilder(
      //   // stream: ,
      //   builder: (context,snapshot){
      //     if(snapshot.hasData){
      //       return ListView.builder(
      //           itemCount: 10,
      //           itemBuilder: (context,index){
      //             return Padding(
      //               padding: const EdgeInsets.symmetric(horizontal: 10),
      //               child: Card(
      //                 shape: OutlineInputBorder(
      //                     borderRadius: BorderRadius.circular(20),
      //                     borderSide: BorderSide.none
      //                 ),
      //                 child: ListTile(
      //                   leading: CircleAvatar(),
      //                   title: Text("Shahab Mustafa"),
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
