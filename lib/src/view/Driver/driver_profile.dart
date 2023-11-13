import 'package:flutter/material.dart';

class DriverProfile extends StatefulWidget {
  const DriverProfile({Key? key}) : super(key: key);

  @override
  State<DriverProfile> createState() => _DriverProfileState();
}

class _DriverProfileState extends State<DriverProfile> {
  List<String> title = [
    "Id",
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
