import 'package:flutter/material.dart';
import 'package:uber_app/src/style/app_color.dart';

class PassengerHistory extends StatefulWidget {
  const PassengerHistory({Key? key}) : super(key: key);

  @override
  State<PassengerHistory> createState() => _PassengerHistoryState();
}

class _PassengerHistoryState extends State<PassengerHistory> {

  static TextStyle textstyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold
  );

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Traveling History"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 4,
        itemBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
            child: Container(
              height: height * 0.2,
              width: width * 1,
              decoration: BoxDecoration(
                color: AppColor.greyColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Rs 300",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Peshawar",style: textstyle,),
                      Text("to",style: textstyle),
                      Text("Islamabad",style: textstyle),

                    ],
                  ),
                  Text("12-04-2023",style: textstyle,),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
