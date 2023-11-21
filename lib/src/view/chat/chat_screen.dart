import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../service/provider/firebase_provider.dart';
import '../../share/widgets/chat_message.dart';
import '../../share/widgets/chat_text_field_widget.dart';


class ChatPage extends StatefulWidget {
  ChatPage({Key? key,required this.userId}) : super(key: key);

  final String userId;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<FirebaseProvider>(context,listen: false)
    ..getUserById(widget.userId)
    ..getMessage(widget.userId);
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: ChatMessages(
              receiverId: widget.userId.toString(),
            ),
          ),
          ChatTextField(
            receiverId: widget.userId.toString(),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
  AppBar _buildAppBar() =>
      AppBar(
        elevation: 0,
        // backgroundColor: Colors.transparent,
        // foregroundColor: Colors.transparent,
        title: Consumer<FirebaseProvider>(
            builder: (context,value,child){
              return value.user != null ?
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(value.user!.profileImage.toString()),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        value.user!.userName.toString(),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        value.user!.stats == true ?
                        "Online" :
                        "Offline",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                          // color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ) :
              SizedBox();
            }
        ),
      );
}
