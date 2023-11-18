import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_app/src/service/meesage_service.dart';
import 'package:uber_app/src/share/app_text_field.dart';
import 'package:uber_app/src/style/app_color.dart';

class DriverMessage extends StatefulWidget {
  DriverMessage({Key? key,required this.userName,required this.profileImage,required this.stats,required this.userId}) : super(key: key);
  String profileImage;
  String userName;
  String userId;
  bool stats;
  @override
  State<DriverMessage> createState() => _DriverMessageState();
}

class _DriverMessageState extends State<DriverMessage> {
  final messageControllers = TextEditingController();
  MessageService messageService = MessageService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  Widget build(BuildContext context) {
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
                return Center(child: Text("Hello"));
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
                    controller: messageControllers,
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
                      if(messageControllers.text.isNotEmpty){
                        messageService.sendMessagePassenger(
                          widget.userId,
                          messageControllers.text.trim(),
                        );
                        messageControllers.clear();
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
