import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/state_manager.dart';
import 'package:uber_app/src/model/user_model.dart';

class AuthService extends GetxController{
  static final firebaseAuth = FirebaseAuth.instance;
  static final firebase = FirebaseFirestore.instance.collection("users");
  RxBool loading = false.obs;
  final userName = TextEditingController().obs;
  final phoneNumber = TextEditingController().obs;
  final email = TextEditingController().obs;
  final password = TextEditingController().obs;

  Future<void> SignIn(BuildContext context)async{
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
         payment: "",
         profileImage: "",
         type: "",
       );
       firebase.doc(value.user!.uid).set(userModel.toJson());
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
}