import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../model/passenger_model.dart';
import '../model/user_model.dart';

class PassengerService with ChangeNotifier{

  List<PassengerModel> userData = [];
  addUserData(PassengerModel data) {
    userData.add(data);
    print(userData[0]);
    notifyListeners();
  }


  Future<PassengerModel?> fetchUserData()async{
    final auth = FirebaseAuth.instance.currentUser;
    final data = await FirebaseFirestore
        .instance
        .collection("Passenger")
        .doc(auth!.uid)
        .get();
    if(data.data() != null){
      PassengerModel passengerModel = PassengerModel(
        userName: data.data()?['userName'],
        userId: data.data()?['userId'],
        profileImage: data.data()?['profileImage'],
        payment: data.data()?['payment'],
        phoneNumber: data.data()?['phoneNumber'],
        stats: data.data()?['stats'],
        email: data.data()?['email'],
        type: data.data()?['type'],
        longitude: data.data()?["longitude"],
        latitude: data.data()?["latitude"],
        dateTime: data.data()?["dateTime"]
      );
      addUserData(passengerModel);
    }
    return null;
  }
}