import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:uber_app/src/share/app_text_field.dart';
import 'package:uber_app/src/share/custom_button.dart';
import 'package:uber_app/src/style/app_color.dart';

import '../auth/login_screen.dart';

class DriverProfile extends StatefulWidget {
  const DriverProfile({Key? key}) : super(key: key);

  @override
  State<DriverProfile> createState() => _DriverProfileState();
}

class _DriverProfileState extends State<DriverProfile> {
  static final auth = FirebaseAuth.instance.currentUser!.uid;
  Stream documentSnapshot = FirebaseFirestore.instance.collection('Driver').doc(auth).snapshots();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: (){
              FirebaseAuth.instance.signOut().then((value){
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: LoginPage(),
                  withNavBar: false, // OPTIONAL VALUE. True by default.
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );

              });
            },
            child: Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: documentSnapshot,
        builder: (context,snapshot){
          if(snapshot.hasData){
            Map<String, dynamic> data = snapshot.data.data() as Map<String, dynamic>;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: (){
                          showModalBottomSheet(
                            context: context,
                            builder: (context){
                              return const Column(
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
                        child: CachedNetworkImage(
                          imageUrl: data["profileImage"] != null ?
                          "https://i.pinimg.com/474x/a8/0e/36/a80e3690318c08114011145fdcfa3ddb.jpg" : data["profileImage"],
                          height: 120,
                          width: 120,
                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                              CircularProgressIndicator(value: downloadProgress.progress),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.5),
                      child: Card(
                        shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        child: ListTile(
                          leading: Icon(Icons.person),
                          title: Text("Name"),
                          subtitle: Text(data["userName"]),
                          trailing: InkWell(
                            splashColor: Colors.transparent,
                            onTap: (){
                              showModalBottomSheet(
                                shape: const OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                                context: context,
                                builder: (context){
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          height: height * 0.02,
                                        ),
                                        TextForm(
                                          title: "Name",
                                        ),
                                        SizedBox(
                                          height: height * 0.02,
                                        ),
                                        CustomButton(
                                          text: "Update",
                                          textStyle: TextStyle(
                                            color: AppColor.whiteColor,
                                            fontSize: 17
                                          ),
                                          height: height * 0.07,
                                          width: width * 1,
                                          decoration: BoxDecoration(
                                            color: AppColor.blackColor,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          onTap: (){

                                          },
                                        ),
                                        SizedBox(
                                          height: height * 0.02,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: Icon(Icons.edit),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.5),
                      child: Card(
                        shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        child: ListTile(
                          leading: Icon(Icons.phone),
                          title: Text("Email"),
                          subtitle: Text(data["email"]),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.5),
                      child: Card(
                        shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        child: ListTile(
                          leading: Icon(Icons.alternate_email),
                          title: Text("Phone Number"),
                          subtitle: Text(data["phoneNumber"]),
                          trailing: InkWell(
                            splashColor: Colors.transparent,
                            onTap: (){
                              showModalBottomSheet(
                                shape: const OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                                context: context,
                                builder: (context){
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          height: height * 0.02,
                                        ),
                                        TextForm(
                                          title: "Phone Number",
                                        ),
                                        SizedBox(
                                          height: height * 0.02,
                                        ),
                                        CustomButton(
                                          text: "Update",
                                          textStyle: TextStyle(
                                              color: AppColor.whiteColor,
                                              fontSize: 17
                                          ),
                                          height: height * 0.07,
                                          width: width * 1,
                                          decoration: BoxDecoration(
                                            color: AppColor.blackColor,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          onTap: (){

                                          },
                                        ),
                                        SizedBox(
                                          height: height * 0.02,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: Icon(Icons.edit),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.5),
                      child: Card(
                        shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        child: ListTile(
                          leading: Icon(Icons.drive_eta_rounded),
                          title: Text("Type"),
                          subtitle: Text(data["type"]),
                          trailing: InkWell(
                            splashColor: Colors.transparent,
                            onTap: (){
                              showModalBottomSheet(
                                shape: const OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                                context: context,
                                builder: (context){
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          height: height * 0.02,
                                        ),
                                        TextForm(
                                          title: "Type",
                                        ),
                                        SizedBox(
                                          height: height * 0.02,
                                        ),
                                        CustomButton(
                                          text: "Update",
                                          textStyle: TextStyle(
                                              color: AppColor.whiteColor,
                                              fontSize: 17
                                          ),
                                          height: height * 0.07,
                                          width: width * 1,
                                          decoration: BoxDecoration(
                                            color: AppColor.blackColor,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          onTap: (){

                                          },
                                        ),
                                        SizedBox(
                                          height: height * 0.02,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: Icon(Icons.edit),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.5),
                      child: Card(
                        shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        child: ListTile(
                          leading: Icon(Icons.payment),
                          title: Text("Payment"),
                          subtitle: Text(data["payment"]),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.5),
                      child: Card(
                        shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        child: ListTile(
                          leading: Icon(Icons.drive_eta_rounded),
                          title: Text("Car Name"),
                          subtitle: Text(data["carName"]),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.5),
                      child: Card(
                        shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        child: ListTile(
                          leading: Icon(Icons.color_lens_outlined),
                          title: Text("Car Color"),
                          subtitle: Text(data["carColor"]),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.5),
                      child: Card(
                        shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        child: ListTile(
                          leading: Icon(Icons.numbers),
                          title: Text("Car Number"),
                          subtitle: Text(data["carNumber"]),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.5),
                      child: Card(
                        shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        child: ListTile(
                          leading: Icon(Icons.model_training),
                          title: Text("Car Model"),
                          subtitle: Text(data["carModel"]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }else{
            return SizedBox();
          }
        },
      ),
    );
  }
}
