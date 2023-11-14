import 'package:flutter/material.dart';

class PassengerProfile extends StatefulWidget {
  const PassengerProfile({Key? key}) : super(key: key);

  @override
  State<PassengerProfile> createState() => _PassengerProfileState();
}

class _PassengerProfileState extends State<PassengerProfile> {
  List<String> title = [
    "Client Id",
    "Name",
    "email",
    "phone number",
    "payment",

  ];
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: (){
              showModalBottomSheet(
                context: context,
                builder: (context){
                  return Column(
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
            child: Center(
              child: CircleAvatar(
                radius: 50,
              ),
            ),
          ),
          SizedBox(
            height: height * 0.05,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context,index){
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.5),
                  child: Card(
                    child: ListTile(
                      leading: Icon(Icons.person),
                      title: Text(title[index]),
                      subtitle: Text("EXp"),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){

        },
        child: Icon(Icons.edit),
      ),
    );
  }
}
