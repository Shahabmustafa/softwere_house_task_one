import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_app/src/share/message_bubble.dart';

import '../model/message_model.dart';
import '../service/meesage_service.dart';

class ChatMessage extends StatelessWidget {
  ChatMessage({Key? key,required this.receiverId}) : super(key: key);
  String receiverId;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

      ],
    );
  }
}
