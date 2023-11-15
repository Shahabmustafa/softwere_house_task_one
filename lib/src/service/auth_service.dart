import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:uber_app/src/model/user_model.dart';
import 'package:uber_app/src/view/Driver/driver_buttom_navigator.dart';
import 'package:uber_app/src/view/Driver/driver_car_file.dart';
import 'package:uber_app/src/view/Passenger/passenger_buttom_navigator.dart';

class AuthService extends GetxController{
  static final firebaseAuth = FirebaseAuth.instance;
  static final firebase = FirebaseFirestore.instance;
  RxBool loading = false.obs;
  final userName = TextEditingController().obs;
  final phoneNumber = TextEditingController().obs;
  final email = TextEditingController().obs;
  final password = TextEditingController().obs;
  final logEmail = TextEditingController().obs;
  final logPassword = TextEditingController().obs;

  Future<void> SignIn(BuildContext context,String selectedItem)async{
    var user;
    if (selectedItem == "Driver") {
      user = "Driver";
    }else if(selectedItem == "Passenger"){
      user = "Passenger";
    }
    loading.value = true;
   try{
     await firebaseAuth.createUserWithEmailAndPassword(
       email: email.value.text,
       password: password.value.text,
     ).then((value){
       print(value);
       UserModel userModel = UserModel(
         userName: userName.value.text,
         email: email.value.text,
         phoneNumber: phoneNumber.value.text,
         payment: "0",
         profileImage: "https://images.pexels.com/photos/3454298/pexels-photo-3454298.jpeg?auto=compress&cs=tinysrgb&w=800",
         type: selectedItem,
         stats: true,
         dateTime: DateTime.now(),
         userId: value.user!.uid,
       );
       firebase.collection("users").doc(value.user!.uid).set(userModel.toJson());
       firebase.collection("${user}").doc(value.user!.uid).set(userModel.toJson()).then((value){
         Navigator.push(context, MaterialPageRoute(builder: (context) => DriverCarFile()));
       });
       loading.value = false;
     }).onError((error, stackTrace){
       loading.value = false;
       print(error);
     });
   }catch(e){
     loading.value = false;
     print(e);
   }
  }

  Future<void> Login(BuildContext context)async{
    loading.value = true;
   try{
     await firebaseAuth.signInWithEmailAndPassword(
       email: logEmail.value.text,
       password: logPassword.value.text,
     ).then((value){
       firebase.collection("users")
           .doc(value.user!.uid)
           .get().then((DocumentSnapshot documentSnapshot){
             if(documentSnapshot.exists){
               if(documentSnapshot.get("type") == "Driver"){
                 Navigator.push(context, MaterialPageRoute(builder: (context) => DriverButtomNavigator()));
               }else{
                 Navigator.push(context, MaterialPageRoute(builder: (context) => PassengerNavigator()));
               }
             }else{
               print('Document does not exist on the database');
             }
       });
     });
   }catch(e){
     loading.value = false;
   }
  }
}