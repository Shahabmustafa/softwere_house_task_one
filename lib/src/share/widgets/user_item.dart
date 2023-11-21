import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../../model/user_model.dart';
import '../../view/chat/chat_screen.dart';

class UserItems extends StatefulWidget {
  UserItems({Key? key,required this.user}) : super(key: key);
  UserModel user;
  @override
  State<UserItems> createState() => _UserItemsState();
}

class _UserItemsState extends State<UserItems> {

  @override
  Widget build(BuildContext context) {
    DateTime? exm = widget.user.dateTime;
    String dayofWeek = DateFormat("EEEE").format(exm!);
    return GestureDetector(
      onTap: (){
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: ChatPage(userId: widget.user.userId.toString(),),
          withNavBar: false, // OPTIONAL VALUE. True by default.
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        );
      },
      child: ListTile(
        leading: Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.user.profileImage.toString()),
            ),
            Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                color: widget.user.stats.isNull ? Colors.green : Colors.grey,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ],
        ),
        title: Text(widget.user.userName.toString(),style: TextStyle(color: Colors.black),),
        subtitle: Text("Last Active : ${dayofWeek}"),
      ),
    );
  }
}
