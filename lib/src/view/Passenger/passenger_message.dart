import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_app/src/service/meesage_service.dart';
import 'package:uber_app/src/service/passenger_service.dart';
import 'package:uber_app/src/share/app_text_field.dart';
import 'package:uber_app/src/style/app_color.dart';

class PassengerMessage extends StatefulWidget {
  PassengerMessage({Key? key,required this.userName,required this.profileImage,required this.stats,required this.userId}) : super(key: key);
  String profileImage;
  String userName;
  String userId;
  bool stats;
  @override
  State<PassengerMessage> createState() => _PassengerMessageState();
}

class _PassengerMessageState extends State<PassengerMessage> {
  final messageController = TextEditingController();
  MessageService messsageService = MessageService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  Widget build(BuildContext context) {
    final currentUserData = Provider.of<PassengerService>(context);
    return Scaffold(
      appBar: AppBar(
        title:  Row(
          children: [
            InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(
                  Icons.arrow_back,
                  color: AppColor.whiteColor,
                ),
            ),
            SizedBox(
              width: 20,
            ),
            CircleAvatar(
              backgroundImage: NetworkImage(widget.profileImage.toString()),
            ),
            SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.userName,
                  style: TextStyle(
                      color: AppColor.whiteColor,
                      fontSize: 17
                  ),
                ),
                Text(
                  widget.stats ? "Online" :  "Offline",
                  style: TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context,index){
                return InkWell(
                    onTap:(){
                      print("error : ${currentUserData.fetchUserData()}");
                    },
                    child: Center(child: Text("Hello")));
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextForm(
                    title: "Aa...",
                    controller: messageController,
                    suffixIcon: Icons.camera_alt,
                    prefixIcon: CupertinoIcons.link,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  child: IconButton(
                    onPressed: (){
                      if(messageController.text.isNotEmpty){
                        print("error : ${currentUserData.userData[0].userName}");
                        messsageService.sendMessage(
                            context,
                            widget.userId,
                            messageController.text,
                            currentUserData.userData[0].userName.toString(),
                            currentUserData.userData[0].stats.toString(),
                            currentUserData.userData[0].profileImage.toString()
                        );
                        messageController.clear();
                      }
                    },
                    icon: Icon(Icons.near_me),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
