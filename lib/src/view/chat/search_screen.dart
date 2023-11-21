import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../service/provider/firebase_provider.dart';
import '../../share/widgets/custem_text_field.dart';
import '../../share/widgets/user_item.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users Search"),
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextField(
                hintText: "Search",
                controller: searchController,
              onChanged: (val) =>
              Provider.of<FirebaseProvider>(context,listen: false).searchUser(val),
            ),
          ),
          Consumer<FirebaseProvider>(
            builder: (context,value,child){
              return Expanded(
                child: searchController.text.isEmpty ?
                Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search,size: 100,),
                      SizedBox(
                        height: 100,
                      ),
                      Text("Search of User",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 30),)
                    ],
                   ) :
                ListView.builder(
                  itemCount: value.search.length,
                  itemBuilder: (context,index){
                    return value.search[index].userId == FirebaseAuth.instance.currentUser!.uid ?
                    UserItems(user: value.search[index]) :
                    SizedBox();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
