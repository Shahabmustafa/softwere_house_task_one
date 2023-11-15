import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uber_app/src/view/Driver/driver_buttom_navigator.dart';

class DriverService extends GetxController{
  final firebase = FirebaseFirestore.instance.collection('Driver');
  static final auth = FirebaseAuth.instance;
  final user = auth.currentUser;
  RxBool loading = false.obs;
  final carName = TextEditingController().obs;
  final carColor = TextEditingController().obs;
  final carModel = TextEditingController().obs;
  final carNumber = TextEditingController().obs;

  addCarDetail(BuildContext context){
    loading.value = true;
    try{
      firebase.doc(user!.uid)
          .update({
        "carName" : carName.value.text,
        "carColor" : carColor.value.text,
        "carModel" : carModel.value.text,
        "carNumber" : carNumber.value.text,
      }).then((value){
        loading.value = false;
        Navigator.push(context, MaterialPageRoute(builder: (context) => DriverButtomNavigator()));
      });
    }catch(e){
      loading.value = false;
    }
  }
}